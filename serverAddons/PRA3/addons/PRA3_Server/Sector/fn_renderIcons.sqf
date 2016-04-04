#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Draw 3D Icons for Sectors

    Parameter(s):
    None

    Returns:
    None
*/





// Attack "\a3\ui_f\data\gui\cfg\CommunicationMenu\attack_ca.paa"
// Deffend "\a3\ui_f\data\gui\cfg\CommunicationMenu\defend_ca.paa"
// Nato "\A3\ui_f\data\map\markers\nato\b_installation.paa"
// CSAT "\A3\ui_f\data\map\markers\nato\o_installation.paa"
// NoSide "\A3\ui_f\data\map\markers\nato\u_installation.paa"

addMissionEventHandler ["Draw3D", {
    if ((isNull PRA3_Player) || {!alive PRA3_Player} || {!isNull (findDisplay 49)}) exitWith {};

    {

        // Only Draw Marker where the player not is in
        if (GVAR(currentSector) != _x) then {
            private _posision = getPos _x;
            _posision set [2, 10];
            private _activeSides = _x getVariable ["activeSides", []];
            private _icon = "\A3\ui_f\data\map\markers\nato\u_installation.paa";
            if (count _activeSides == 2) then {

            };

        };
        drawIcon3D [_icon, _color, _posision, _width, _height, 0, "", 2, 0.033, "PuristaMedium", "center", true];
    } count GVAR(allSectorsArray);

}];
