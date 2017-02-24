#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas, NetFusion

    Description:
    Init rally system

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(Rally), missionConfigFile >> QPREFIX >> "cfgSquadRallyPoint"] call CFUNC(loadSettings);

[QGVAR(deploymentPointRemoved), {
    (_this select 0) params ["_pointId"];
    DUMP(_this);

    if (((group CLib_Player) getVariable [QGVAR(rallyId), ""]) == _pointId) then {
        (group CLib_Player) setVariable [QGVAR(rallyId), nil, true];
    };
    QGVAR(ClearRallyPlaceable) call CFUNC(globalEvent);
}] call CFUNC(addEventHandler);

/*
 * ACTIONS
 */
[QLSTRING(CreateRally), CLib_Player, 0, {
    (CLib_Player getVariable [QEGVAR(Kit,isLeader), false]) && !(isNull objectParent CLib_Player)
}, {
    call FUNC(place);
}] call CFUNC(addAction);

[QGVAR(placed), {
    QGVAR(ClearRallyPlaceable) call CFUNC(globalEvent);
}] call CFUNC(addEventHandler);
