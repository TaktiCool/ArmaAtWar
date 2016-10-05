#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init FOB system

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(FOB), missionConfigFile >> QPREFIX >> "cfgFOB"] call CFUNC(loadSettings);

/*
 * ACTIONS
 */
[MLOC(PlaceFOB), "CargoNet_01_ammo_base_F", 3, {
    [QGVAR(isFOBPlaceable), FUNC(canPlaceFOB), [_target], 5, QGVAR(ClearFOBPlaceable)] call CFUNC(cachedCall);
}, {
    QGVAR(ClearFOBPlaceable) call CFUNC(localEvent);
    [_this select 0] call FUNC(placeFOB);
}] call CFUNC(addAction);

[MLOC(FOBTakeDown), "CargoNet_01_ammo_base_F", 3, {
    (_target getVariable [QGVAR(pointId), ""]) != ""
}, {
    [_this select 0] call FUNC(destroyFOB);
}] call CFUNC(addAction);
