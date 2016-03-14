#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/
private _currentSide = side group PRA3_Player;
private _otherSide = call compile ((GVAR(competingSides) select { _x != str _currentSide }) select 0);

[{
    params ["_currentSide", "_otherSide"];

    //@todo think about restrictions

    // This does not update playerSide (at least until next spawn)
    [PRA3_Player] join (createGroup _otherSide);

    [QGVAR(updateTeamInfo)] call CFUNC(localEvent);
    [QGVAR(updateSquadList), str _currentSide] call CFUNC(targetEvent);
    [QGVAR(updateDeploymentList)] call CFUNC(localEvent);
}, [_currentSide, _otherSide]] call CFUNC(mutex);
