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
PERFORMANCECOUNTER_START(Nametags)
if ((isNull PRA3_Player) || {!alive PRA3_Player} || {!isNull (findDisplay 49)}) exitWith {};
private _playerPos = positionCameraToWorld [0, 0, 0];
private _targets = _playerPos nearObjects ["CAManBase", 13.3];
if (!surfaceIsWater _playerPos) then {
    _playerPos = ATLtoASL _playerPos;
};
private _playerSide = PRA3_Player getVariable [QCGVAR(side), civilian];
{
    private _target = effectiveCommander _x;
    private _targetSide = (_target getVariable [QCGVAR(side), civilian]);
    if (!(_x in allUnitsUAV) && (isPlayer _target || _target isKindOf "CAManBase") && (_target != PRA3_Player) && alive _target && alive PRA3_Player && _playerSide == _targetSide || civilian == _targetSide || _playerSide == civilian) then {
        private _targetPos = visiblePositionASL _target;
        private _distance = _targetPos distance _playerPos;
        private _headPosition = _target modelToWorldVisual (_target selectionPosition "pilot");
        //private _icon = format ["\A3\Ui_f\data\GUI\Cfg\Ranks\%1_gs.paa", rank _x];
        private _icon = "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa";
        private _alpha = ((1 - 0.2 * (_distance - 8) min 1) * 0.8) max 0;

        if (lineIntersects [_playerPos, (getPos _target) vectorAdd [0,0,1], vehicle player, _target]) exitWith {};

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

        // Unit is in group than get Loadout Class
        private _name = (_target getVariable [QEGVAR(Loadout,class),""]);
        if (_name find "medic" >= 0) then {
            _icon = "\a3\ui_f\data\IGUI\Cfg\Actions\heal_ca.paa";
        };
        if (_name find "leader" >= 0) then {
            _icon = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
        };
        private _text = name _target;
        private _textAddinfo = call {
            // Unit is Unconscious todo replace later by own medical system
            if (_target in (missionNamespace getVariable ["BIS_revive_units", []])) exitWith {
                //_icon = "\A3\Ui_f\data\IGUI\Cfg\Cursors\unitbleeding_ca.paa";
                " Unconscious"
            };

            if (_isInGroup) exitWith {
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
PERFORMANCECOUNTER_END(Nametags)
