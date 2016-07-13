#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    [Description]

    Parameter(s):
    0: Argument Name <TYPE>

    Returns:
    0: Return Name <TYPE>
*/
[PRA3_Player, ["isSwimming"]] call CFUNC(canInteractWith);
["inNotVehicle", {
    vehicle _unit != _unit
}] call CFUNC(addCanInteractWith);
["isNotSwimming", {
    !underwater _unit
}] call CFUNC(addCanInteractWith);

["isNotDead", {
    !alive _unit
}] call CFUNC(addCanInteractWith);
["notOnMap", {
    !visibleMap
}] call CFUNC(addCanInteractWith);
