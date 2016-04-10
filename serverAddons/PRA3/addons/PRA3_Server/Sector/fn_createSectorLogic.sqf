#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Create Sector Logic and set all Base Variables

    Parameter(s):
    0: Marker of the Sector <String>
    1: Depentency of the Sector <Array>
    2: TicketBleed of the Sector <Number>
    3: Minimum Units in the Area to start Capturing <Number>
    4: Time To Capture the Sector <Number>
    5: Sector Designator <String>

    Returns:
    None
*/
params ["_marker", ["_dependency", []], ["_ticketValue", 30], ["_minUnits", 1], ["_captureTime",[30,60]], ["_firstCaptureTime",[5,15]], ["_designator","A"]];


private _size = getMarkerSize _marker;

private _logic = (call CFUNC(getLogicGroup)) createUnit ["Logic", getMarkerPos _marker, [], 0, "NONE"];
_logic setVehicleVarName _marker;
GVAR(allSectors) setVariable [_marker, _logic, true];
GVAR(allSectorsArray) pushBack _logic;

private _side = switch (markerColor _marker) do {
    case "ColorWEST": {west};
    case "ColorEAST": {east};
    case "ColorGUER": {independent};
    default {sideUnknown};
};

/*
private _infoMarker = createMarker [format ["InformationMarker_%1", _marker], getMarkerPos _marker];
_infoMarker setMarkerShape "ICON";
_infoMarker setMarkerType SelectSideMarker(_side);
_infoMarker setMarkerColor (markerColor _marker);
_nameMarker = createMarker [format ["InformationMarker2_%1", _marker], getMarkerPos _marker vectorAdd [0, 0, 100]];
_nameMarker setMarkerColor "ColorBlack";
_nameMarker setMarkerShape "ICON";
_nameMarker setMarkerType "EmptyIcon";
_nameMarker setMarkerText _designator;
*/

private _color = [
    missionNamespace getVariable format [QEGVAR(mission,SideColor_%1), str _side],
    [(profilenamespace getvariable ['Map_Unknown_R',0]),(profilenamespace getvariable ['Map_Unknown_G',1]),(profilenamespace getvariable ['Map_Unknown_B',1]),(profilenamespace getvariable ['Map_Unknown_A',0.8])]
] select (_side isEqualTo sideUnknown);

private _icon = [
    missionNamespace getVariable format [QEGVAR(mission,SideMapIcon_%1), str _side],
    "a3\ui_f\data\Map\Markers\NATO\u_installation.paa"
] select (_side isEqualTo sideUnknown);

[
    format [QGVAR(ID_%1), _marker],
    [_icon, _color, getMarkerPos _marker]
] call CFUNC(addMapIcon);

[
    format [QGVAR(ID_%1), _marker],
    [_icon, [1,1,1,1], getMarkerPos _marker],
    "hover"
] call CFUNC(addMapIcon);

[
    format [QGVAR(ID_%1), _marker],
    [_icon, [0,0,0,1], getMarkerPos _marker],
    "selected"
] call CFUNC(addMapIcon);

[
    format [QGVAR(ID_Text_%1), _marker],
    ["a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1,1,1,1], getMarkerPos _marker, 25, 0, _designator, 2]
] call CFUNC(addMapIcon);

_marker setMarkerAlpha 1;
//_logic setVariable ["informationMarker", _infoMarker, true];
_logic setVariable ["name", _marker, true];
_logic setVariable ["fullName", markerText _marker, true];
_logic setVariable ["designator", _designator, true];
_logic setVariable ["marker", _marker, true];
_logic setVariable ["side", _side, true];
_logic setVariable ["attackerSide", _side, true];
_logic setVariable ["dependency", _dependency, true];
_logic setVariable ["ticketValue", _ticketValue, true];
_logic setVariable ["minUnits", _minUnits, true];
_logic setVariable ["captureRate", 0, true];
_logic setVariable ["captureTime", _captureTime, true];
_logic setVariable ["firstCaptureTime", _firstCaptureTime, true];
_logic setVariable ["isLastSector", _isLastSector, true];
if (_side == sideUnknown) then {
    _logic setVariable ["captureProgress", 0, true];
} else {
    _logic setVariable ["captureProgress", 1, true];
};
