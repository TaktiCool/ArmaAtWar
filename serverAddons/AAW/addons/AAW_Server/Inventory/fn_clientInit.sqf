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

[UIVAR(Inventory_onShow), {
    params ["_grpMain"];

    _grpMain ctrlSetPosition [safeZoneX + safeZoneW - PX(18), safezoneY + PY(20)];
    _grpMain ctrlSetFade 0;
    _grpMain ctrlCommit 0.5;
}] call CFUNC(addEventHandler);

[UIVAR(Inventory_onHide), {
    params ["_grpMain"];

    _grpMain ctrlSetPosition [safeZoneX + safeZoneW, safezoneY + PY(20)];
    _grpMain ctrlSetFade 1;
    _grpMain ctrlCommit 0.5;
}] call CFUNC(addEventHandler);

["missionStarted", {
    private _display = findDisplay 46;
    if (isNull _display) exitWith {};

    GUI_INIT(_display);

    // Main
    private _grpMain = GUI_NEWGROUP(safeZoneX + safeZoneW, safezoneY + PY(20), PX(18), safeZoneH - PY(40));
    uiNamespace setVariable [QGVAR(GrpMain), _grpMain];
    GUI_COMMIT(0);

    private _primaryWeapon = primaryWeapon CLib_Player;
    GUI_NEWGROUP(0, 0, PX(18), PY(9));
    GUI_COMMIT(0);
    AAWUI_PANELBACKGROUND(0, 0, PX(18), PY(9));
    GUI_COMMIT(0);
    GUI_NEWCTRL("RscPicture");
    GUI_POSITION(0, 0, PX(18), PY(9));
    GUI_TEXTURE(getText (configFile >> "CfgWeapons" >> _primaryWeapon >> "picture"));
    GUI_COMMIT(0);

    private _secondaryWeapon = secondaryWeapon CLib_Player;
    GUI_POPGRP;
    GUI_NEWGROUP(0, PY(10), PX(18), PY(10));
    GUI_COMMIT(0);
    AAWUI_PANELBACKGROUND(0, 0, PX(18), PY(9));
    GUI_COMMIT(0);
    GUI_NEWCTRL("RscPicture");
    GUI_POSITION(0, 0, PX(18), PY(9));
    GUI_TEXTURE(getText (configFile >> "CfgWeapons" >> _secondaryWeapon >> "picture"));
    GUI_COMMIT(0);

    private _handgunWeapon = handgunWeapon CLib_Player;
    GUI_POPGRP;
    GUI_NEWGROUP(0, PY(20), PX(18), PY(9));
    GUI_COMMIT(0);
    AAWUI_PANELBACKGROUND(0, 0, PX(18), PY(9));
    GUI_COMMIT(0);
    GUI_NEWCTRL("RscPicture");
    GUI_POSITION(0, 0, PX(18), PY(9));
    GUI_TEXTURE(getText (configFile >> "CfgWeapons" >> _handgunWeapon >> "picture"));
    GUI_COMMIT(0);
}] call CFUNC(addEventHandler);

["InventoryOpened", {
    // Dont show vanilla inventory
    _CLib_EventReturn = true;

    private _grpMain = uiNamespace getVariable [QGVAR(GrpMain), controlNull];
    if (!ctrlCommitted _grpMain) exitWith {};

    [UIVAR(Inventory_onShow), _grpMain] call CFUNC(localEvent);
    [{
        params ["_grpMain"];
        [UIVAR(Inventory_onHide), _grpMain] call CFUNC(localEvent);
    }, 1.5, _grpMain] call CFUNC(wait);
}] call CFUNC(addEventHandler);
