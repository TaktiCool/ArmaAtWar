#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Save Data for lnb Data

    Parameter(s):
    0: Controll or IDC from Dialog <Number, Controll>
    1: Row and Colum <Array<Number>>
    2: Data that will saved <Any>

    Returns:
    None
*/
disableSerialization;
params ["_idc", "_rowAndColum", "_data"];

private _hash = GVAR(allVariablesCache) pushBack _data;

lnbSetValue [_idc, _rowAndColum, _hash];
if (isNil QGVAR(lnbDataPFHID)) then {
    // PFH for Flushing Data
    GVAR(lnbDataPFHID) = [{
        if (!dialog) then {
            GVAR(allVariablesCache) = [];
        };
    }, 1] call CFUNC(addPerFrameHandler);
};
