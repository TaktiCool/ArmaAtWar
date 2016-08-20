#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Append Unit to SendFunctions Queue if the mission is allready Trigger else it just pushes the functions

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
