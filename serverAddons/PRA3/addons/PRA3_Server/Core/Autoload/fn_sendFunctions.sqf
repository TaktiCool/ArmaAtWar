#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    [Description]

    Parameter(s):
    0: Client UID <Number>

    Returns:
    None
*/
params ["_clientID"];

///*
// send all Functions if mission Started was not triggered jet
if (isNil QGVAR(missionStartedTriggered)) exitWith {
    {
        private _functionCode = parsingNamespace getVariable [_x, {}];

        // Remove leading and trailing braces from the code.
        _functionCode = _functionCode call CFUNC(codeToString);

        GVAR(receiveFunction) = [_x, _functionCode, _forEachIndex / GVAR(countRequiredFnc)];
        _clientID publicVariableClient QGVAR(receiveFunction);

    } forEach GVAR(RequiredFncClient);
};
//*/
if (isNil QGVAR(SendFunctionsUnitCache)) then {
    GVAR(SendFunctionsUnitCache) = [[_clientID, +GVAR(RequiredFncClient), 0]];
} else {
    GVAR(SendFunctionsUnitCache) pushBack [_clientID, +GVAR(RequiredFncClient), 0];
};

if (isNil QGVAR(PFHSendFunctions)) exitWith {
    GVAR(PFHSendFunctions) = [{
        private _delete = false;
        {
            _x params ["_clientID", "_functionCache", "_index"];
            for "_i" from 1 to ((count _functionCache) min 4) do {
                // Extract the code out of the function.
                private _functionName = _functionCache deleteAt 0;
                private _functionCode = parsingNamespace getVariable [_functionName, {}];

                // Remove leading and trailing braces from the code.
                _functionCode = _functionCode call CFUNC(codeToString);

                // Transfer the function name, code and progress to the client.
                GVAR(receiveFunction) = [_functionName, _functionCode, (_index + _i) / GVAR(countRequiredFnc)];
                _clientID publicVariableClient QGVAR(receiveFunction);
            };

            if (_functionCache isEqualTo []) then {
                GVAR(SendFunctionsUnitCache) set [_forEachIndex, objNull]; // Clear Cache
                _delete = true;
            } else {
                (GVAR(SendFunctionsUnitCache) select _forEachIndex) set [1, _functionCache];
                (GVAR(SendFunctionsUnitCache) select _forEachIndex) set [2, _index + 4];
            };
        } forEach GVAR(SendFunctionsUnitCache);

        // clear Cache
        if (_delete) then {
            GVAR(SendFunctionsUnitCache) = GVAR(SendFunctionsUnitCache) - [objNull];
        };
    }] call CFUNC(addPerFrameHandler);
};
