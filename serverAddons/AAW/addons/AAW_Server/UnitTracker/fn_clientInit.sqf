#include "macros.hpp"
/*
    Arma At War

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
GVAR(currentHoverVehicle) = objNull;
GVAR(groupInfoPFH) = -1;
GVAR(vehicleInfoPFH) = -1;
GVAR(lastFrameTriggered) = diag_frameNo;

GVAR(processedIcons) = [];
GVAR(lastProcessedIcons) = [];

DFUNC(isValidUnit) = {
    params ["_unit"];
    !isNull _unit && alive _unit && side group _unit == playerSide && !isHidden _unit && simulationEnabled _unit;
};

GVAR(ProcessingSM) = call CFUNC(createStatemachine);

[GVAR(ProcessingSM), "init", {
    private _units = +(allUnits select {[_x] call FUNC(isValidUnit)});
    GVAR(lastProcessedIcons) = (CGVAR(MapGraphics_MapGraphicsGroup) call CFUNC(allVariables)) select {(_x find toLower QGVAR(IconId)) == 0};
    {
        DUMP("ICON REMOVED: " + _x);
        [_x, "hoverin"] call CFUNC(removeMapGraphicsEventHandler);
        [_x, "hoverout"] call CFUNC(removeMapGraphicsEventHandler);
        [_x] call CFUNC(removeMapGraphicsGroup);
    } count (GVAR(lastProcessedIcons) - GVAR(processedIcons));
    GVAR(processedIcons) = [];

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
            private _iconId = toLower format [QGVAR(IconId_Player_%1_%2), _unit, group _unit isEqualTo group CLib_Player];
            GVAR(processedIcons) pushBack _iconId;
            if !(_iconId in GVAR(lastProcessedIcons)) then {
                DUMP("UNIT ICON ADDED: " + _iconId);
                [_unit, _iconId] call FUNC(addUnitToTracker);
            };

            if (leader _unit == _unit) then {
                _iconId = toLower format [QGVAR(IconId_Group_%1_%2_%3), group _unit, _unit, group _unit isEqualTo group CLib_Player];
                GVAR(processedIcons) pushBack _iconId;
                if !(_iconId in GVAR(lastProcessedIcons)) then {
                    DUMP("GROUP ICON ADDED: " + _iconId);
                    [group _unit, _iconId] call FUNC(addGroupToTracker);
                };
            };
        } else { // in vehicle
            private _vehicle = vehicle _unit;
            private _nbrGroups = 0;
            private _inGroup = {
                if (leader _x == _x) then {
                    _nbrGroups = _nbrGroups + 1;
                    private _iconId = toLower format [QGVAR(IconId_Group_%1_%2_%3_%4), group _x, _vehicle, group _unit isEqualTo group CLib_Player, _nbrGroups];
                    GVAR(processedIcons) pushBack _iconId;
                    if !(_iconId in GVAR(lastProcessedIcons)) then {
                        DUMP("GROUP ICON ADDED: " + _iconId);
                        [group _x, _iconId, [0, -20*_nbrGroups]] call FUNC(addGroupToTracker);
                    };
                };
                ({group _x isEqualTo group CLib_Player} count crew _vehicle) > 0;
            } count crew _vehicle;
            _inGroup = _inGroup > 0;
            private _iconId = toLower format [QGVAR(IconId_Vehicle_%1_%2), _vehicle, _inGroup];
            GVAR(processedIcons) pushBack _iconId;
            if !(_iconId in GVAR(lastProcessedIcons)) then {
                DUMP("VEHICLE ADDED: " + _iconId);
                [_vehicle, _iconId, _inGroup] call FUNC(addVehicleToTracker);
            };
        };
    };

    private _defaultState = [["addIcons", _units], "init"] select (_units isEqualTo []);

    if (_units isEqualTo []) then {
        {
            DUMP("ICON REMOVED: " + _x);
            [_x, "hoverin"] call CFUNC(removeMapGraphicsEventHandler);
            [_x, "hoverout"] call CFUNC(removeMapGraphicsEventHandler);
            [_x] call CFUNC(removeMapGraphicsGroup);
        } count (GVAR(lastProcessedIcons) - GVAR(processedIcons));
        //[["deleteIcons", _iconsToDelete], _defaultState] select (_iconsToDelete isEqualTo []);
    };
    _defaultState;
}] call CFUNC(addStatemachineState);
/*
[GVAR(ProcessingSM), "deleteIcons", {
    params ["_dummy", "_iconsToDelete"];

    private _icon = _iconsToDelete deleteAt 0;
    DUMP("ICON REMOVED: " + _icon);
    [_icon] call CFUNC(removeMapGraphicsGroup);
    [_icon, "hoverin"] call CFUNC(removeMapGraphicsEventHandler);
    [_icon, "hoverout"] call CFUNC(removeMapGraphicsEventHandler);

    [["deleteIcons", _iconsToDelete], "init"] select (_iconsToDelete isEqualTo []);
}] call CFUNC(addStatemachineState);
*/

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
