#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Update a RscListNBox with new values.

    Parameter(s):
    0: IDC of the control <Number>
    1: Array of data ["Name", _data, "/icon"] <Array>

    Returns:
    The selected data <Any>
*/
params ["_idc", "_allData", ["_selectedValue", nil]];

disableSerialization;

if (isNil "_selectedValue") then {
    private _selectedEntry = lnbCurSelRow _idc;
    private _selectedValue = [[_idc, [_selectedEntry, 0]] call CFUNC(lnbLoad), nil] select (_selectedEntry == -1);
};

private _addedData = [];
lnbClear _idc;
{
    _x params ["_textRows", "_data", "_icon"];

    private _rowNumber = lnbAddRow [_idc, _textRows];
    [_idc, [_rowNumber, 0], _data] call CFUNC(lnbSave);
    _addedData pushBack _data;

    if (!isNil "_icon") then {
        lnbSetPicture [_idc, [_rowNumber, 0], _icon];
    };

    if (_data isEqualTo _selectedValue) then {
        lnbSetCurSelRow [_idc, _rowNumber];
    };

    nil
} count _allData;

if ((lnbSize _idc select 0) == 0) then {
    lnbSetCurSelRow [_idc, -1];
    _selectedValue = nil;
} else {
    if (isNil "_selectedValue" || {!(_selectedValue in _addedData)}) then {
        lnbSetCurSelRow [_idc, 0];
        _selectedValue = [_idc, [0, 0]] call CFUNC(lnbLoad);
    };
};

_selectedValue