#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Check if all Compression work right

    Parameter(s):
    None

    Returns:
    None
*/
#define AllCompressionTypes ["LZ77", "LZW"]
private _wrongCount = 0;
{
    private _fncName = _x;
    private _originalFunction = (parsingNamespace getVariable _fncName) call CFUNC(codeToString);
    {
        private _compressedFunction = [_originalFunction , _x] call CFUNC(compressString);
        private _decompFunction = _compressedFunction call CFUNC(decompressString);
        if !(_decompFunction isEqualTo _originalFunction) then {
            LOG("Compression Check ERROR: " + _fncName + " " + _x + " compression dont work correct")
            _wrongCount = _wrongCount + 1;
        } else {
            LOG("Compression Check: " + _fncName + " " + _x + " passed Test")
        };
    } count AllCompressionTypes;
    nil
} count GVAR(functionCache);

if (_wrongCount != 0) then {
    hint "A Function Dont Compress Right! Please Check log";
};
