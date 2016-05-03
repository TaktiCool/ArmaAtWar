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
GVAR(iconMarkerControlPool) = [];

([UIVAR(Compass)] call BIS_fnc_rscLayer) cutRsc [UIVAR(Compass), "PLAIN"];

addMissionEventHandler ["MapSingleClick", {
    params ["_units", "_position", "_alt", "_shift"];

    if (!_shift) exitWith {};

    ["MOVE", [0.9, 0.66, 0.01, 1], _position] call FUNC(addCompassLineMarker);
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
            private _lineMarker = GVAR(lineMarkers) getVariable _x;
            if (!(isNil "_lineMarker")) then {
                private _markerPosition = _lineMarker select 1;
                private _relativeVectorToMarker = _markerPosition vectorDiff _currentPosition;

                private _angleToMarker = ((_relativeVectorToMarker select 0) atan2 (_relativeVectorToMarker select 1) + 360) % 360;
                private _relativeAngleToMarker = (_angleToMarker - _viewDirection + 360) % 360;

                _preparedLineMarkers set [(floor ((_relativeAngleToMarker + 2.5 + _lineOffset) / 5) + 18) % 72, _lineMarker];
            };
            nil
        } count ([GVAR(lineMarkers), QGVAR(lineMarkerIDs), []] call CFUNC(getVariableLoc));

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
                _color = _lineMarker select 0;
            };

            private _xPosition = PX(2.5) * _i - (PX(0.5) * _lineOffset);
            _color set [3, 1 - (abs (_xPosition - PX(46.25)) / PX(46.25)) ^ 3];
            (_dialog displayCtrl _idc) ctrlSetTextColor _color;

            (_dialog displayCtrl _idc) ctrlSetPosition [_xPosition, PY(1)];
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

            private _xPosition = PX(7.5) * _i - PX(0.25) - (PX(0.5) * _bearingOffset);
            (_dialog displayCtrl _idc) ctrlSetTextColor [1,1,1,1 - (abs (_xPosition - PX(46.25)) / PX(46.25)) ^ 3];

            (_dialog displayCtrl _idc) ctrlSetPosition [_xPosition, PY(2)];
            (_dialog displayCtrl _idc) ctrlSetText _bearingText;
            (_dialog displayCtrl _idc) ctrlCommit 0;
        };

        // Icon marker
        private _nearUnits = [QEGVAR(Nametags,nearUnits), {_this nearObjects ["CAManBase", 31]}, _cameraPosAGL, 1, QEGVAR(Nametags,clearNearUnits)] call CFUNC(cachedCall);
        private _nextIconMarkerControl = 0;

        {
            private _targetSide = side (group _x);

            // Check if the unit is not the player himself, alive and a friend of player.
            if (_x != PRA3_Player && alive _x && playerSide getFriend _targetSide >= 0.6) then {
                private _unitPosition = getPosVisual _x;
                private _relativeVectorToUnit = _unitPosition vectorDiff _currentPosition;

                private _angleToUnit = ((_relativeVectorToUnit select 0) atan2 (_relativeVectorToUnit select 1) + 360) % 360;
                private _relativeAngleToUnit = (_angleToUnit - _viewDirection + 360) % 360;

                private _control = GVAR(iconMarkerControlPool) select _nextIconMarkerControl;
                if (isNil "_control") then {
                    _control = _dialog ctrlCreate ["RscPicture", 7301 + _nextIconMarkerControl, _dialog displayCtrl 7000];
                    _control ctrlSetText "a3\ui_f\data\map\Markers\Military\dot_ca.paa";
                    _control ctrlSetTextColor [0, 0.87, 0, 1];
                    GVAR(iconMarkerControlPool) set [_nextIconMarkerControl, _control];
                };
                _control ctrlSetPosition [PX(((_relativeAngleToUnit + 90) % 360) * 0.5), PY(1) - PY(1.45), PX(3.2), PY(3.2)];
                _control ctrlCommit 0;

                _nextIconMarkerControl = _nextIconMarkerControl + 1;
            };
            nil
        } count _nearUnits;

        if (_nextIconMarkerControl < count GVAR(iconMarkerControlPool) - 1) then {
            for "_i" from _nextIconMarkerControl to (count GVAR(iconMarkerControlPool) - 1) do {
                private _control = GVAR(iconMarkerControlPool) deleteAt _i;
                ctrlDelete _control;
            };
        };
    }];
}] call CFUNC(addEventHandler);

["addCompassLineMarker", {
    (_this select 0) call FUNC(addCompassLineMarker);
}] call CFUNC(addEventHandler);
["removeCompassLineMarker", {
    (_this select 0) call FUNC(removeCompassLineMarker)
}] call CFUNC(addEventHandler);
