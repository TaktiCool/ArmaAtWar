#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Initialize the

    Parameter(s):
    None

    Returns:
    None
*/

["sideChanged", {
    {
        [_x] call FUNC(drawSector);
        nil
    } count GVAR(allSectorsArray);
}] call CFUNC(addEventhandler);

["sectorSideChanged", {
    {
        [_x] call FUNC(drawSector);
        nil
    } count GVAR(allSectorsArray);
}] call CFUNC(addEventhandler);

[{
    {
        [_x] call FUNC(drawSector);
        nil
    } count GVAR(allSectorsArray);
}, {
    !isNil QGVAR(ServerInitDone) && {GVAR(ServerInitDone)}
},[]] call CFUNC(waitUntil);
