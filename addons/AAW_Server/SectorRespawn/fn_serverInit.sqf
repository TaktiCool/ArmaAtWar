#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Initialize the Sector Respawn Module on Client

    Parameter(s):
    None

    Returns:
    None
*/
[{
    {
        private _settings = _x getVariable "settings";
        if ("spawnPoint" in _settings) then {
            private _spawnPos = _settings get "spawnPoint";
            if (_spawnPos isEqualType "") then {
                private _possibleSpawnObject = missionNamespace getVariable [_spawnPos, objNull];
                if !(isNull _possibleSpawnObject) then {
                    _spawnPos = getPos _possibleSpawnObject;
                } else {
                    _spawnPos = getMarkerPos _spawnPos;
                };
            };
            private _side = _x getVariable ["side", sideUnknown];
            private _pointId = [
                _x getVariable ["fullName", "ERROR"],
                "SECTOR",
                _spawnPos,
                _side,
                -1,
                "A3\ui_f\data\map\markers\military\dot_ca.paa",
                "A3\ui_f\data\map\markers\military\dot_ca.paa"
            ] call EFUNC(Common,addDeploymentPoint);
            [_pointId, "sectorName", _x getVariable "name"] call EFUNC(Common,setDeploymentPointData);
            _x setVariable [QGVAR(pointID), _pointId];
        };
    } forEach EGVAR(Sector,allSectorsArray);
}, {
    EGVAR(Sector,ServerInitDone)
}] call CFUNC(waitUntil);


["SECTOR", "onPrepare", {
    params ["_pointId"];
    private _pointDetails = [_pointId, ["position"]] call EFUNC(Common,getDeploymentPointData);
    _pointDetails params [["_pos", [0,0,0]]];
    _pos;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["SECTOR", "onDeploy", {
    params ["_pointId", "_prevRet"];
    if !(isNil "_prevRet") exitWith { _prevRet; };
    true;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["SECTOR", "isLocked", {
    params ["_pointId", "_prevRet"];
    false;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["SECTOR", "isAvailableFor", {
    params ["_pointId", "_prevRet", "_target"];
    if (_target isEqualType objNull) then {
        _target = group _target;
    };
    if (_target isEqualType grpNull) then {
        _target = side _target;
    };
    private _sectorName = [_pointId, "sectorName"] call EFUNC(Common,getDeploymentPointData);
    private _sector = [_sectorName] call EFUNC(Sector,getSector);
    private _side = _sector getVariable ["side", sideUnknown];
    private _spawnable = true;
    {
        private _sector = [_x] call EFUNC(Sector,getSector);
        private _sectorIsCapturable = _sector call EFUNC(Sector,isCaptureable);
        private _sectorIsCaptured = (_sector getVariable ["side", sideUnknown]) isEqualTo _target;
        if (!_sectorIsCaptured && _sectorIsCapturable) then {
            _spawnable = false;
            break;
        };
    } foreach (_sector getVariable ["dependency", []]);
    _side isEqualTo _target && _spawnable;
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["sectorSideChanged", {
    (_this select 0) params ["_sector", "_oldSide", "_newSide"];

    private _pointId = _sector getVariable [QGVAR(pointId), ""];
    if (_pointId != "") then {
        [_pointId, "availableFor", _newSide] call EFUNC(Common,setDeploymentPointData);
    };
    [UIVAR(RespawnScreen_DeploymentManagement_update)] call CFUNC(globalEvent);
    [QEGVAR(Common,updateMapIcons)] call CFUNC(localEvent);
}] call CFUNC(addEventhandler);
