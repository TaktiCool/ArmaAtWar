#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init for Rally System for Leaders

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(Rally), missionConfigFile >> "PRA3" >> "CfgSquadRallyPoint"] call CFUNC(loadSettings);

/*
 * ACTIONS
 */
["Create Rally Point", PRA3_Player, 0, {
    [QGVAR(isRallyPlaceable), FUNC(canPlaceRally), [], 5, QGVAR(ClearRallyPlaceable)] call CFUNC(cachedCall);
}, {
    QGVAR(ClearRallyPlaceable) call CFUNC(localEvent);
    call FUNC(placeRally);
}] call CFUNC(addAction);
