#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Client init point of base protection system

    Parameter(s):
    None

    Returns:
    None
*/

["sectorEntered", {
    (_this select 0) params ["_unit", "_sector"];

    if (_unit != CLib_Player || (str _sector) find "base_" != 0) exitWith {};

    private _side = _sector getVariable ["side", _playerSide];
    if (_side == side group CLib_Player) then {
        // Own base
        ["allowDamage", "BaseProtection", false] call CFUNC(setStatusEffect);
    } else {
        // Enemy base
        (QGVAR(rscLayer) cutFadeOut 0) cutText ["", "BLACK", 2, false]; // https://feedback.bistudio.com/T120768

        [{
            params ["_sector", "_entryPosition", "_entryDirection"];

            private _marker = _sector getVariable ["marker", ""];
            if (CLib_Player inArea _marker) then {
                CLib_Player setDir _entryDirection - 180;
                CLib_Player setPos _entryPosition;
            };
        }, 2, [_sector, getPos CLib_Player vectorDiff velocity CLib_Player, getDir CLib_Player]] call CFUNC(wait);
    };
}] call CFUNC(addEventHandler);

["sectorLeaved", {
    (_this select 0) params ["_unit", "_sector"];

    if (_unit != CLib_Player || (str _sector) find "base_" != 0) exitWith {};

    private _side = _sector getVariable ["side", _playerSide];
    if (_side == side group CLib_Player) then {
        // Own base
        ["allowDamage", "BaseProtection", true] call CFUNC(setStatusEffect);
    } else {
        // Enemy base
        (QGVAR(rscLayer) cutFadeOut 0) cutText ["", "BLACK IN", 1, false];

        // Show notfication afterwards otherwise it may be covered by the black screen
        [{MLOC(CanNotEnterBase) call EFUNC(Common,displayNotificationOld)}, 1] call CFUNC(wait);
    };
}] call CFUNC(addEventHandler);
