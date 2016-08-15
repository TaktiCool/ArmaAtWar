#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    LZW String Compression

    Parameter(s):
    0: input string <String>

    Returns:
    0: compressed String <String>
*/
#define SYMBOL_OFFSET 256
params ["_inputStr"];


private _dict = [];
private _output = "";
private _buffer = "";
{
    private _c = toString [_x];
    if (_buffer != "") then {
        private _tempBuffer = _buffer + _c;
        if (_tempBuffer in _dict) then {
            _buffer = _tempBuffer;
        } else {
            private _symbol = _dict find _buffer;
            if (_symbol>=0) then {
                _output = _output + toString [SYMBOL_OFFSET + _symbol];
            } else {
                _output = _output + _buffer;
            };
            _dict pushBack (_tempBuffer);
            _buffer = _c;
        };
    } else {
        _buffer = _c;
    };
    nil
} count toArray _inputStr;
private _symbol = _dict find _buffer;
if (_symbol>=0) then {
    _output = _output + toString [SYMBOL_OFFSET + _symbol];
} else {
    _output = _output + _buffer;
};
_output;
