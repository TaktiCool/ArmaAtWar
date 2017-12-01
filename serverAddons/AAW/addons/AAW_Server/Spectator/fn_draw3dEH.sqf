#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    draw3d-EH for the Spectator

    Parameter(s):
    None
    Returns:
    None
*/

// Cursor Target

private _nextTarget = objNull;
private _intersectCam = getPosASL GVAR(camera);
private _intersectTarget = _intersectCam vectorAdd (vectorDir GVAR(camera) vectorMultiply 1000);
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
        if (side _x in EGVAR(Common,CompetingSides)) then {
            private _sideColor = [0.6, 0, 0, 0.7];
            private _distance = GVAR(camera) distance _x;
            if (side _x == (EGVAR(Common,CompetingSides) select 0)) then {
                _sideColor = [0, 0.4, 0.8, 0.7];
            };
            if (_distance < NAMETAGDIST) then {
                private _icon = _x getVariable [QEGVAR(Kit,UIIcon), ""];
                private _pos = (_x modelToWorldVisual ( _x selectionPosition "Head")) vectorAdd [0, 0, 0.5 max (_distance*8/300)];
                private _size = (0.4 max 2/(sqrt(_distance))) min 3;
                drawIcon3D ["a3\ui_f_curator\data\cfgcurator\entity_selected_ca.paa", _sideColor, _pos, _size, _size, 0];


                //drawIcon3D [texture, color, pos, width, height, angle, text, shadow, textSize, font, textAlign, drawSideArrows]
                drawIcon3D [_icon, [1,1,1,1], _pos, _size*1.2, _size*1.2, 0, format ["%1", _x call CFUNC(name)], 2, pixelH*18, "RobotoCondensed", "center"];
            } else {
                if (_distance < UNITDOTDIST) then {
                    _sideColor set [3, 0.5];
                    private _pos = (_x modelToWorldVisual ( _x selectionPosition "pelvis"));
                    drawIcon3D ["a3\ui_f_curator\data\cfgcurator\entity_selected_ca.paa", _sideColor, _pos, 0.4, 0.4, 0];
                };
            };

        };

        false;

    } count allUnits;
};


// GROUPS
if (GVAR(OverlayGroupMarker)) then {
    {
        if (side _x in EGVAR(Common,CompetingSides)) then {
            private _sideColor = [0.6, 0, 0, 1];
            private _distance = GVAR(camera) distance leader _x;
            if (side _x == (EGVAR(Common,CompetingSides) select 0)) then {
                _sideColor = [0, 0.4, 0.8, 1];
            };
            private _groupType = _x getVariable [QEGVAR(Squad,Type), "Rifle"];
            private _groupMapIcon = [format [QUOTE(PREFIX/CfgGroupTypes/%1/mapIcon), _groupType], "\A3\ui_f\data\map\markers\nato\b_inf.paa"] call CFUNC(getSetting);
            private _pos = (leader _x modelToWorldVisual (leader _x selectionPosition "Head")) vectorAdd [0, 0, 25 min (1 max (_distance*30/300))];

            private _size = (1.5 min (0.2/(_distance/5000))) max 0.7;
            drawIcon3D [_groupMapIcon, _sideColor, _pos, _size, _size, 0];
            if (_distance < 4*UNITDOTDIST) then {
                private _fontSize = pixelH*25;
                if (_distance > UNITDOTDIST) then {
                    _fontSize = pixelH*20;
                };

                if (_distance > 2*UNITDOTDIST) then {
                    _fontSize = pixelH*18;
                };
                drawIcon3D ["", [1,1,1,1], _pos, _size, _size, 0, groupId _x, 2, _fontSize, "RobotoCondensedBold", "center"];
            };
        };
        false;
    } count allGroups;
};
