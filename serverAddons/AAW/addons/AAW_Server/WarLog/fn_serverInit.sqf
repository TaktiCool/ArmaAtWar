#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Server Init for WarLog system

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(wsServer) = "tcp://warlog.atwar-mod.com:8888";

DFUNC(enqueueRequest) = {
    if (GVAR(connectionId) == "error") exitWith {};
    ["CLibSocket", "Send", format ["%1:%2", GVAR(connectionId), _this joinString ":"]] call CFUNC(callExtension);
};

[{
    ["CLibSocket", "IsConnected", GVAR(connectionId), {
        params ["_connected"];
        if (_connected == "false") then {
            ["CLibSocket", "Connect", GVAR(wsServer), {
                params ["_newConnectionId"];
                GVAR(connectionId) = _newConnectionId;
                ["SERVER"] call FUNC(enqueueRequest);
            }] call CFUNC(callExtension);
        };
    }] call CFUNC(callExtension);
}, 5] call CFUNC(addPerFrameHandler);

GVAR(connectionId) = [-1, "CLibSocket", "Connect", GVAR(wsServer)] call CFUNC(extensionRequest);
["SERVER"] call FUNC(enqueueRequest);

["playerKilled", {
    (_this select 0) params ["_killedUnit", "_instigator"];
    private _friendlyFire = side group _killedUnit == side group _instigator;
    private _uid = getPlayerUID _instigator;
    ["KILLS", _uid, time, (getPlayerUID _killedUnit), _friendlyFire] call FUNC(enqueueRequest);
}] call CFUNC(addEventhandler);

["playerDied", {
    (_this select 0) params ["_unit"];
    private _uid = getPlayerUID _unit;
    ["DEATHS", _uid, time] call FUNC(enqueueRequest);
}] call CFUNC(addEventhandler);

["playerRevived", {
    (_this select 0) params ["_unit", "_target"];
    private _uid = getPlayerUID _unit;
    ["MEDICALTREATMENTS", _uid, time, "REVIVED", (getPlayerUID _target)] call FUNC(enqueueRequest);
}] call CFUNC(addEventhandler);

["playerHealed", {
    (_this select 0) params ["_unit", "_target", "_isMedic"];
    private _uid = getPlayerUID _unit;
    ["MEDICALTREATMENTS", _uid, time, "HEALED", (getPlayerUID _target), _isMedic] call FUNC(enqueueRequest);
}] call CFUNC(addEventhandler);

["sectorSideChanged", {
    (_this select 0) params ["_sector", "_lastSide", "_side"];
    if (_lastSide != sideUnknown) then {
        private _attackerSide = _sector getVariable ["attackerSide", sideUnknown];
        {
            if (_x call EFUNC(Common,isAlive) && isNull objectParent _x) then {
                ["SECTORCAPTURES", getPlayerUID _x, time, str _sector, "NEUTRALIZED"] call FUNC(enqueueRequest);
            };
        } count (_sector getVariable [format ["units%1", _attackerSide], []]);
    } else {
        {
            if (_x call EFUNC(Common,isAlive) && isNull objectParent _x) then {
                ["SECTORCAPTURES", getPlayerUID _x, time, str _sector, "CAPTURED"] call FUNC(enqueueRequest);
            };
        } count (_sector getVariable [format ["units%1", _side], []]);
    };
}] call CFUNC(addEventhandler);
