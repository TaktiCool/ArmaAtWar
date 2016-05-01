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
([UIVAR(Compass)] call BIS_fnc_rscLayer) cutRsc [UIVAR(Compass), "PLAIN"];

["missionStarted", {
    // The draw3D event triggers on each frame if the client window has focus.
    addMissionEventHandler ["Draw3D", {
        private _viewDirectionVector = getCameraViewDirection PRA3_Player;
        private _viewDirection = (_viewDirectionVector select 0) atan2 (_viewDirectionVector select 1);
        if (_viewDirection < 0) then {
            _viewDirection = _viewDirection + 360;
        };

        private _dialog = uiNamespace getVariable UIVAR(Compass);

        // Lines
        private _lineOffset = _viewDirection % 5;
        for "_i" from 1 to 38 do {
            (_dialog displayCtrl (7000 + _i)) ctrlSetPosition [PX(2.5) * (_i - 1) - (PX(0.5) * _lineOffset), PY(1)];
            (_dialog displayCtrl (7000 + _i)) ctrlCommit 0;
        };

        // Bearings
        private _bearingOffset = _viewDirection % 15;
        for "_i" from 1 to 14 do {
            private _bearing = _viewDirection - _bearingOffset - 90 + (15 * (_i - 1));
            if (_bearing < 0) then {
                _bearing = _bearing + 360;
            };
            if (_bearing >= 360) then {
                _bearing = _bearing - 360;
            };

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

            (_dialog displayCtrl (7100 + _i)) ctrlSetPosition [PX(7.5) * (_i - 1) - PX(0.25) - (PX(0.5) * _bearingOffset), PY(2)];
            (_dialog displayCtrl (7100 + _i)) ctrlSetText _bearingText;
            (_dialog displayCtrl (7100 + _i)) ctrlCommit 0;
        };
    }];
}] call CFUNC(addEventHandler);