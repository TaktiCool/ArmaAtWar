#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas, BadGuy

    Description:
    Logistic system

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(DragableClasses) = [];
{
    GVAR(DragableClasses) pushBack configName _x;
    nil
} count ("getNumber (_x >> ""isDragable"") == 1" configClasses (missionConfigFile >> QPREFIX >> "CfgEntities"));

GVAR(CargoClasses) = [];
{
    GVAR(CargoClasses) pushBack configName _x;
    nil
} count ("getNumber (_x >> ""cargoCapacity"") > 0" configClasses (missionConfigFile >> QPREFIX >> "CfgEntities"));

["missionStarted", {
    {
        private _side = configName _x;
        private _cfg = (missionConfigFile >> QPREFIX >> "Sides" >> _side >> "cfgLogistic");
        private _objects = getArray (_cfg >> "objectToSpawn");

        _objects = _objects apply {
            private _obj = missionNamespace getVariable [_x, objNull];
            // dont allow Loading in the Create Crate Objects
            _obj setVariable ["cargoCapacity", 0];
            _obj
        };

        {
            private _content = getArray (_x >> "content");
            private _className = getText (_x >> "classname");
            private _clearOnSpawn = getNumber (_x >> "removeDefaultLoadout");
            private _displayName = getText (_x >> "displayName");
            if (_displayName call CFUNC(isLocalised)) then {
                _displayName = LOC(_displayName);
            };
            [
                _displayName,
                _objects,
                3,
                compile format ["(str playerside) == ""%1""", _side],
                {
                    params ["_targetPos", "", "", "_args"];
                    ["spawnCrate", [_args, getPos _targetPos]] call CFUNC(serverEvent);
                },
                ["arguments", [_className, _content, _clearOnSpawn isEqualTo 1, _displayName]]
            ] call CFUNC(addAction);

            nil
        } count (configProperties [_cfg, "isClass _x"]);
        nil
    } count ("true" configClasses (missionConfigFile >> QPREFIX >> "Sides"));
}] call CFUNC(addEventHandler);

["unconsciousnessChanged", {
    if (!isNull (CLib_Player getVariable [QGVAR(Item), objNull])) then {
        CLib_Player call FUNC(dropObject);
    };
}] call CFUNC(addEventhandler);

["isNotDragging", {
    isNull (_caller getVariable [QGVAR(Item), objNull])
     && isNull (_target getVariable [QGVAR(Item), objNull])
}] call CFUNC(addCanInteractWith);

["isNotDragged", {
    isNull (_target getVariable [QGVAR(Player), objNull])
}] call CFUNC(addCanInteractWith);
