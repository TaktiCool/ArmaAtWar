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

DFUNC(registerPlayerAction) = {
    params ["_uid", "_data", "_category"];
    private _varName = format ["%1_%2", _uid, _category];
    private _array = GVAR(ScoreNamespace) getVariable [_varName, []];
    _array pushBack _data;
     GVAR(ScoreNamespace) setVariable [_varName, _array, true];
};

["playerKilled", {
    (_this select 0) params ["_killedUnit", "_instigator"];
    if (side group _killedUnit != side group _instigator) then {
        [getPlayerUID _instigator, [serverTime, (getPlayerUID _killedUnit), side group _killedUnit == side group _instigator], "KILLS"] call FUNC(registerPlayerAction);
    };
}] call CFUNC(addEventhandler);

["playerDied", {
    (_this select 0) params ["_unit"];
    [getPlayerUID _unit, [serverTime], "DEATHS"] call FUNC(registerPlayerAction);
}] call CFUNC(addEventhandler);

["playerRevived", {
    (_this select 0) params ["_unit", "_target"];
    [getPlayerUID _unit, [serverTime, "REVIVED", (getPlayerUID _target)], "MEDICALTREATMENTS"] call FUNC(registerPlayerAction);
}] call CFUNC(addEventhandler);

["playerHealed", {
    (_this select 0) params ["_unit", "_target", "_isMedic"];
    [getPlayerUID _unit, [serverTime, "HEALED", (getPlayerUID _target), _isMedic], "MEDICALTREATMENTS"] call FUNC(registerPlayerAction);
}] call CFUNC(addEventhandler);

["sectorSideChanged", {
    (_this select 0) params ["_sector", "_lastSide", "_side"];
    if (_lastSide != sideUnknown) then {
        private _attackerSide = _sector getVariable ["attackerSide", sideUnknown];
        {
            if (_x call EFUNC(Common,isAlive) && isNull objectParent _x) then {
                [getPlayerUID _x, [serverTime, str _sector, "NEUTRALIZED"], "SECTORCAPTURES"] call FUNC(registerPlayerAction);
            };

        } count (_sector getVariable [format ["units%1", _attackerSide], []]);
    } else {
        {
            if (_x call EFUNC(Common,isAlive) && isNull objectParent _x) then {
                [getPlayerUID _x, [serverTime, str _sector, "CAPTURED"], "SECTORCAPTURES"] call FUNC(registerPlayerAction);
            };
        } count (_sector getVariable [format ["units%1", _side], []]);
    };
}] call CFUNC(addEventhandler);

private _nbrSides = {
    private _c = {_x call EFUNC(Common,isAlive) && isNull objectParent _x} count (_sector getVariable [format ["units%1", _x], []]);
    _force pushBack [_c, _x];
    true;
} count _activeSides;
