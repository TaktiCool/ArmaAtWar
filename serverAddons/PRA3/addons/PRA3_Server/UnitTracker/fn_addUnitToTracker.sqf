#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Add or Update Unit in Tracker

    Parameter(s):
    0: New Unit <Object>

    Returns:
    0: Return Name <TYPE>
*/
params ["_newUnit"];

if (side _newUnit != playerSide || isHidden _newUnit || !simulationEnabled _newUnit) exitWith {""};

#ifdef isDev
    DUMP("Unit Icon added: " + str _newUnit)
#endif


private _sideColor = +(missionNamespace getVariable format [QEGVAR(Mission,SideColor_%1), playerSide]);
private _groupColor = [0, 0.87, 0, 1];
private _iconId = _newUnit getVariable [QGVAR(playerIconId), ""];
if (_iconId == "") then {
    _iconId = format [QGVAR(player_%1), GVAR(playerCounter)];
    GVAR(playerCounter) = GVAR(playerCounter) + 1;

    _newUnit setVariable [QGVAR(playerIconId), _iconId];
};

private _color = [_sideColor, _groupColor] select (group PRA3_Player isEqualTo group _newUnit);

private _manIcon = ["ICON", _newUnit getVariable [QEGVAR(Kit,mapIcon), "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa"], _color, _newUnit, 20, 20, _newUnit, "", 1];
private _manDescription = ["ICON", "a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1,1,1,1], _newUnit, 20, 20, 0, name _newUnit, 2];

[_iconId, [_manIcon]] call CFUNC(addMapGraphicsGroup);
[_iconId, [_manIcon, _manDescription], "hover"] call CFUNC(addMapGraphicsGroup);

_iconId;
