#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author:

    Description:
    [Description]

    Parameter(s):
    None

    Returns:
    None
*/
[UIVAR(RoleScreen_onLoad), {
    // The dialog needs one frame until access to controls is possible
    [{
        // Update the values of the UI elements
        UIVAR(RespawnScreen_RoleManagement_update) call CFUNC(localEvent);

        // Fade the control in
        300 call FUNC(fadeControl);
    }] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

// When player changes the group update the role management for his old and his new group
["groupChanged", {
    [UIVAR(RespawnScreen_RoleManagement_update), _this select 0] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_RoleManagement_update), {
    if (!dialog) exitWith {};

    // Prepare the data for the lnb
    private _lnbData = [];
    {
        private _kitName = _x;

        // Only list usable kits
        private _usableKitCount = [_kitName] call EFUNC(Kit,getUsableKitCount);
        if (_usableKitCount > 0) then {
            // Get the required details
            private _kitDetails = [_kitName, [["displayName", ""], ["UIIcon", ""]]] call EFUNC(Kit,getKitDetails);
            _kitDetails params ["_displayName", "_UIIcon"];

            private _usedKits = {_x getVariable [QEGVAR(Kit,kit), ""] == _kitName} count ([group PRA3_Player] call CFUNC(groupPlayers));
            _lnbData pushBack [[_displayName, format ["%1 / %2", _usedKits, _usableKitCount]], _kitName, _UIIcon];
        };
        nil
    } count (call EFUNC(Kit,getAllKits));

    // Update the lnb
    [303, _lnbData, PRA3_Player getVariable QEGVAR(Kit,kit)] call FUNC(updateListNBox); // This may trigger an lbSelChanged event
}] call CFUNC(addEventHandler);

// When the selected entry changed update the weapon tab content
[UIVAR(RespawnScreen_RoleList_onLBSelChanged), {
    disableSerialization;

    // Get the selected value
    private _selectedEntry = lnbCurSelRow 303;
    if (_selectedEntry == -1) exitWith {};

    private _previousSelectedKit = PRA3_Player getVariable [QEGVAR(Kit,kit), ""];
    private _selectedKit = [303, [_selectedEntry, 0]] call CFUNC(lnbLoad);

    // Instantly assign the kit (do not apply) if changed
    if (_previousSelectedKit != _selectedKit) then {
        PRA3_Player setVariable [QEGVAR(Kit,kit), _selectedKit, true];
        [UIVAR(RespawnScreen_RoleManagement_update), group PRA3_Player] call CFUNC(targetEvent);
        [QGVAR(KitChanged)] call CFUNC(localEvent);
    } else {
        UIVAR(RespawnScreen_WeaponTabs_update) call CFUNC(localEvent);
    };
}] call CFUNC(addEventHandler);

// When the selected tab changed update the weapon tab content
[UIVAR(RespawnScreen_WeaponTabs_onToolBoxSelChanged), {
    UIVAR(RespawnScreen_WeaponTabs_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_WeaponTabs_update), {
    disableSerialization;

    // Get the selected value
    private _selectedEntry = lnbCurSelRow 303;
    if (_selectedEntry == -1) exitWith {};
    private _selectedKit = [303, [_selectedEntry, 0]] call CFUNC(lnbLoad);

    // Get the kit data
    private _selectedTabIndex = (lbCurSel 304);
    private _selectedKitDetails = [_selectedKit, [[["primaryWeapon", "handGunWeapon", "secondaryWeapon"] select _selectedTabIndex, ""]]] call EFUNC(Kit,getKitDetails);

    // WeaponPicture
    ctrlSetText [306, getText (configFile >> "CfgWeapons" >> _selectedKitDetails select 0 >> "picture")];

    // WeaponName
    ctrlSetText [307, getText (configFile >> "CfgWeapons" >> _selectedKitDetails select 0 >> "displayName")];
}] call CFUNC(addEventHandler);
