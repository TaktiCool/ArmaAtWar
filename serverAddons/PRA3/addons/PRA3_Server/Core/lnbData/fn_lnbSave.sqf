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
private _hashes = GVAR(lnbDataStorage) getVariable QGVAR(allVariablesCache);

private _hash = format ["%1%2%3%4%5%6%7%8%9%10", random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100];

while {_hash in _hashes} do {
    _hash = format ["%1%2%3%4%5%6%7%8%9%10", random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100, random 100];
};

GVAR(lnbDataStorage) setVariable [format [QGVAR(%1), _hash], _data];

lnbSetData [_idc, _rowAndColum, _hash];

_hashes pushBack _hash;
GVAR(lnbDataStorage) setVariable [QGVAR(allVariablesCache), _hashes];

if (isNil QGVAR(lnbDataPFHID)) then {
    // PFH for Flushing Data
    GVAR(lnbDataPFHID) = [{
        if (!dialog) then {
            private _allVars = GVAR(lnbDataStorage) getVariable QGVAR(allVariablesCache);
            // Flush Data
            {
                GVAR(lnbDataStorage) setVariable [_x, nil];
            } count _allVars;
            GVAR(lnbDataStorage) setVariable [QGVAR(allVariablesCache), []];
            [GVAR(lnbDataPFHID)] call CFUNC(removePerFrameHandler);
            GVAR(lnbDataPFHID) = nil;
        };
    }, 1] call CFUNC(addPerFrameHandler);
};
