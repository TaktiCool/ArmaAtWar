#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, BadGuy

    Description:
    Logistic system

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(DraggableClasses) = ["Thing"];
GVAR(CargoClasses) = ["AllVehicles", "Thing"];

["missionStarted", {
    {
        private _side = _x;
        private _cfg = QUOTE(PREFIX/CfgLogistics/) + ([format [QUOTE(PREFIX/Sides/%1/logistics), _side], ""] call CFUNC(getSetting));
        //private _cfg = (missionConfigFile >> QPREFIX >> "Sides" >> _side >> "cfgLogistic");
        private _objects = [_cfg + "/objectToSpawn"] call CFUNC(getSetting);

        _objects = _objects apply {
            private _obj = missionNamespace getVariable [_x, objNull];
            // dont allow Loading in the Create Crate Objects
            _obj setVariable ["cargoCapacity", 0];
            _obj
        };

        {
            private _subcfg = _cfg + "/" + _x;
            private _content = [_subcfg + "/content"] call CFUNC(getSetting);
            private _className = [_subcfg + "/classname"] call CFUNC(getSetting);
            private _clearOnSpawn = [_subcfg + "/removeDefaultLoadout"] call CFUNC(getSetting);
            private _displayName = [_subcfg + "/displayName"] call CFUNC(getSetting);
            private _resources = [_subcfg + "/resources", 0] call CFUNC(getSetting);
            if (_displayName call CFUNC(isLocalised)) then {
                _displayName = LOC(_displayName);
            };
            [
                format ["%1 (%2)", _displayName, _resources],
                _objects,
                3,
                compile format ["(str playerside) == ""%1""", _side],
                {
                    params ["_targetPos", "", "", "_args"];
                    _args params ["_crateType", ["_content", []], "_clearOnSpawn", "_displayName", "_resources"];
                    if (missionNamespace getVariable [format [QGVAR(sideResources_%1), side group CLib_player], 0] >= _resources) then {
                        ["spawnCrate", [_args, getPos _targetPos]] call CFUNC(serverEvent);
                    } else {
                        ["RESOURCES INSUFFICIENT", "You need more resources"] call EFUNC(Common,displayHint);
                    };

                },
                ["arguments", [_className, _content, _clearOnSpawn isEqualTo 1, _displayName, _resources]]
            ] call CFUNC(addAction);

            nil
        } count ([_cfg] call CFUNC(getSettingSubClasses));
        nil
    } count ([QUOTE(PREFIX/Sides)] call CFUNC(getSettingSubClasses));
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
    isNull (_target getVariable [QGVAR(Dragger), objNull])
}] call CFUNC(addCanInteractWith);
