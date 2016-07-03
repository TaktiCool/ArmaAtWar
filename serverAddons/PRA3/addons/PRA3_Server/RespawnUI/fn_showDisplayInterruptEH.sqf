#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, NetFusion

    Description:
    This function shows the interrupt display which usually opens when you press the escape button.

    Parameter(s):
    0: Display <Display>
    1: DIKCode <Number>
    2: ShiftKey <Boolean>
    3: CtrlKey <Boolean>
    4: AltKey <Boolean>

    Returns:
    Handled or not <Boolean>
*/
params ["_display", "_dikCode"];
if (_dikCode == 1) exitWith {
    _display closeDisplay 1;
    createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);

    [{
        (findDisplay 46) createDisplay UIVAR(RespawnScreen);
    }, {!dialog}] call CFUNC(waitUntil);

    true
};

false