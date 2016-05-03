#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Client Init of Compass UI

    Parameter(s):
    None

    Returns:
    None
*/

// 0: MOVE, 1: ATTACK, 2: DEFEND
GVAR(lineMarkers) = call CFUNC(createNamespace);

([UIVAR(Compass)] call BIS_fnc_rscLayer) cutRsc [UIVAR(Compass), "PLAIN"];

addMissionEventHandler ["MapSingleClick", {
    params ["_units", "_position", "_alt", "_shift"];

    if (!_shift) exitWith {};

    ["Marker2", [[0.9, 0.66, 0.01, 1], _position]] call FUNC(addCompassLineMarker);
}];

["missionStarted", {
    // The draw3D event triggers on each frame if the client window has focus.
    addMissionEventHandler ["Draw3D", {
        disableSerialization;
        private _currentPosition = getPosVisual PRA3_Player;
        private _viewDirectionVector = getCameraViewDirection PRA3_Player;
        private _viewDirection = ((_viewDirectionVector select 0) atan2 (_viewDirectionVector select 1) + 360) % 360;


        private _lineOffset = _viewDirection % 5;

        // Prepare line marker
        // TODO think about Caching this part
        private _preparedLineMarkers = [];
        _preparedLineMarkers resize 37;
        {
            private _markerVar = GVAR(lineMarkers) getVariable _x;
            if !(isNil "_markerVar") then {
                private _markerPosition = _markerVar select 1;
                private _relativeVectorToMarker = _markerPosition vectorDiff _currentPosition;

                private _angleToMarker = ((_relativeVectorToMarker select 0) atan2 (_relativeVectorToMarker select 1) + 360) % 360;
                private _relativeAngleToMarker = (_angleToMarker - _viewDirection + 360) % 360;

                _preparedLineMarkers set [(floor ((_relativeAngleToMarker + 2.5 + _lineOffset) / 5) + 18) % 72, _markerVar];
                hintSilent str ((floor ((_relativeAngleToMarker + 2.5 + _lineOffset) / 5) + 18) % 72);
            };
            nil
        } count ([GVAR(lineMarkers), QGVAR(allLineMarkers), []] call CFUNC(getVariableLoc));

        /*
         * DRAWING
         */
        private _dialog = uiNamespace getVariable UIVAR(Compass);

        // Lines
        for "_i" from 0 to 37 do {
            private _idc = 7001 + _i;

            private _lineMarker = _preparedLineMarkers select _i;
            private _color = [1, 1, 1, 1];
            if (!(isNil "_lineMarker")) then {
                _color =  (_lineMarker select 0);
            };

            private _xPos = PX(2.5) * _i - (PX(0.5) * _lineOffset);
            //(_dialog displayCtrl _idc) ctrlSetText format ["#(argb,8,8,3)color(1,1,1,%1)", 0 max (1-(abs (_xPos - PX(92.5/2))/PX(92.5/2))^2)];
            _color set [3, 0 max (1-(abs (_xPos - PX(92.5/2))/PX(92.5/2))^3)];
            (_dialog displayCtrl _idc) ctrlSetBackgroundColor _color;

            (_dialog displayCtrl _idc) ctrlSetPosition [_xPos, PY(1)];
            (_dialog displayCtrl _idc) ctrlCommit 0;
        };

        // Bearings
        private _bearingOffset = _viewDirection % 15;
        for "_i" from 0 to 13 do {
            private _idc = 7101 + _i;
            private _bearing = (_viewDirection - _bearingOffset - 90 + (15 * _i) + 360) % 360;

            private _bearingText = switch (_bearing) do {
                case 0: {"N"};
                case 45: {"NE"};
                case 90: {"E"};
                case 135: {"SE"};
                case 180: {"S"};
                case 225: {"SW"};
                case 270: {"W"};
                case 315: {"NW"};
                default {str _bearing};
            };
            private _xPos = PX(7.5) * _i - PX(0.25) - (PX(0.5) * _bearingOffset);
            (_dialog displayCtrl _idc) ctrlSetTextColor [1,1,1,0 max (1-(abs (_xPos - PX(92.5/2))/PX(92.5/2))^2)];
            (_dialog displayCtrl _idc) ctrlSetPosition [PX(7.5) * _i - PX(0.25) - (PX(0.5) * _bearingOffset), PY(2)];
            (_dialog displayCtrl _idc) ctrlSetText _bearingText;
            (_dialog displayCtrl _idc) ctrlCommit 0;
        };
    }];
}] call CFUNC(addEventHandler);

["addCompassLineMarker", FUNC(addCompassLineMarker)] call CFUNC(addEventhandler);
["removeCompassLineMarker", FUNC(removeCompassLineMarker)] call CFUNC(addEventhandler);
