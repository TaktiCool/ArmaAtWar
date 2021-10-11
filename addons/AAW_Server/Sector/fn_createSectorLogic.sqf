#include "macros.hpp"
/*
    Arma At War - AAW

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
params [
    "_marker",
    ["_dependency", []],
    ["_ticketValue", 30],
    ["_minUnits", 1],
    ["_maxUnits", 9],
    ["_captureTime", [30, 60]],
    ["_firstCaptureTime", [5, 15]],
    ["_designator", "A"]
];

private _size = getMarkerSize _marker;

private _logic = true call CFUNC(createNameSpace);
_logic setPos (getMarkerPos _marker);
["setVehicleVarName", [_logic, _marker]] call CFUNC(globalEvent);
GVAR(allSectors) setVariable [_marker, _logic, true];
GVAR(allSectorsArray) pushBack _logic;

private _side = switch (markerColor _marker) do {
    case "ColorWEST": {west};
    case "ColorEAST": {east};
    case "ColorGUER": {independent};
    default {sideUnknown};
};

_marker setMarkerAlpha 1;

private _markerFullName = markerText _marker;
if (_markerFullName call CFUNC(isLocalised)) then {
    _markerFullName = LOC(_markerFullName);
};

_logic setVariable ["name", _marker, true];
_logic setVariable ["fullName", _markerFullName, true];
_logic setVariable ["designator", _designator, true];
_logic setVariable ["marker", _marker, true];
_logic setVariable ["side", _side, true];
_logic setVariable ["attackerSide", _side, true];
_logic setVariable ["dependency", _dependency, true];
_logic setVariable ["ticketValue", _ticketValue, true];
_logic setVariable ["minUnits", _minUnits, true];
_logic setVariable ["maxUnits", _maxUnits, true];
_logic setVariable ["captureRate", 0, true];
_logic setVariable ["captureTime", _captureTime, true];
_logic setVariable ["firstCaptureTime", _firstCaptureTime, true];

if (_side == sideUnknown) then {
    _logic setVariable ["captureProgress", 0, true];
} else {
    _logic setVariable ["captureProgress", 1, true];
};
