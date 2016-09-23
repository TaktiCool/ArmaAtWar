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
GVAR(currentHoverVehicle) = grpNull;
GVAR(groupInfoPFH) = -1;
GVAR(vehicleInfoPFH) = -1;
GVAR(lastFrameTriggered) = diag_frameNo;

GVAR(processedUnits) = [];
GVAR(processedGroups) = [];
GVAR(processedVehicles) = [];
GVAR(lastProcessedUnits) = [];
GVAR(lastProcessedGroups) = [];
GVAR(lastProcessedVehicles) = [];

DFUNC(isValidUnit) = {
    params ["_unit"];
    !isNull _unit && alive _unit && side group _unit == playerSide && !isHidden _unit && simulationEnabled _unit;
};

GVAR(ProcessingSM) = call CFUNC(createStatemachine);

[GVAR(ProcessingSM), "init", {
    private _units = +(allUnits select {[_x] call FUNC(isValidUnit)});
    GVAR(lastProcessedUnits) = GVAR(processedUnits);
    GVAR(lastProcessedGroups) = GVAR(processedGroups);
    GVAR(lastProcessedVehicles) = GVAR(processedVehicles);
    GVAR(processedGroups) = [];
    GVAR(processedUnits) = [];
    GVAR(processedVehicles) = [];
    [["addIcons", _units], "init"] select (_units isEqualTo []);
}] call CFUNC(addStatemachineState);

[GVAR(ProcessingSM), "addIcons", {
    params ["_dummy", "_units"];
    private _unit = _units deleteAt 0;

    while {!([_unit] call FUNC(isValidUnit)) && {!(_units isEqualTo [])}} do {
        _unit = _units deleteAt 0;
    };

    if ([_unit] call FUNC(isValidUnit)) then {
        if (vehicle _unit == _unit) then { // Infantry
            private _element = [_unit, side _unit, group _unit, (leader group _unit == _unit), _unit getVariable [QGVAR(playerIconId), ""], group _unit isEqualTo group PRA3_player];
            if (!(_element in GVAR(lastProcessedUnits)) || (_element select 4 == "")) then {
                DUMP(_element);
                DUMP("UNIT ADDED");

                private _id = [_unit] call FUNC(addUnitToTracker);
                _element set [4, _id];
            };
            GVAR(processedUnits) pushBack _element;
            if (leader _unit == _unit) then {
                private _element = [group _unit, leader _unit, format [QGVAR(Group_%1_%2), groupId group _unit, _unit], group _unit isEqualTo group PRA3_player, -1];
                if !(_element in GVAR(lastProcessedGroups) || (_element select 2 == "")) then {
                    private _id = [_element select 0] call FUNC(addGroupToTracker);
                    _element set [2, _id];
                };
                GVAR(processedGroups) pushBack _element;
            };
        } else { // in vehicle
            private _vehicle = vehicle _unit;
            private _nbrGroups = 0;
            private _inGroup = {
                if (leader _x == _x) then {
                    _nbrGroups = _nbrGroups + 1;
                    private _element = [group _x, _vehicle, format [QGVAR(Group_%1_%2), groupId group _x, _vehicle], group _x isEqualTo group PRA3_player, _nbrGroups];
                    if !(_element in GVAR(lastProcessedGroups) || (_element select 2 == "")) then {
                        private _id = [_element select 0, [_vehicle, [0, -20*_nbrGroups]]] call FUNC(addGroupToTracker);
                        _element set [2, _id];
                    };
                    GVAR(processedGroups) pushBack _element;
                };
                ({group _x isEqualTo group PRA3_player} count crew _vehicle) > 0;
            } count crew _vehicle;
            _inGroup = _inGroup > 0;
            private _element = [_vehicle, side _vehicle, format [QGVAR(Vehicle_%1), vehicleVarName _vehicle], _inGroup];
            if (!(_element in GVAR(lastProcessedVehicles)) || (_element select 2 == "")) then {
                DUMP(_element);
                DUMP("VEHICLE ADDED");

                private _id = [_vehicle, _inGroup] call FUNC(addVehicleToTracker);
                _element set [2, _id];


            };
            GVAR(processedVehicles) pushBack _element;

        };


    };

    private _defaultState = [["addIcons", _units], "init"] select (_units isEqualTo []);

    if (_units isEqualTo []) exitWith {
        private _iconsToDelete = (GVAR(lastProcessedUnits) apply {_x select 4}) - (GVAR(processedUnits) apply {_x select 4});
        _iconsToDelete append ((GVAR(lastProcessedGroups) apply {_x select 2}) - (GVAR(processedGroups) apply {_x select 2}));
        _iconsToDelete append ((GVAR(lastProcessedVehicles) apply {_x select 2}) - (GVAR(processedVehicles) apply {_x select 2}));
        [["deleteIcons", _iconsToDelete], _defaultState] select (_iconsToDelete isEqualTo []);
    };
    _defaultState;
}] call CFUNC(addStatemachineState);

[GVAR(ProcessingSM), "deleteIcons", {
    params ["_dummy", "_iconsToDelete"];

    private _icon = _iconsToDelete deleteAt 0;
    [_icon] call CFUNC(removeMapGraphicsGroup);
    [_icon, "hoverin"] call CFUNC(removeMapGraphicsEventHandler);
    [_icon, "hoverout"] call CFUNC(removeMapGraphicsEventHandler);

    [["deleteIcons", _iconsToDelete], "init"] select (_iconsToDelete isEqualTo []);
}] call CFUNC(addStatemachineState);

["DrawMapGraphics", {
    GVAR(ProcessingSM) call CFUNC(stepStatemachine);
    GVAR(lastFrameTriggered) = diag_frameNo;
}] call CFUNC(addEventhandler);

[{
    if (GVAR(lastFrameTriggered) != diag_frameNo) then {
        GVAR(ProcessingSM) call CFUNC(stepStatemachine);
        GVAR(lastFrameTriggered) = diag_frameNo;
    };
}, 0.25] call CFUNC(addPerFrameHandler);
