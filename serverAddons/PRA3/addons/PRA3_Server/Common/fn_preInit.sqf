#include "macros.hpp"

// Version Informations
private _missionVersionStr = "";
private _missionVersionAr = getArray(missionConfigFile >> QPREFIX >> "Version");

private _serverVersionStr = "";
private _serverVersionAr = getArray(configFile >> "CfgPatches" >> "PRA3_Server" >> "versionAr");

{
    _missionVersionStr = _missionVersionStr + str(_x) + ".";
    nil
} count _missionVersionAr;

{
    _serverVersionStr = _serverVersionStr + str(_x) + ".";
    nil
} count _serverVersionAr;

// TODO Create Database for Compatible Versions
if (!(_missionVersionAr isEqualTo _serverVersionAr) && (isClass (missionConfigFile >> QPREFIX))) then {
    ["Lost"] call BIS_fnc_endMissionServer
};

_missionVersionStr = _missionVersionStr select [0, (count _missionVersionStr - 1)];
_serverVersionStr = _serverVersionStr select [0, (count _serverVersionStr - 1)];
GVAR(VersionInfo) = [[_missionVersionStr,_missionVersionAr], [_serverVersionStr, _serverVersionAr]];
publicVariable QGVAR(VersionInfo);

#include "PREP.hpp"
