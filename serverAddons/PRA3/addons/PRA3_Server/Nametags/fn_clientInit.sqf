#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init for Nametags

    Parameter(s):
    None

    Returns:
    None
*/
// Use the missionStarted EH to prevent unnecessary executions.
["missionStarted", {
    // The draw3D event triggers on each frame if the client window has focus.
    addMissionEventHandler ["Draw3D", {
        PERFORMANCECOUNTER_START(Nametags)
        if (!alive PRA3_Player || !isNull (findDisplay 49)) exitWith {};

        // Use the camera position as center for nearby player detection.
        private _cameraPos = positionCameraToWorld [0, 0, 0];

        // Cycle through all nearby players and display their nameTag.
        private _nearUnits = [QGVAR(nearUnits), {_this nearObjects ["CAManBase", 13.3]}, _cameraPos, 1, QGVAR(clearNearUnits)] call CFUNC(cachedCall);
        {
            private _targetSide = side (group _x);

            // Check if the unit is not the player himself, alive and a friend of player.
            if (_x != PRA3_Player && alive _x && playerSide getFriend _targetSide >= 0.6) then {
                // The position of the nameTag is above the head.
                private _tagPosition = (_x modelToWorldVisual (_x selectionPosition "pilot")) vectorAdd [0, 0, 0.4];

                // Check if there is something between camera and head position. Exit if there is something to make the nameTag invisible.
                if (!lineIntersects [_cameraPos, _tagPosition, vehicle PRA3_Player, _x]) then {
                    // Calculate the alpha value of the display color based on the distance to player object.
                    private _distance = _cameraPos distance _tagPosition;
                    private _alpha = ((1 - 0.2 * (_distance - 8)) min 1) * 0.8;

                    // The color depends whether the unit is in the group of the player or not.
                    private _color = if (group _x == group PRA3_Player) then {
                        [
                            [1, 1, 1, _alpha],      // Main
                            [1, 0, 0.1, _alpha],    // Red
                            [0.1, 1, 0, _alpha],    // Green
                            [0.1, 0, 1, _alpha],    // Blue
                            [1, 1, 0.1, _alpha]     // Yellow
                        ] select (["MAIN","RED","GREEN","BLUE","YELLOW"] find (assignedTeam _x));
                    } else {
                        [0.77, 0.51, 0.08, _alpha]
                    };

                    private _icon = _x getVariable [QEGVAR(Mission,kitIcon), "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"];

                    private _text = format ["%1 (%2)", _x call CFUNC(name), call {
                        if (_x getVariable [QEGVAR(Revive,isUnconscious), false]) exitWith {"Unconscious"};
                        if (group _x != group PRA3_Player) exitWith {groupID group _x};
                        _x getVariable [QEGVAR(Mission,kitDisplayName), ""]
                    }];

                    drawIcon3D [_icon, _color, _tagPosition, 0.8, 0.8, 0, _text, 2, 0.033, "PuristaMedium"];
                };
            };
            nil
        } count _nearUnits;
        PERFORMANCECOUNTER_END(Nametags)
    }];
}] call CFUNC(addEventHandler);
