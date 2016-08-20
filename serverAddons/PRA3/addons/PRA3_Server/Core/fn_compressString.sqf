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
params ["_inputStr", ["_compression", "LZW"]];
private _output = "";

switch (_compression) do {
    case ("LZW"): {
        private _dict = [];
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
    };
    case ("LZ77"): {
        private _window = '';
        private _n = count _inputStr;
        private _c = '';
        private _k = 0;
        private _l = 1;
        private _lastIdx = 0;
        private _idx = 0;
        {
            _c = _inputStr select [_k,_l+1];
            _idx = _window find _c;
            if (_idx >= 0 && _l <= 53) then {
                _l = _l + 1;
                _lastIdx = _idx;
            } else {
                _window = _window + (_c select [0, _l]);
                if (_l > 1) then {
                    private _codeWord = (_l-1)*1024;
                    _codeWord = _codeWord + _lastIdx;
                    _output = _output + toString [_codeWord];
                    _k=_k+_l-1;
                    _l = 1;
                } else {
                    _output = _output + (_c select [0, _l]);
                };

                if (count _window > 1025) then {
                    _window = _window select [count _window - 1025, 1025];
                };
                 _k = _k + _l;
            };
        } count toArray _inputStr;

        if (_idx >= 0 && _l <= 53) then {
            private _codeWord = (_l-2)*1024;
            _codeWord = _codeWord + _lastIdx;
            _output = _output + toString [_codeWord];
        } else {
            _output = _output + (_c select [0, _l]);
        };
    };
};

_output;
