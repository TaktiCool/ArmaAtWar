#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Init Inventory system

    Parameter(s):
    None

    Returns:
    None
*/

if (side CLib_player == sideLogic && {player isKindOf "VirtualSpectator_F"}) exitWith {};

["InventoryOpened", {
    // Dont show vanilla inventory
    _CLib_EventReturn = true;

    private _display = findDisplay 46;
    if (isNull _display) exitWith {};

    GUI_INIT(_display);

    // Main
    private _grpMain = GUI_NEWGROUP(safeZoneX + safeZoneW - PX(18), safezoneY + PY(20), PX(18), safeZoneH - PY(40));
    GUI_COMMIT(0);

    private _primaryWeapon = primaryWeapon CLib_Player;
    GUI_NEWGROUP(0, 0, PX(18), PY(9));
    AAWUI_BUTTONBACKGROUND(0, 0, PX(18), PY(9));
    GUI_NEWCTRL("RscPicture");
    GUI_POSITION(0, 0, PX(18), PY(9));
    GUI_TEXTURE(getText (configFile >> "CfgWeapons" >> _primaryWeapon >> "picture"));
    GUI_COMMIT(0);

    private _secondaryWeapon = secondaryWeapon CLib_Player;
    GUI_POPGRP;
    GUI_NEWGROUP(0, PY(10), PX(18), PY(10));
    AAWUI_BUTTONBACKGROUND(0, 0, PX(18), PY(9));
    GUI_NEWCTRL("RscPicture");
    GUI_POSITION(0, 0, PX(18), PY(9));
    GUI_TEXTURE(getText (configFile >> "CfgWeapons" >> _secondaryWeapon >> "picture"));
    GUI_COMMIT(0);

    private _handgunWeapon = handgunWeapon CLib_Player;
    GUI_POPGRP;
    GUI_NEWGROUP(0, PY(20), PX(18), PY(9));
    AAWUI_BUTTONBACKGROUND(0, 0, PX(18), PY(9));
    GUI_NEWCTRL("RscPicture");
    GUI_POSITION(0, 0, PX(18), PY(9));
    GUI_TEXTURE(getText (configFile >> "CfgWeapons" >> _handgunWeapon >> "picture"));
    GUI_COMMIT(0);
}] call CFUNC(addEventHandler);
