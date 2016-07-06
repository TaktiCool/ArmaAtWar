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
[QGVAR(FOB), missionConfigFile >> "PRA3" >> "cfgFOB"] call CFUNC(loadSettings);

/*
 * ACTIONS
 */
["Create FOB", "CargoNet_01_ammo_base_F", 3, {
    [QGVAR(isFOBPlaceable), FUNC(canPlaceFOB), [_target], 5, QGVAR(ClearFOBPlaceable)] call CFUNC(cachedCall);
}, {
    QGVAR(ClearFOBPlaceable) call CFUNC(localEvent);
    [_target] call FUNC(placeFOB);
}] call CFUNC(addAction);
