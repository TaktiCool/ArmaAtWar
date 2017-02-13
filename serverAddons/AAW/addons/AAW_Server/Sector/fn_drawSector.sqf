#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy

    Description:
    Draws a sector marker

    Parameter(s):
    0: Sector <Object> (Default: objNull)

    Returns:
    None
*/

params [
    ["_sector", objNull, [objNull]]
];

private _marker = _sector getVariable ["marker", ""];
private _designator = _sector getVariable ["designator", ""];
private _fullname = _sector getVariable ["fullname", ""];
private _side = _sector getVariable ["side", sideUnknown];

private _color = [
    missionNamespace getVariable format [QEGVAR(Common,SideColor_%1), str _side],
    [profileNamespace getVariable ["Map_Unknown_R", 0], profileNamespace getVariable ["Map_Unknown_G", 1], profileNamespace getVariable ["Map_Unknown_B", 1], profileNamespace getVariable ["Map_Unknown_A", 0.8]]
] select (_side isEqualTo sideUnknown);

if (isServer) then {
    if (_marker != "") then {
        _marker setMarkerColor format ["Color%1", _side];
    };
};

if (hasInterface) then {
    private _icon = [
        missionNamespace getVariable format [QEGVAR(Common,SideMapIcon_%1), str _side],
        "a3\ui_f\data\Map\Markers\NATO\u_installation.paa"
    ] select (_side isEqualTo sideUnknown);
    private _id = format [QGVAR(ID_%1), _marker];

    private _activeSides = [];
    {
        _activeSides pushBackUnique (([_x] call FUNC(getSector)) getVariable ["side", sideUnknown]);
        nil
    } count (_sector getVariable ["dependency", []]);

    if (count _activeSides > 1 && playerSide in _activeSides) then {
        if (playerSide == _side) then {
            if (_sector call FUNC(isCaptureable)) then {
                _icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\defend_ca.paa";
                _color = [0.01, 0.67, 0.92, 1];
                ["DEFEND", [0.01, 0.67, 0.92, 1], getMarkerPos _marker] call EFUNC(CompassUI,addLineMarker);
            };
        } else {
            _icon = "\A3\ui_f\data\igui\cfg\simpleTasks\types\attack_ca.paa";
            ["ATTACK", [0.99, 0.26, 0, 1], getMarkerPos _marker] call EFUNC(CompassUI,addLineMarker);
            _color = [0.99, 0.26, 0, 1];
        };
    };

    [
        _id,
        [
            ["ICON", _icon, _color, getMarkerPos _marker],
            ["ICON", "a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1, 1, 1, 1], getMarkerPos _marker, 25, 25, 0, _designator, 2]
        ]
    ] call CFUNC(addMapGraphicsGroup);

    [
        _id,
        [
            ["ICON", _icon, _color, getMarkerPos _marker],
            ["ICON", "a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1, 1, 1, 1], getMarkerPos _marker, 25, 25, 0, _fullname, 2]
        ],
        "hover"
    ] call CFUNC(addMapGraphicsGroup);
};
