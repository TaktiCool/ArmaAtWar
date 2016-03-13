#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Save Data from lnb Data

    Parameter(s):
    0: Controll or IDC from Dialog <Number, Controll>
    1: Row and Colum <Array<Number>>

    Returns:
    Variable from lnbData <Any>
*/
disableSerialization;
params ["_idc", "_rowAndColum"];
private _hash = lnbValue [_idc,_rowAndColum];
if (count GVAR(allVariablesCache) >= _hash) then {
    GVAR(allVariablesCache) select _hash;
};
