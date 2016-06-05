#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas, NetFusion

    Description:
    Handles display of hit effect on players

    Parameter(s):
    None

    Returns:
    None
*/
addMissionEventHandler ["Draw3D", {
    if (!alive PRA3_Player || !isNull (findDisplay 49) || dialog) exitWith {};

    // Use the camera position as center for nearby player detection.
    private _cameraPosAGL = positionCameraToWorld [0, 0, 0];
    private _cameraPosASL = AGLToASL _cameraPosAGL;
    private _fov = (call CFUNC(getFOV)) * 3;

    // use Nametags nearObjects to not call it Multible Times
    private _nearUnits = [positionCameraToWorld [0, 0, 0], 31] call CFUNC(getNearUnits);

    {
        private _targetSide = side (group _x);

        if (_x != PRA3_Player && alive _x && playerSide getFriend _targetSide >= 0.6 && {_x getVariable [QGVAR(isUnconscious), false] || _x getVariable [QGVAR(bloodLoss), 0] != 0 || !(_x getVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}] isEqualTo (GVAR(selections) apply {0}))}) then {
            private _tagPositionAGL = _x modelToWorldVisual (_x selectionPosition "spine2");
            private _tagPositionASL = AGLtoASL _tagPositionAGL;
            private _screenTagPosition = worldToScreen _tagPositionAGL;

            if (!(_screenTagPosition isEqualTo []) && {(lineIntersectsSurfaces [_cameraPosASL, _tagPositionASL, PRA3_Player, _x] isEqualTo [])}) then {
                // Calculate the alpha value of the display color based on the distance to player object.
                private _distance = _cameraPosAGL distance _tagPositionAGL;
                if (_distance <= 0 || _distance > 31) exitWith {};

                private _size = _fov / _distance;

                // Calculate alpha based on distance (fade out the last 5m)
                private _alpha = ((1 - 0.2 * (_distance - 25)) min 1) * 0.8;

                // Calculate the alpha base on screen position (fade out near edge)
                _alpha = _alpha * ((1 - ( abs ((_screenTagPosition select 0) - 0.5) min 0.7)) max 0);

                private _color = [1, 1, 1, _alpha];

                private _text = "";
                private _icon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";

                if (_x getVariable [QGVAR(bloodLoss), 0] != 0) then {
                    _icon = "\A3\Ui_f\data\IGUI\Cfg\Cursors\unitbleeding_ca.paa";
                } else {
                    if (_x getVariable [QGVAR(isUnconscious), false] && cursorTarget isEqualTo _x && _x getVariable [QGVAR(medicalActionRunning), ""] == "") then {
                        _text = "Press space to revive the casualty";
                    } else {
                        if (!(_x getVariable [QGVAR(selectionDamage), GVAR(selections) apply {0}] isEqualTo (GVAR(selections) apply {0}))) then {
                            _icon = "\A3\UI_f\data\IGUI\Cfg\Actions\heal_ca.paa";
                        };
                    };
                };

                drawIcon3D [_icon, _color, _tagPositionAGL, 3 * _size, 3 * _size, 0, _text, 2, 0.15 * _size, "PuristaMedium", "center", true];
            };
        };
    } count _nearUnits;
}];
