#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    check if a Unit can Interact with a Target

    Parameter(s):
    0: Unit <Object>
    1: Igonred Types <Array>

    Returns:
    <Bool> can InterActWith
*/
params [["_unit", objNull, [objNull]], ["_ignoredTypes", [], [[]]]];
[format [QGVAR(canInteractWith_%1_%2),_unit, _ignoredTypes], {
    scopeName "canInteractWithScope";
    params [["_unit", objNull, [objNull]], ["_ignoredTypes", [], [[]]]];
    {
        _x params ["_type", "_condition"];
        if !(_type in _ignoredTypes) then {
            private _status = call _condition;
            if (!isNil "_status" && {!_status}) then {
                false breakOut "canInteractWithScope";
            };
        };
        nil
    } count GVAR(canInteractWithTypes);
    true
}, _this, 1, QGVAR(clearCanInteractWith)] call CFUNC(cachedCall);
