#include "macros.hpp"
/*
    Project Reality ArmA 3 - Core\fn_createNamespace.sqf

    Author: BadGuy

    Description:
    Get Logic Group and create if it not exist

    Parameter(s):
    None

    Returns:
    Logic Gruppe <Group>
*/

private _grp = missionNamespace getVariable [QGVAR(logicGroup),grpNull];
if (isNull _grp) then {
    _grp = createGroup (createCenter sideLogic);
    missionNamespace setVariable [QGVAR(logicGroup),_grp,true];
};

_grp;
