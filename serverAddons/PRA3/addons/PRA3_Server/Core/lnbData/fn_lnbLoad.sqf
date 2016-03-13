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
private _hashes = GVAR(lnbDataStorage) getVariable QGVAR(allVariablesCache);
private _hash = lnbData [_idc,_rowAndColum];

if !(_hash in _hashes) exitWith {""};

GVAR(lnbDataStorage) getVariable (format [QGVAR(%1), _hash]);
