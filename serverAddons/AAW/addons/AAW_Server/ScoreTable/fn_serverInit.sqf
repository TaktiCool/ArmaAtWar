#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Server Init for ScoreTable system

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(ScoreNamespace) = true call CFUNC(createNamespace);
publicVariable QGVAR(ScoreNamespace);

GVAR(ScoreBuffer) = [];

DFUNC(publicScores) = {
    params ["_uid", "_entry", ["_forceUpdate", false]];

    private _oldEntry = GVAR(ScoreNamespace) getVariable [_uid + "_SCORES_SERVER", [0, 0, 0, 0, 0]];
    if (!(_entry isEqualTo _oldEntry)) then {
        GVAR(ScoreNamespace) setVariable [_uid + "_SCORES_SERVER", _entry];
        GVAR(ScoreBuffer) pushBackUnique _uid;
        if (count GVAR(ScoreBuffer) == 1) then {
            private _waitTime = [3, 0] select _forceUpdate;
            [{
                {
                    private _entry = GVAR(ScoreNamespace) getVariable [_x + "_SCORES_SERVER", [0, 0, 0, 0, 0]];
                    GVAR(ScoreNamespace) setVariable [_x + "_SCORES", _entry, true];
                } count GVAR(ScoreBuffer);
                GVAR(ScoreBuffer) = [];
                [QGVAR(ScoreUpdate)] call CFUNC(globalEvent);
            }, _waitTime] call CFUNC(wait);
        };
    };
};

DFUNC(calcScores) = {
    params ["_uid", ["_forceUpdate", false]];

    private _numberOfKills = {
        _x params ["_time", "_killedUnitUid", "_friendlyFire"];
        (_time < (time + 60) && !_friendlyFire) || _forceUpdate;
    } count (GVAR(ScoreNamespace) getVariable [_uid + "_KILLS", []]);

    private _numberOfFFKills = {
        _x params ["_time", "_killedUnitUid", "_friendlyFire"];
        _friendlyFire;
    } count (GVAR(ScoreNamespace) getVariable [_uid + "_KILLS", []]);

    private _numberOfDeaths = count (GVAR(ScoreNamespace) getVariable [_uid + "_DEATHS", []]);

    private _medicalTreatments = (GVAR(ScoreNamespace) getVariable [_uid + "_MEDICALTREATMENTS", []]);
    private _numberOfRevives = {_uid != (_x select 2) && {(_x select 1) == "REVIVED"}} count _medicalTreatments;
    private _numberOfHeals = {_uid != (_x select 2) && {(_x select 1) == "HEALED"}} count _medicalTreatments;

    private _numberOfVehicleKills = {
        _x params ["_time", "_vehicleType", "_friendlyFire"];
        !_friendlyFire
    } count (GVAR(ScoreNamespace) getVariable [_uid + "_VEHICLEKILLS", []]);

    private _numberOfFFVehicleKills = {
        _x params ["_time", "_vehicleType", "_friendlyFire"];
        _friendlyFire
    } count (GVAR(ScoreNamespace) getVariable [_uid + "_VEHICLEKILLS", []]);

    private _captureScore = count (GVAR(ScoreNamespace) getVariable [_uid + "_SECTORCAPTURES", []]);

    private _entry = [
        _numberOfKills - _numberOfFFKills,
        _numberOfVehicleKills - _numberOfFFVehicleKills,
        _numberOfDeaths,
        _numberOfHeals + 5 * _numberOfRevives,
        _captureScore * 10,
        (_numberOfRevives * 5 + _numberOfHeals * 1 + _numberOfKills * 10 - _numberOfFFKills * 20 + _captureScore * 10 + 50 * _numberOfVehicleKills - 50 * _numberOfFFVehicleKills)
    ];

    [_uid, _entry, _forceUpdate] call FUNC(publicScores);
};

DFUNC(registerPlayerAction) = {
    params ["_uid", "_data", "_category"];
    private _varName = format ["%1_%2", _uid, _category];
    private _array = GVAR(ScoreNamespace) getVariable [_varName, []];
    _array pushBack _data;
    GVAR(ScoreNamespace) setVariable [_varName, _array];
};

["playerKilled", {
    (_this select 0) params ["_killedUnit", "_instigator"];
    private _friendlyFire = side group _killedUnit == side group _instigator;
    private _uid = getPlayerUID _instigator;
    [_uid, [time, (getPlayerUID _killedUnit), _friendlyFire], "KILLS"] call FUNC(registerPlayerAction);
    [{
        [_this] call FUNC(calcScores);
    }, 60, _uid] call CFUNC(wait);
}] call CFUNC(addEventhandler);

["playerDied", {
    (_this select 0) params ["_unit"];
    private _uid = getPlayerUID _unit;
    [_uid, [time], "DEATHS"] call FUNC(registerPlayerAction);
    [_uid] call FUNC(calcScores);
}] call CFUNC(addEventhandler);

["playerRevived", {
    (_this select 0) params ["_unit", "_target"];
    private _uid = getPlayerUID _unit;
    [_uid, [time, "REVIVED", (getPlayerUID _target)], "MEDICALTREATMENTS"] call FUNC(registerPlayerAction);
    [_uid] call FUNC(calcScores);
}] call CFUNC(addEventhandler);

["playerHealed", {
    (_this select 0) params ["_unit", "_target", "_isMedic"];
    private _uid = getPlayerUID _unit;
    [_uid, [time, "HEALED", (getPlayerUID _target), _isMedic], "MEDICALTREATMENTS"] call FUNC(registerPlayerAction);
    [_uid] call FUNC(calcScores);
}] call CFUNC(addEventhandler);

["endMission", {
    {
        [getPlayerUID _x, true] call FUNC(calcScores);
    } count allPlayers;
}] call CFUNC(addEventhandler);

["sectorSideChanged", {
    (_this select 0) params ["_sector", "_lastSide", "_side"];
    if (_lastSide != sideUnknown) then {
        private _attackerSide = _sector getVariable ["attackerSide", sideUnknown];
        {
            if (_x call EFUNC(Common,isAlive) && isNull objectParent _x) then {
                [getPlayerUID _x, [time, str _sector, "NEUTRALIZED"], "SECTORCAPTURES"] call FUNC(registerPlayerAction);
                [getPlayerUID _x] call FUNC(calcScores);
            };
        } count (_sector getVariable [format ["units%1", _attackerSide], []]);
    } else {
        {
            if (_x call EFUNC(Common,isAlive) && isNull objectParent _x) then {
                [getPlayerUID _x, [time, str _sector, "CAPTURED"], "SECTORCAPTURES"] call FUNC(registerPlayerAction);
                [getPlayerUID _x] call FUNC(calcScores);
            };
        } count (_sector getVariable [format ["units%1", _side], []]);
    };
}] call CFUNC(addEventhandler);

addMissionEventHandler ["EntityKilled", {
    params ["_killedEntity", "_killer"];
    if (!(_killedEntity isKindOf "Man") && (_killer in allPlayers)) then {
        private _uid = getPlayerUID _killer;
        private _friendlyFire = (_killedEntity getVariable ["side", "unknown"]) == str side group _killer;
        [_uid, [time, typeOf _killedEntity, _friendlyFire], "VEHICLEKILLS"] call FUNC(registerPlayerAction);
        [_uid] call FUNC(calcScores);
    };
}];
