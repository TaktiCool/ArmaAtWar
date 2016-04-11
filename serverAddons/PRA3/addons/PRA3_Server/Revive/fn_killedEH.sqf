#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Handle the killed Eventhandler

    Parameter(s):
    0: [_unit, _killer] (ARRAY)
    1: -

    Returns:
    0
*/
(_this select 0) params ["_unit","_killer"];
setPlayerRespawnTime 10e10;
if (GVAR(lastKilledFrame) == diag_frameNo) exitWith {};
GVAR(lastKilledFrame) = diag_frameNo;
if ((time - (missionNamespace getVariable ["RscDisplayMPInterrupt_respawnTime",-1])) < 1) exitWith {
    DUMP("Killed: RESPAWN button pressed")
    [QGVAR(Killed), [_unit, _killer]] call CFUNC(localEvent);
};

if !(_unit getVariable [QGVAR(isUnconscious), false]) then {
    DUMP("Killed: Go to Uncon mode")
    private _gear = [_unit] call CFUNC(saveGear);
    _unit setVariable [QGVAR(killer), _killer];

    [{
        _this params ["_unit", "_gear"];

        [side group _unit, group _unit, getPosWorld _unit] call CFUNC(respawn);


        ["switchMove", [PRA3_Player, "acts_InjuredLyingRifle02"]] call CFUNC(globalEvent);

        {
            PRA3_Player setVariable [_x, _unit getVariable _x, true];
        } forEach allVariables _unit;
        ["UnconsciousnessChanged", [true, PRA3_Player]] call CFUNC(localEvent);

        [_gear, PRA3_Player] call CFUNC(restoreGear);

        PRA3_Player setDir direction _unit;

        DUMP("KilledWait: deleteVehicle")
        deleteVehicle _unit;

    }, 3, [_unit, _gear]] call CFUNC(wait);
} else {
    DUMP("Killed: Kill player")
    if (!isNull _killer) then {
        _killer = _unit getVariable [QGVAR(killer), objNull];
    };
    ["UnconsciousnessChanged", [false, _unit]] call CFUNC(localEvent);
    [QGVAR(Killed), [_unit, _killer]] call CFUNC(localEvent);
};
