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
    /*
    addMissionEventHandler ["Draw3D", {
        PERFORMANCECOUNTER_START(Nametags)
        if (!alive PRA3_Player || !isNull (findDisplay 49) || dialog) exitWith {};

        // Use the camera position as center for nearby player detection.
        private _cameraPosAGL = positionCameraToWorld [0, 0, 0];
        private _cameraPosASL = AGLToASL _cameraPosAGL;
        private _fov = (call CFUNC(getFOV)) * 3;

        // Cycle through all nearby players and display their nameTag.
        private _nearUnits = [positionCameraToWorld [0, 0, 0], 31] call CFUNC(getNearUnits);
        {
            private _targetSide = side (group _x);

            // Check if the unit is not the player himself, alive and a friend of player.
            if (_x != PRA3_Player && alive _x && playerSide getFriend _targetSide >= 0.6) then {
                // The position of the nameTag is above the head.

                private _facePostionAGL = _x modelToWorldVisual (_x selectionPosition "pilot");
                private _facePostionASL = AGLtoASL _facePostionAGL;
                private _tagPositionAGL = _facePostionAGL vectorAdd [0, 0, 0.4];
                private _tagPositionASL = AGLtoASL _tagPositionAGL;
                private _wts = worldToScreen _tagPositionAGL;

                // Check if there is something between camera and head position. Exit if there is something to make the nameTag invisible.
                if (!(_wts isEqualTo []) && {((lineIntersectsSurfaces [_cameraPosASL, _facePostionASL, PRA3_Player, _x]) isEqualTo [])}) then {
                    // Calculate the alpha value of the display color based on the distance to player object.
                    private _distance = _cameraPosAGL distance _tagPositionAGL;
                    if (_distance <= 0 || _distance > 31) exitWith {};
                    private _alpha = ((1 - 0.2 * (_distance - 25)) min 1) * 0.8;

                    private _size =_fov * 1 / _distance;

                    _alpha = _alpha * ((1 - ( abs ((_wts select 0) - 0.5) min 0.7)) max 0);
                    if (_alpha == 0) exitWith {};
                    // The color depends whether the unit is in the group of the player or not.
                    private _color = if (group _x == group PRA3_Player) then {

                        // we need to check if _index is -1 because if the player controll a drone and try to get assignedTeam from player return Nil
                        private _index = ["MAIN","RED","GREEN","BLUE","YELLOW"] find (assignedTeam _x);
                        [
                            [1, 1, 1, _alpha],      // Main
                            [1, 0, 0.1, _alpha],    // Red
                            [0.1, 1, 0, _alpha],    // Green
                            [0.1, 0, 1, _alpha],    // Blue
                            [1, 1, 0.1, _alpha]     // Yellow
                        ] param [_index, [1, 1, 1, _alpha]];
                    } else {
                        [0.77, 0.51, 0.08, _alpha]
                    };

                    private _icon = _x getVariable [QEGVAR(Kit,kitIcon), "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"];

                    private _text = format ["%1 (%2)", _x call CFUNC(name), call {
                        if (_x getVariable [QEGVAR(Revive,isUnconscious), false]) exitWith {"Unconscious"};
                        if (group _x != group PRA3_Player) exitWith {groupID group _x};
                        _x getVariable [QEGVAR(Kit,kitDisplayName), ""]
                    }];

                    drawIcon3D [_icon, _color, _tagPositionAGL, 3 * _size, 3 * _size, 0, _text, 2, 0.15 * _size, "PuristaMedium"];
                };
            };
            nil
        } count _nearUnits;
        PERFORMANCECOUNTER_END(Nametags)
    }];
    */
    [{
        if (!isNull (findDisplay 49) || dialog) exitWith {};

        // Use the camera position as center for nearby player detection.
        private _cameraPosAGL = positionCameraToWorld [0, 0, 0];
        private _cameraPosASL = AGLToASL _cameraPosAGL;
        private _fov = (call CFUNC(getFOV)) * 3;

        // Cycle through all nearby players and display their nameTag.
        private _nearUnits = [positionCameraToWorld [0, 0, 0], 100] call CFUNC(getNearUnits);
        //_nearUnits pushBackUnique PRA3_Player;
        private _icons = [];
        {
            private _targetSide = side (group _x);

            // Check if the unit is not the player himself, alive and a friend of player.
            if (/*_x != PRA3_Player &&*/ alive _x && playerSide getFriend _targetSide >= 0.6) then {
                // The position of the nameTag is above the head.

                private _color = if (group _x == group PRA3_Player) then {

                    // we need to check if _index is -1 because if the player controll a drone and try to get assignedTeam from player return Nil
                    private _index = ["MAIN","RED","GREEN","BLUE","YELLOW"] find (assignedTeam _x);
                    [
                        [1, 1, 1, 1],      // Main
                        [1, 0, 0.1, 1],    // Red
                        [0.1, 1, 0, 1],    // Green
                        [0.1, 0, 1, 1],    // Blue
                        [1, 1, 0.1, 1]     // Yellow
                    ] param [_index, [1, 1, 1, 1]];
                } else {
                    [0.77, 0.51, 0.08, 1]
                };

                private _icon = _x getVariable [QEGVAR(Kit,kitIcon), "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"];
                private _text = format ["%1", _x call CFUNC(name)];

                _icons pushBack ["ICON", _icon, _color, [_x, "pilot",[0,0,0.45]], 1, 1, 0, _text, 2, 0.05, "PuristaSemiBold", "center", false, {
                    private _unit = (_position select 0);
                    private _cameraPosASL = AGLToASL (_cameraPosition);
                    private _facePositionAGL =  _unit modelToWorldVisual (_unit selectionPosition "pilot");
                    private _facePositionASL = AGLtoASL _facePositionAGL;
                    private _currentTime = diag_tickTime;

                    if (!((lineIntersectsSurfaces [_cameraPosASL, _facePositionASL, PRA3_Player, _unit]) isEqualTo [])) exitWith {false};

                    private _distance = _cameraPosASL vectorDistance _facePositionASL;

                    if (_distance > 100 || _distance == 0) exitWith {false};

                    private _size = 1;
                    private _alpha = 1;
                    private _offset = [0,0,0.45];

                    if (_distance < 7) then {
                        _offset set [2, (_offset select 2) * ((3 + _distance) / 10)];
                    } else {
                        _size = (7 / _distance) ^ 0.7;
                        _alpha = _size;

                        _offset set [2, (_offset select 2) * (1 / _size) ^ 0.3];

                        if (_distance >=30) then {
                            // linear fade out
                            _alpha = (1 - (_distance - 30) / 20) * _alpha;
                        };

                        private _wts = worldToScreen _facePositionAGL;
                        private _distX = abs ((_wts select 0) - 0.5);
                        private _distY = abs ((_wts select 1) - 0.5);
                        private _marginX = PX(1.5);
                        private _marginY = PY(1.5);
                        if (_distX < _marginX && _distY < _marginY) then {
                            _unit setVariable [QGVAR(lastTimeInFocus), _currentTime];
                        };

                        private _diffTime = _currentTime - (_unit getVariable [QGVAR(lastTimeInFocus), 0]);

                        if (_diffTime < 3) then {
                            private _tempAlpha = 1-sqrt(_diffTime/3);
                            if (_alpha < _tempAlpha) then {
                                _alpha = _tempAlpha;
                            };
                        };
                    };

                    if (_alpha <= 0) exitWith {false};

                    _size = _size * _fov;
                    _width = _size * _width;
                    _height = _size * _height;
                    _textSize = _size * _textSize;
                    _position set [2, _offset];
                    _color set [3, _alpha];

                    true;
                }];
            };
            nil
        } count _nearUnits;
        DUMP(count _icons)
        [QGVAR(Icons),_icons] call CFUNC(add3dGraphics);
    }, 1.2] call CFUNC(addPerFrameHandler);
}] call CFUNC(addEventHandler);
