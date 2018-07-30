#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Adds the Infantery Resupply Action

    Parameter(s):
    None

    Returns:
    None
*/


private _title = "Load Supplies";
private _iconIdle = "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_loadDevice_ca.paa";
private _iconProgress = "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_loadDevice_ca.paa";
private _condition = {
    (vehicle CLib_player) getVariable ["supplyCapacity", 0] > ((vehicle CLib_player) getVariable ["supplyPoints", 0]) && {
        ({
            _x distance vehicle CLib_player <= 20 &&
            {toLower (_target getVariable ["side", str sideUnknown]) isEqualTo toLower str side group CLib_player}
        } count GVAR(supplySourceObjects) > 0);
    }
};

private _onStart = {
    CLib_player setVariable[QGVAR(ResupplySupplyActionTime), time + 1];
};

private _onProgress = {

    private _supplyCapacity = (vehicle CLib_player) getVariable ["supplyCapacity", 0];
    private _supplyPoints = (vehicle CLib_player) getVariable ["supplyPoints", 0];

    private _time = CLib_player getVariable[QGVAR(ResupplySupplyActionTime), time];

    if (_time <= time) then {
        [QGVAR(loadSupplies), [vehicle CLib_player, 1000]] call CFUNC(serverEvent);
        CLib_player setVariable[QGVAR(ResupplySupplyActionTime), time+1];
    };

    _supplyPoints/_supplyCapacity;
};

private _onComplete = {



};

private _onInterruption = _onComplete;

["AllVehicles", _title, _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress, _onComplete, _onInterruption, [], 5000, true, false, ["isNotInVehicle", "isNotUnconscious"]] call CFUNC(addHoldAction);
