#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy, joko // Jonas

    Description:
    Add or Update Unit in Tracker

    Parameter(s):
    0: New Unit <Object> (Default: objNull)
    1: Icon name <String> (Default: "")

    Returns:
    0: Icon name <String>
*/

params [
    ["_newUnit", objNull, [objNull]],
    ["_iconId", "", [""]]
];

private _sideColor = +(missionNamespace getVariable format [QEGVAR(Common,SideColor_%1), playerSide]);
private _groupColor = [0, 0.87, 0, 1];

private _color = [_sideColor, _groupColor] select (group CLib_Player isEqualTo group _newUnit);

if (CLib_Player == _newUnit) then {
    _color = [1, 1, 1, 1];
};

private _manIcon = ["ICON", _newUnit getVariable [QEGVAR(Kit,mapIcon), "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa"], _color, _newUnit, 20, 20, _newUnit, "", 1, 0.08, "RobotoCondensed", "right", {
    if ((CLib_Player getVariable [QEGVAR(Kit,isMedic), false]) && {_position getVariable [QEGVAR(Revive,isUnconscious), false]}) then {
        _texture = "\A3\ui_f\data\igui\cfg\revive\overlayicons\u100_ca.paa";
        _color = [1, 0, 0, 1];
        _width = 30;
        _height = 30;
        _angle = 0;
    };
}];

private _manDescription = ["ICON", "a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1, 1, 1, 1], _newUnit, 22, 22, 0, name _newUnit, 2];

[_iconId, [_manIcon]] call CFUNC(addMapGraphicsGroup);
[_iconId, [_manIcon, _manDescription], "hover"] call CFUNC(addMapGraphicsGroup);

_iconId;
