#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Draw3d event handler for the spectator

    Parameter(s):
    None

    Returns:
    None
*/

// Cursor Target
private _nextTarget = objNull;
private _intersectCam = getPosASL GVAR(Camera);
private _intersectTarget = _intersectCam vectorAdd (vectorDir GVAR(Camera) vectorMultiply 1000);
private _object = lineIntersectsSurfaces [
    _intersectCam,
    _intersectTarget,
    objnull,
    objnull,
    true,
    1,
    "GEOM"
];

if !(_object isEqualTo []) then {
    _nextTarget = _object select 0 select 2;
};

if !(_nextTarget isEqualTo GVAR(CursorTarget)) then {
    GVAR(CursorTarget) = _nextTarget;
    [QGVAR(CursorTargetChanged), _nextTarget] call CFUNC(localEvent);
};

//HUD
//Units
if (GVAR(OverlayUnitMarker)) then {
    {
        if (side _x in MGVAR(CompetingSides)) then {
            private _sideColor = [[0.6, 0, 0, 0.7], [0, 0.4, 0.8, 0.7]] select (side _x == (MGVAR(CompetingSides) select 0));
            private _distance = GVAR(Camera) distance _x;
            if (_distance < NAMETAGDIST) then {
                private _icon = _x getVariable [QEGVAR(Kit,UIIcon), ""];
                private _pos = (_x modelToWorldVisual (_x selectionPosition "Head")) vectorAdd [0, 0, 0.5 max (_distance * 8 / 300)];
                private _size = (0.4 max 2 / (sqrt _distance)) min 3;
                drawIcon3D ["a3\ui_f_curator\data\cfgcurator\entity_selected_ca.paa", _sideColor, _pos, _size, _size, 0];
                drawIcon3D [_icon, [1, 1, 1, 1], _pos, _size * 1.2, _size * 1.2, 0, format ["%1", _x call CFUNC(name)], 2, PY(1.8), "RobotoCondensed", "center"];
            } else {
                if (_distance < UNITDOTDIST) then {
                    _sideColor set [3, 0.5];
                    private _pos = (_x modelToWorldVisual (_x selectionPosition "pelvis"));
                    drawIcon3D ["a3\ui_f_curator\data\cfgcurator\entity_selected_ca.paa", _sideColor, _pos, 0.4, 0.4, 0];
                };
            };
        };
        nil
    } count allUnits;
};

// GROUPS
if (GVAR(OverlayGroupMarker)) then {
    {
        if (side _x in MGVAR(CompetingSides)) then {
            private _sideColor = [[0.6, 0, 0, 1], [0, 0.4, 0.8, 1]] select (side _x == (MGVAR(CompetingSides) select 0));
            private _distance = GVAR(Camera) distance leader _x;
            private _groupType = _x getVariable [QEGVAR(Squad,Type), "Rifle"];
            private _groupMapIcon = [format [QUOTE(PREFIX/CfgGroupTypes/%1/mapIcon), _groupType], "\A3\ui_f\data\map\markers\nato\b_inf.paa"] call CFUNC(getSetting);
            private _pos = (leader _x modelToWorldVisual (leader _x selectionPosition "Head")) vectorAdd [0, 0, 25 min (1 max (_distance * 30 / 300))];
            private _size = (1.5 min (0.2 / (_distance / 5000))) max 0.7;

            drawIcon3D [_groupMapIcon, _sideColor, _pos, _size, _size, 0];
            if (_distance < 4 * UNITDOTDIST) then {
                private _fontSize = PY(2.5);
                if (_distance > UNITDOTDIST) then {
                    _fontSize = PY(2);
                };

                if (_distance > 2 * UNITDOTDIST) then {
                    _fontSize = PY(1.8);
                };
                drawIcon3D ["", [1, 1, 1, 1], _pos, _size, _size, 0, groupId _x, 2, _fontSize, "RobotoCondensedBold", "center"];
            };
        };
        nil
    } count allGroups;
};
