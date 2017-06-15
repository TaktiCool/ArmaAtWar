#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    Get all Informations from a Unit side

    Parameter(s):
    0: Unit or Side <unit, group, side> (default: Player)
    1: Argument that is wanted <string> (default: "all")

    Returns:
    <Array>
    0: Flag
    1: SideColor
    2: SideName
    3: SideMapIcon
*/
params ["_side", ["_arg", "all", [""]]];

if !(_side isEqualType sideUnknown) then {
    _side = side _side;
};
switch (toLower _arg) do {
    case ("flag"): {
        missionNamespace getVariable format [QGVAR(Flag_%1), _side];
    };
    case ("sidecolor"): {
        missionNamespace getVariable format [QGVAR(SideColor_%1), _side];
    };
    case ("sidename"): {
        missionNamespace getVariable format [QGVAR(SideName_%1), _side];
    };
    case ("sidemapicon"): {
        missionNamespace getVariable format [QGVAR(SideMapIcon_%1), _side];
    };
    default {
        [
            [_side, "flag"] call FUNC(getSideInfo),
            [_side, "sidecolor"] call FUNC(getSideInfo),
            [_side, "sidename"] call FUNC(getSideInfo),
            [_side, "sidemapicon"] call FUNC(getSideInfo)
        ]
    };
};
