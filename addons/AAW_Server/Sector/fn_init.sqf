#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy, joko // Jonas

    Description:
    Initialize the

    Parameter(s):
    None

    Returns:
    None
*/

private _fncDrawAllSectors = {
    {
        [_x] call FUNC(drawSector);
        nil
    } count GVAR(allSectorsArray);
};

["sideChanged", _fncDrawAllSectors] call CFUNC(addEventhandler);

["sectorSideChanged", _fncDrawAllSectors] call CFUNC(addEventhandler);

["missionStarted", {
    params ["", "_fncDrawAllSectors"];

    [_fncDrawAllSectors, {
        !isNil QGVAR(ServerInitDone) && {GVAR(ServerInitDone)}
    }, []] call CFUNC(waitUntil);
}, _fncDrawAllSectors] call CFUNC(addEventhandler);
