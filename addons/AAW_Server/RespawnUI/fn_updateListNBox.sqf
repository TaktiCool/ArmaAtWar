#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Update a RscListNBox with new values.

    Parameter(s):
    0: IDC of the control <Number>
    1: Array of data ["Name", _data, "/icon"] <Array>

    Returns:
    The selected data <Any>
*/
params ["_control", "_allData", "_selectedValue"];

if (isNil "_selectedValue") then {
    private _selectedEntry = lnbCurSelRow _control;
    _selectedValue = [[_control, [_selectedEntry, 0]] call CFUNC(lnbLoad), nil] select (_selectedEntry == -1);
};

private _addedData = [];
lnbClear _control;
{
    _x params ["_textRows", "_data", "_icon", "_color"];

    private _rowNumber = _control lnbAddRow _textRows;
    [_control, [_rowNumber, 0], _data] call CFUNC(lnbSave);
    _addedData pushBack _data;

    if (!isNil "_icon") then {
        _control lnbSetPicture [[_rowNumber, 0], _icon];
    };

    if (!isNil "_color") then {
        for "_i" from 0 to (((lnbSize _control) select 1) - 1) do {
            _control lnbSetColor [[_rowNumber, _i], _color];
        };
    };

    if (_data isEqualTo _selectedValue && lnbCurSelRow _control != _rowNumber) then {
        _control lnbSetCurSelRow _rowNumber;
    };

    nil
} count _allData;

if ((lnbSize _control select 0) == 0) then {
    _control lnbSetCurSelRow -1;
    _selectedValue = nil;
} else {
    if (isNil "_selectedValue" || {!(_selectedValue in _addedData)}) then {
        _control lnbSetCurSelRow -1;
        _selectedValue = [_control, [0, 0]] call CFUNC(lnbLoad);
    };
};

_selectedValue
