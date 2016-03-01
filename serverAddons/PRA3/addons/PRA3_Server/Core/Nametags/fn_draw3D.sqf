#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Create Nametags overheads from units in closer distance

    Parameter(s):
    None

    Returns:
    None
*/

private _playerPos = positionCameraToWorld [0, 0, 0];
private _targets = _playerPos nearObjects ["Man", 13.3];
if (!surfaceIsWater _playerPos) then {
    _playerPos = ATLtoASL _playerPos;
};

{
    private _target = effectiveCommander _x;
    private _targetSide = (_target getVariable ["jk_var_side","CIV"]);
    if (!(_x in allUnitsUAV) && /*isPlayer _target &&*/ (_target != player) && alive player && (str(playerside) == _targetSide || "CIV" == _targetSide || str(playerside) == "CIV")) then {
        private _targetPos = visiblePositionASL _target;
        private _distance = _targetPos distance _playerPos;
        private _headPosition = _target modelToWorldVisual (_target selectionPosition "pilot");
        //private _icon = format ["\A3\Ui_f\data\GUI\Cfg\Ranks\%1_gs.paa", rank _x];
        private _icon = "";
        private _alpha = ((1 - 0.2 * (_distance - 8) min 1) * 0.8) max 0;

        if (lineIntersects [_playerPos, _targetPos vectorAdd [0,0,1], vehicle player, _target]) exitWith {};

        private _isInGroup = (group _target == group player);

        private _color = if (_isInGroup) then {
            [
                [1,1,1,_alpha],//Main
                [1,0,0.1,_alpha],//Red
                [0.1,1,0,_alpha],//Green
                [0.1,0,1,_alpha],//Blue
                [1,1,0.1,_alpha]//Yellow
            ] select (["MAIN","RED","GREEN","BLUE","YELLOW"] find assignedTeam _target);
        } else {
            [0.77, 0.51, 0.08, _alpha]
        };

        private _text = name _target;
        private _textAddinfo = call {
            // Unit is Unconscious todo replace later by own medical system
            if (_target in (missionNamespace getVariable ["BIS_revive_units", []])) exitWith {
                _icon = "\A3\Ui_f\data\IGUI\Cfg\Cursors\unitbleeding_ca.paa";
                " Unconscious"
            };

            // Unit is in group than get Loadout Class
            if (_isInGroup) then {
                _name = (_target getVariable[QEGVAR(Loadout,class),""]);
                if (_name find "medic" > 0) then {
                    _icon = "\A3\ui_f\data\Revive\medikit_ca.paa";
                };
                _string = format ["STR_JK_GEAR_%1",toUpper _name];
                if (isLocalized (_string)) then { _name = localize _string; };
                _name
            };

            // unit is in other Groups only show Group Name
            _GroupName = groupID (group _target);
            _GroupName
        };

        // check if Unit is in
        if (_textAddinfo != "") then {_text = _text + " (" + _textAddinfo + ")"};
        drawIcon3D [_icon, _color, _headPosition vectorAdd [0, 0, 0.4], 0.8, 0.8, 0, _text, 2, 0.033, "PuristaMedium"];
    };
    false
} count _targets;
