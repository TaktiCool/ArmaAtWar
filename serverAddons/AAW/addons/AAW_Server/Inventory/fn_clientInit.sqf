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

[UIVAR(Inventory_onUpdate), {
    private _grpMain = uiNamespace getVariable [QGVAR(GrpMain), controlNull];
    if ((ctrlFade _grpMain) == 1) exitWith {};
    private _mags = magazines CLib_Player;

    private _primaryWeapon = primaryWeapon CLib_Player
    private _secondaryWeapon = secondaryWeapon CLib_Player
    private _handgunWeapon = handgunWeapon CLib_Player
    private _primaryWeaponCompMags = _primaryWeapon call CFUNC(compatibleMagazines);
    private _primaryWeaponMuzzleCompMags = [];
    {
        if (toLower _x == "this") then {
            _primaryWeaponMuzzleCompMags append ([_primaryWeapon, _x] call CFUNC(compatibleMagazines));
        };
        nil
    } count (getArray (configFile >> "CfgWeapons" >> _primaryWeapon >> "muzzles"));
    _primaryWeaponMuzzleCompMags = _primaryWeaponMuzzleCompMags arrayIntersect _primaryWeaponMuzzleCompMags;

    private _secondaryWeaponCompMags = _secondaryWeapon call CFUNC(compatibleMagazines);
    private _secondaryWeaponMuzzleCompMags = [];
    {
        if (toLower _x == "this") then {
            _secondaryWeaponMuzzleCompMags append ([_secondaryWeapon, _x] call CFUNC(compatibleMagazines));
        };
        nil
    } count (getArray (configFile >> "CfgWeapons" >> _secondaryWeapon >> "muzzles"));
    _secondaryWeaponMuzzleCompMags = _secondaryWeaponMuzzleCompMags arrayIntersect _secondaryWeaponMuzzleCompMags;

    private _handgunWeaponCompMags = _handgunWeapon call CFUNC(compatibleMagazines);
    private _handgunWeaponMuzzleCompMags = [];
    {
        if (toLower _x == "this") then {
            _handgunWeaponMuzzleCompMags append ([_handgunWeapon, _x] call CFUNC(compatibleMagazines));
        };
        nil
    } count (getArray (configFile >> "CfgWeapons" >> _handgunWeapon >> "muzzles"));
    _handgunWeaponMuzzleCompMags = _handgunWeaponMuzzleCompMags arrayIntersect _handgunWeaponMuzzleCompMags;

    private _primaryWeaponMagCount = 0;
    private _primaryWeaponMuzzleMagCount = 0;

    private _secondaryWeaponMagCount = 0;
    private _secondaryWeaponMuzzleMagCount = 0;

    private _handgunWeaponMagCount = 0;
    private _handgunWeaponMuzzleMagCount = 0;

    {
        switch (true) do {
            case (_x in _primaryWeaponCompMags): {
                _primaryWeaponMagCount = _primaryWeaponMagCount + 1;
            };
            case (_x in _primaryWeaponMuzzleCompMags): {
                _primaryWeaponMuzzleMagCount = _primaryWeaponMuzzleMagCount + 1;
            };
            case (_x in _secondaryWeaponCompMags): {
                _secondaryWeaponMagCount = _secondaryWeaponMagCount + 1;
            };
            case (_x in _secondaryWeaponMuzzleCompMags): {
                _secondaryWeaponMuzzleMagCount = _secondaryWeaponMuzzleMagCount + 1;
            };
            case (_x in _handgunWeaponCompMags): {
                _handgunWeaponMagCount = _handgunWeaponMagCount + 1;
            };
            case (_x in _handgunWeaponMuzzleCompMags): {
                _handgunWeaponMuzzleMagCount = _handgunWeaponMuzzleMagCount + 1;
            };
        };
        nil
    } count _mags;
}] call CFUNC(addEventhandler);

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

["playerInventoryChanged", {
    UIVAR(Inventory_onUpdate) call CFUNC(localEvent);
}] call CFUNC(addEventhandler);
