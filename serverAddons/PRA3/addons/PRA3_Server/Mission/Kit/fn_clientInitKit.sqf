#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init Kit Module

    Parameter(s):
    None

    Returns:
    None
*/

// Helper Functions DO NOT remove or make them Private => move them to separate file if you have too much time
DFUNC(addMagazine) = {
    params ["_className", "_count"];
    if (_className != "" && _count > 0) then {
        for "_i" from 1 to _count do {
            PRA3_Player addMagazine _className;
        };
    };
};

DFUNC(addWeapon) = {
    params ["_className", "_magazine", "_count"];
    if (_className != "") then {
        PRA3_Player addWeapon _className;
        [_magazine, _count] call FUNC(addMagazine);
    };
};

DFUNC(addItem) = {
    params ["_className", ["_count", 1]];
    if (_className != "" && _count > 0) then {
        for "_i" from 1 to _count do {
            if (PRA3_Player canAdd _className) then {
                PRA3_Player addItem _className;
            } else {
                hint format ["Item %1 can't added because Gear is Full", _className];
            };
        };
    };
};

[QGVAR(KitGroups), missionConfigFile >> "PRA3" >> "KitGroups"] call CFUNC(loadSettings);
{
    [format [QGVAR(Kit_%1), configName _x], _x >> "Kits"] call CFUNC(loadSettings);
    nil
} count ("true" configClasses (missionConfigFile >> "PRA3" >> "Sides"));
