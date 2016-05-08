#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    [Description]

    Parameter(s):
    0: Name of Counter <String>
    1: Toggle <Bool>

    Returns:
    None
*/
params ["_name", "_enable"];

if (_enable) then {
    if (isNil format [QGVAR(PerformanceTimerTickTime_%1), _name) then {
        missionNamespace setVariable [format [QGVAR(PerformanceTimerTickTime_%1), _name], diag_tickTime];
    };
} else {
    private _oldTime = missionNamespace getVariable [format [QGVAR(PerformanceTimerTickTime_%1), _name], -99999];
    private _newTime = diag_tickTime;
    private _diff = _newTime - _oldTime;
    diag_log format ["[PRA3: Performance Counter] %1: Started %2 ms; Ended %3 ms; Run time %4 ms;", _name, _oldTime, _newTime, _diff];
    systemChat format ["[PRA3: Performance Counter] %1: Started %2 ms; Ended %3 ms; Run time %4 ms;", _name, _oldTime, _newTime, _diff];
    missionNamespace setVariable [format [QGVAR(PerformanceTimerTickTime_%1), _name], nil];
};
