#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Initialize the Unit Tracker

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(playerCounter) = 0;
GVAR(currentIcons) = [];
GVAR(blockUpdate) = false;
GVAR(currentHoverGroup) = grpNull;
GVAR(groupInfoPFH) = -1;

GVAR(processedUnits) = [];
GVAR(processedGroups) = [];
GVAR(lastProcessedUnits) = [];
GVAR(lastProcessedGroups) = [];
GVAR(SMcounter) = 0;

GVAR(ProcessingSM) = call CFUNC(createStatemachine);
[GVAR(ProcessingSM), "addIcons", {
    if (GVAR(SMcounter) < (count allUnits)) then {
        private _unit = allUnits select GVAR(SMcounter);

        if (side _unit == playerSide) then {
            private _element = [_unit, side _unit, group _unit, (leader group _unit == _unit), _unit getVariable [QGVAR(playerIconId), ""]];
            if (!(_element in GVAR(lastProcessedUnits)) || (_element select 4 == "")) then {
                private _id = [_unit] call FUNC(addUnitToTracker);
                _element set [4, _id];
            };
            GVAR(processedUnits) pushBack _element;
            if (leader _unit == _unit) then {
                private _element = [group _unit, leader _unit, format [QGVAR(Group_%1), groupId group _unit]];
                if !(_element in GVAR(lastProcessedGroups) || (_element select 2 == "")) then {
                    private _id = [_element select 0] call FUNC(addGroupToTracker);
                    _element set [2, _id];
                };
                GVAR(processedGroups) pushBack _element;
            };
        };
        GVAR(SMcounter) = GVAR(SMcounter) + 1;
    };

    if (GVAR(SMcounter)>= (count allUnits)) exitWith {
        private _iconsToDelete = (GVAR(lastProcessedUnits) apply {_x select 4}) - (GVAR(processedUnits) apply {_x select 4});
        _iconsToDelete append ((GVAR(lastProcessedGroups) apply {_x select 2}) - (GVAR(processedGroups) apply {_x select 2}));
        GVAR(lastProcessedUnits) = GVAR(processedUnits);
        GVAR(lastProcessedGroups) = GVAR(processedGroups);
        GVAR(processedGroups) = [];
        GVAR(processedUnits) = [];
        GVAR(SMcounter) = 0;
        [["deleteIcons", _iconsToDelete], "addIcons"] select (_iconsToDelete isEqualTo []);
    };
    "addIcons"
}] call CFUNC(addStatemachineState);

[GVAR(ProcessingSM), "deleteIcons", {
    params ["_dummy", "_iconsToDelete"];

    private _icon = _iconsToDelete deleteAt 0;
    [_icon] call CFUNC(removeMapGraphicsGroup);
    [_icon, "hoverin"] call CFUNC(removeMapGraphicsEventHandler);
    [_icon, "hoverout"] call CFUNC(removeMapGraphicsEventHandler);

    if (_iconsToDelete isEqualTo []) exitWith {
        "addIcons"
    };
    ["deleteIcons", _iconsToDelete];

}] call CFUNC(addStatemachineState);

[GVAR(ProcessingSM), "addIcons"] call CFUNC(startStateMachine);
