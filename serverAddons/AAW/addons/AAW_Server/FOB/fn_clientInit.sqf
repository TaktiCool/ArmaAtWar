#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas, NetFusion

    Description:
    Init FOB system

    Parameter(s):
    None

    Returns:
    None
*/

[QGVAR(FOB), missionConfigFile >> QPREFIX >> "cfgFOB"] call CFUNC(loadSettings);

GVAR(sideNamespace) = false call CFUNC(createNamespace);

[QGVAR(placed), {QGVAR(ClearFOBPlaceable) call CFUNC(localEvent)}] call CFUNC(addEventhandler); // clear Cached Call Space

/*
 * ACTIONS
*/
{
    private _objectType = getText (_x >> "FOBBoxObject");
    _objectType call FUNC(buildAction); // Add Build Action

    GVAR(sideNamespace) setVariable [toLower configName _x, _objectType];
    nil
} count ("true" configClasses (missionConfigFile >> QPREFIX >> "Sides"));

call FUNC(dismantleAction);
call FUNC(destroyAction);
call FUNC(defuseAction);
