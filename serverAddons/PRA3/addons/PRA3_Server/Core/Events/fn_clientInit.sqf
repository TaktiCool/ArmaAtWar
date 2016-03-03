#include macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    This function is the entry point for the core module. It is called by autoloader for all clients. It adds OEF EH to trigger some common events.

    Parameter(s):
    None

    Returns:
    None
*/

// This is needed to provide a player object for zeus controlled units. Important to ensure that player is not null here (which is done in autoload).
PRA3_Player = player;
[{
    // There is no command to get the current player but BI has an variable in mission namespace we can use.
    private _currentPlayer = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
    // If the player changed we trigger an event and update the global variable.
    if (PRA3_Player != _currentPlayer) then {
        ["playerChanged", [_currentPlayer, PRA3_Player]] call FUNC(localEvent);
        PRA3_Player = _currentPlayer;
    };
}] call CFUNC(addPerFrameHandler);

// To ensure that the ingame display is available and prevent unnecessary draw3D calls during briefings we trigger an event if the mission starts.
[{
    // If ingame display is available trigger the event and remove the OEF EH to ensure that the event is only triggered once.
    if (!isNull (findDisplay 46)) then {
        ["missionStarted"] call FUNC(localEvent);
        (_this select 1) call CFUNC(removePerFrameHandler);
    };
}] call CFUNC(addPerFrameHandler);

// Build a dynamic event system to use it in modules.
{
    _x params ["_name"];

    private _code = compile format ["%1 %2", _x, PRA3_Player];

    // Build a name for the variable where we store the data. Fill it with the initial value.
    private _varName = _x;
    missionNamespace setVariable [_varName, call _code];

    // Use an OEF EH to detect if the value changes.
    [{
        params ["_id", "_params"];
        _params params ["_name", "_varName", "_code"];

        // Read the value we detected earlier.
        private _oldValue = missionNamespace getVariable _varName;

        // If the value changed trigger the event and update the value in out variable.
        _currentValue = call _code;
        if (!(_oldValue isEqualTo _currentValue) && {alive PRA3_Player}) then {
            [_name + "Changed", [_currentValue, _oldValue]] call FUNC(localEvent);
            missionNamespace setVariable [_varName, _currentValue];
        };
    }, 0, [_x, _varName, _code]] call CFUNC(addPerFrameHandler);

    true
} count [
    "currentThrowable",
    "currentWeapon",
    "vehicle",
    "side",
    "group",
    "getConnectedUAV",
    "currentVisionMode"
];

// Import the vanilla events in the event system and provide a permanent zeus compatible player.
{
    // The event has the same name and data as the vanilla version.
    private _code = compile format ["[""%1"", _this] call %2", _x, QFUNC(localEvnet)];

    // Bind it to the current player and store the index to delete it.
    private _index = PRA3_Player addEventHandler [_x, _code];

    // If the player changes remove the old EH and bind a new one.
    ["playerChanged", {
        params ["_data", "_params"];
        _data params ["_currentPlayer", "_oldPlayer"];
        _params params ["_name", "_code", "_index"];

        // Remove the old one.
        _oldPlayer removeEventHandler [_name, _index];

        // Some EH get rebound automatically on death. To prevent double EH we remove EH from new player first.
        _currentPlayer removeEventHandler [_name, _index];

        // Bind a new one and update the index in the params.
        _params set [2, _currentPlayer addEventHandler [_name, _code]];
    }, [_x, _code, _index]] call FUNC(addEventHandler);
} count [
    "HandleDamage",
    "InventoryOpened",
    "Killed",
    "Respawn"
];
