#include "macros.hpp"
/*
    Arma At War - AAW

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

if (_dikCode != 1) exitWith {false};

for "_i" from 1 to 9 do {
    private _controlGroup = _display displayCtrl (_i * 100);
    _controlGroup ctrlShow false;
};

createDialog (["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer);
private _dialog = findDisplay 49;

// Disable all buttons first
for "_i" from 100 to 2000 do {
    (_dialog displayCtrl _i) ctrlEnable false;
    (_dialog displayCtrl _i) ctrlSetTooltip "";
};

private _control = _dialog displayCtrl 104;
_control ctrlSetEventHandler ["buttonClick", QUOTE((uiNamespace getVariable QUOTE(QGVAR(respawnDisplay))) closeDisplay 2; closeDialog 0; failMission ""LOSER"";)];
_control ctrlEnable true;
_control ctrlSetText "ABORT";

[{
    params ["_display"];

    for "_i" from 1 to 9 do {
        private _controlGroup = _display displayCtrl (_i * 100);
        _controlGroup ctrlShow true;
    };
}, {!dialog}, _display] call CFUNC(waitUntil);

true
