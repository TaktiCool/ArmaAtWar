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

        if (_settings in "spawnPoint") then {
            private _spawnPos = _settings get "spawnPoint";
            if (_spawnPos isEqualType "") {
                private _possibleSpawnObject = missionNamespace getVariable [_spawnPos, objNull];
                if !(isNull _possibleSpawnObject) then {
                    _spawnPos = getPos _possibleSpawnObject;
                } else {
                    _spawnPos = getMarkerPos _spawnPos;
                };
            };
            [
                _x getVariable ["name", "EROR"],
                "SECTOR",
                _spawnPos,
                true,
                -1,
                "A3\ui_f\data\map\markers\military\dot_ca.paa",
                "A3\ui_f\data\map\markers\military\dot_ca.paa"
            ] call FUNC(addDeploymentPoint);
        };
    } forEach EGVAR(Sector,allSectorsArray);
}, {
    !isNil QEGVAR(Sector,allSectorsArray)
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
    private _sector = [_pointId] call EFUNC(Sector,getSector);
    private _sectorSpawnPoint = GVAR(sectorData) get _pointId;
    private _side = _sector getVariable ["side", sideUnknown];
    _side isNotEqualTo sideUnknown && !(_sector call EFUNC(Sector,isCaptureable));
}] call EFUNC(Common,registerDeploymentPointTypeCallback);

["sectorSideChanged", {
    [_id, _x select 0, _x select 1] call FUNC(setDeploymentPointData);

    [UIVAR(RespawnScreen_DeploymentManagement_update)] call CFUNC(globalEvent);
    [QEGVAR(Common,updateMapIcons)] call CFUNC(localEvent);
}] call CFUNC(addEventhandler);
