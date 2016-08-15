#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    LZW decompression of a String

    Parameter(s):
    0: compressed string <String>

    Returns:
    0: uncompressed <String>
*/
#define SYMBOL_OFFSET 256
params ["_decompressedString"];

if (isNil QGVAR(CompressionDictionary)) then {
    GVAR(CompressionDictionary) = [];
    for "_i" from 0 to (SYMBOL_OFFSET-1) do {
        PRA3_Core_CompressionDictionary pushBack toString [_i];
    };
};
private _dict = +PRA3_Core_CompressionDictionary;
private _output = "";
private _buffer = "";
{
    private _nbrDict = count _dict;
    private _currentWord = "";
    if (_x < _nbrDict) then {
        _currentWord = _dict select _x;
        if (_buffer != "") then {
            _dict set [_nbrDict, _buffer + (_currentWord select [0,1])];
        };
    } else {
        _currentWord = _buffer + (_buffer select [0,1]);
        _dict set [_x,_currentWord];
    };
    _buffer = _currentWord;
    _output = _output + _currentWord;
    nil
} count toArray _decompressedString;

_output;
