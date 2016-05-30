#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, NetFusion

    Description:
    This function shows the interrupt display which usually opens when you press the escape button.

    Parameter(s):
    0: Control <Control>
    1: DIKCode <Number>
    2: ShiftKey <Boolean>
    3: CtrlKey <Boolean>
    4: AltKey <Boolean>

    Returns:
    Handled or not <Boolean>
*/
if ((_this select 1) != 1) exitWith {false};

createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);

disableSerialization;

private _dialog = findDisplay 49;

// Disable all buttons first
for "_i" from 100 to 2000 do {
    (_dialog displayCtrl _i) ctrlEnable false;
};

private _control = _dialog displayCtrl 103;
_control ctrlSetEventHandler ["buttonClick", "closeDialog 0; failMission ""LOSER"";"];
_control ctrlEnable true;
_control ctrlSetText "ABORT";
_control ctrlSetTooltip "Abort.";

true