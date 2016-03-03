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
["Killed", {
    DUMP(_this)
    params ["_args"];
    _args params ["_unit"];


    createDialog QEGVAR(UI,RespawnScreen);
}] call CFUNC(addEventHandler);