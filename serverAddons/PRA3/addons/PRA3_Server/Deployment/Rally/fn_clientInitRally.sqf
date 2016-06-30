#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init rally system

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(Rally), missionConfigFile >> "PRA3" >> "CfgSquadRallyPoint"] call CFUNC(loadSettings);

[QGVAR(pointRemoved), {
    (_this select 0) params ["_pointId"];
    DUMP(_this)

    if (((group PRA3_Player) getVariable [QGVAR(rallyId), ""]) == _pointId) then {
        (group PRA3_Player) setVariable [QGVAR(rallyId), nil, true];
    };
}] call CFUNC(addEventHandler);

/*
 * ACTIONS
 */
["Create Rally Point", PRA3_Player, 0, {
    [QGVAR(isRallyPlaceable), FUNC(canPlaceRally), [], 5, QGVAR(ClearRallyPlaceable)] call CFUNC(cachedCall);
}, {
    QGVAR(ClearRallyPlaceable) call CFUNC(localEvent);
    call FUNC(placeRally);
}] call CFUNC(addAction);
