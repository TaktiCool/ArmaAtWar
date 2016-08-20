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
params ["_decompressedString", ["_compression", "LZW"]];
private _output = "";

switch (_compression) do {
    case ("LZW"): {
        if (isNil QGVAR(CompressionDictionary)) then {
            GVAR(CompressionDictionary) = [];
            for "_i" from 0 to (SYMBOL_OFFSET-1) do {
                GVAR(CompressionDictionary)  pushBack toString [_i];
            };
        };
        private _dict = +GVAR(CompressionDictionary);
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
    };
    case ("LZ77"): {
        private _window = '';
        {
            if (_x < 1024) then {
                private _c = toString [_x];
                _output = _output + _c;
                _window = _window + _c;
            } else {
                private _length = floor (_x/1024);
                private _offset = _x - (_length*1024);
                _length = _length + 1;
                private _word = _window select [_offset, _length];
                _output = _output + _word;
                _window = _window + _word;
            };

            if (count _window > 1025) then {
                _window = _window select [count _window - 1025, 1025];
            };
            nil
        } count toArray _decompressedString;
    };
};


_output;
