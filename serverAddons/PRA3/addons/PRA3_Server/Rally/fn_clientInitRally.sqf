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
[QGVAR(Rally), missionConfigFile >> QPREFIX >> "cfgSquadRallyPoint"] call CFUNC(loadSettings);

[QGVAR(pointRemoved), {
    (_this select 0) params ["_pointId"];
    DUMP(_this)

    if (((group CLib_Player) getVariable [QGVAR(rallyId), ""]) == _pointId) then {
        (group CLib_Player) setVariable [QGVAR(rallyId), nil, true];
    };
}] call CFUNC(addEventHandler);

/*
 * ACTIONS
 */
[QLSTRING(CreateRally), CLib_Player, 0, {
    [QGVAR(isRallyPlaceable), FUNC(canPlaceRally), [], 5, QGVAR(ClearRallyPlaceable)] call CFUNC(cachedCall);
}, {
    call FUNC(placeRally);
    {QGVAR(ClearRallyPlaceable) call CFUNC(localEvent);} call CFUNC(execNextFrame);
}] call CFUNC(addAction);
