#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Create Statemaschine from Config

    Parameter(s):
    0: Config Path <Config>

    Returns:
    0: Statemaschine Object <Location>
*/
params ["_configPath"];

private _stateMaschine = call FUNC(createStatemaschine);

private _entryPoint = getText(_configPath >> "entryPoint");
if (_entryPoint != "") then {
    _stateMaschine setVariable [SMVAR(nextStateData), _entryPoint];
};

{
    private _code = getText(_x >> "stateCode");
    private _name = configName _x;
    [_stateMaschine, _name, _code] call FUNC(addStatemaschineState);
    nil
} count configProperties [_configPath, "isClass _x", true];

_stateMaschine
