#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Adds a Status Effect Type to the System

    Parameter(s):
    0: Status Effect ID <String>
    1: Reason <String>
    2: Parameter <Any>

    Returns:
    Current Status Effect <Any>
*/
params ["_id", "_reason", "_parameter"];

private _allParameters = [GVAR(StatusEffectsNamespace), "Parameter_" + _id, []] call CFUNC(getVariableLoc);
private _allReasons = [GVAR(StatusEffectsNamespace), "Reason_" + _id, []] call CFUNC(getVariableLoc);

private _ind = _allReasons pushBackUnique _reason;
if (_ind < 0) then {
    _ind = _allReasons find _reason;
};

if (_ind < 0) exitWith {};

_allParameters set [_ind, _parameter];

GVAR(StatusEffectsNamespace) setVariable ["Parameter_" + _id, _allParameters];
GVAR(StatusEffectsNamespace) setVariable ["Reason_" + _id, _allReasons];
private _code = GVAR(StatusEffectsNamespace) getVariable ["Code_" + _id, []];
_allParameters call _code;
