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

GVAR(sideNamespace) = false call CFUNC(createNamespace);
/*
 * ACTIONS
*/
{
    private _objectType = getText (_x >> "FOBBoxObject");
    //private _fobObjectTypes = getArray (_x >> "FOBObjects");
    [QLSTRING(PlaceFOB), _objectType, 3, {
        [QGVAR(isFOBPlaceable), FUNC(canPlace), [_target], 5, QGVAR(ClearFOBPlaceable)] call CFUNC(cachedCall) && {(GVAR(sideNamespace) getVariable (toLower str side group CLib_Player)) == typeOf _target}
    }, {
        [_this select 0] call FUNC(place);
        {QGVAR(ClearFOBPlaceable) call CFUNC(localEvent);} call CFUNC(execNextFrame);
    }] call CFUNC(addAction);

    GVAR(sideNamespace) setVariable [toLower configName _x, _objectType];
    /*
    [QLSTRING(FOBTakeDown), (_fobObjectTypes select 0) select 0, 3, {
        (_target getVariable [QGVAR(pointId), ""]) != ""
    }, {
        [_this select 0] call FUNC(destroy);
    }] call CFUNC(addAction);
    */
    nil
} count ("true" configClasses (missionConfigFile >> QPREFIX >> "Sides"));

call FUNC(destroyAction);
call FUNC(defuseAction);
