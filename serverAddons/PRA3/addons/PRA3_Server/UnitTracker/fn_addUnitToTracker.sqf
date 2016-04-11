#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Add or Update Unit in Tracker

    Parameter(s):
    0: New Unit <Object>
    1: Old Unit <Object>

    Returns:
    0: Return Name <TYPE>
*/
params ["_newUnit", "_oldUnit"];

private _color = missionNamespace getVariable format [QEGVAR(Mission,SideColor_%1), playerSide];
if (side _newUnit == playerSide && !isHidden _newUnit && !simulationEnabled _newUnit) then {
    private _iconId = _newUnit getVariable [QGVAR(playerIconId), ""];
    if (_iconId == "") then {
        private _oldIconId = _oldUnit getVariable [QGVAR(playerIconId), ""];
        if (_oldIconId == "") then {
            _iconId = format [QGVAR(player_%1), GVAR(playerCounter)];
            GVAR(playerCounter) = GVAR(playerCounter) + 1;
        } else {
            _iconId = _oldIconId;
        };

        _newUnit setVariable [QGVAR(playerIconId), _iconId];
    };

    [
        _iconId,
        [
            [_newUnit getVariable [QEGVAR(Kit,mapIcon), "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa"], _color, _newUnit, 25, "AUTO"]
        ]
    ] call CFUNC(addMapIcon);

    [
        _iconId,
        [
            [_newUnit getVariable [QEGVAR(Kit,mapIcon), "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa"], _color, _newUnit, 25, "AUTO"],
            ["a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1,1,1,1], _newUnit, 25, 0, name _newUnit, 2]
        ],
        "hover"
    ] call CFUNC(addMapIcon);

    if (_newUnit == leader _newUnit) then {
        private _groupType = _group getVariable [QGVAR(Type), "Rifle"];
        private _groupMapIcon = [format [QGVAR(GroupTypes_%1_mapIcon), _groupType], "\A3\ui_f\data\map\markers\nato\b_inf.paa"] call CFUNC(getSetting);
        [
            format [QGVAR(Group_%1), groupId group _newUnit],
            [
                [_groupMapIcon, _color, [_newUnit, [0, -25]], 25],
                ["a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1,1,1,1], [_newUnit, [0, -25]], 25, 0, groupId group _newUnit, 2]
            ]
        ] call CFUNC(addMapIcon);
    };

};
