#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Logistic system

    Parameter(s):
    None

    Returns:
    None
*/

DFUNC(setLogisticVariables) = {
    params ["_entity"];

    private _cargoCapacity = _entity getVariable ["cargoCapacity", 0];

    if (_cargoCapacity > 0) then {

        private _className = typeOf _entity;
        private _tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
        private _tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
        private _tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");
        private _isCargo = (_tb > 0 || _tm > 0 || _tw > 0);

        _entity setVariable ["hasInventory", _isCargo, true];
    };

};
["entityCreated", {
    (_this select 0) call FUNC(setLogisticVariables);
}] call CFUNC(addEventHandler);

["spawnCrate", FUNC(spawnCrate)] call CFUNC(addEventHandler);

["missionStarted", {
    {
        private _cfg = QUOTE(PREFIX/CfgLogistics/) + ([format [QUOTE(PREFIX/Sides/%1/logistics), _x], ""] call CFUNC(getSetting));
        private _resources = [_cfg + "/resources", 100] call CFUNC(getSetting);
        private _resourceGrowth = [_cfg + "/resourceGrowth", [1, 12]] call CFUNC(getSetting);
        missionNamespace setVariable [format [QGVAR(sideResources_%1), _x], _resources, true];
        [{
            (_this select 0) params ["_resourceGrowth", "_side"];
            private _resources = missionNamespace getVariable [format [QGVAR(sideResources_%1), _side], 0];
            _resources = _resources + (_resourceGrowth select 0);
            missionNamespace setVariable [format [QGVAR(sideResources_%1), _side], _resources, true];
        }, _resourceGrowth select 1, [_resourceGrowth, _x]] call CFUNC(addPerFrameHandler);
        nil;
    } count EGVAR(Common,competingSides);
    nil;
}] call CFUNC(addEventHandler);
