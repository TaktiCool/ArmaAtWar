#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Client Init of Revive Module

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

        private _dialog = uiNamespace getVariable UIVAR(Compass);
        for "_i" from 1 to 37 do {
            (_dialog displayCtrl (7000 + _i)) ctrlSetPosition [PX(2.5) * _i + 0.5 - PX(45) - (PX(0.5) * (_viewDirection % 5)), PY(102) + safeZoneY];
            (_dialog displayCtrl (7000 + _i)) ctrlCommit 0;
        };
    }];
}] call CFUNC(addEventHandler);