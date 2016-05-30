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
["groupChanged", {
    _this select 0 params ["_newGroup", "_oldGroup"];

    [UIVAR(RespawnScreen_RoleManagement_update), [_newGroup, _oldGroup]] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

// When the selected entry changed update the weapon tab content
[UIVAR(RespawnScreen_RoleList_onLBSelChanged), {
    UIVAR(RespawnScreen_WeaponTabs_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

// When the selected tab changed update the weapon tab content
[UIVAR(RespawnScreen_WeaponTabs_onToolBoxSelChanged), {
    UIVAR(RespawnScreen_WeaponTabs_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_RoleManagement_update), {
    if (!dialog) exitWith {};

    disableSerialization;

    private _previousSelectedKit = PRA3_Player getVariable [QEGVAR(Kit,kit), ""];

    // RoleList
    #define IDC 303
    private _selectedLnbRow = lnbCurSelRow IDC;
    private _selectedKit = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), _previousSelectedKit] select (_selectedLnbRow == -1);
    PRA3_Player setVariable [QEGVAR(Kit,kit), _selectedKit, true];
    private _visibleKits = call EFUNC(Kit,getAllKits) select {[_x] call EFUNC(Kit,getUsableKitCount) > 0};

    if (_visibleKits isEqualTo []) then {
        lnbSetCurSelRow [IDC, -1];
        _selectedKit = "";
        PRA3_Player setVariable [QEGVAR(Kit,kit), _selectedKit, true];
    } else {
        if (_selectedKit == "" || !(_selectedKit in _visibleKits)) then {
            _selectedKit = _visibleKits select 0;
            PRA3_Player setVariable [QEGVAR(Kit,kit), _selectedKit, true];
        };
    };

    if (_previousSelectedKit != _selectedKit) then {
        [UIVAR(RespawnScreen_SquadManagement_update), group PRA3_Player] call CFUNC(targetEvent);
        [UIVAR(RespawnScreen_RoleManagement_update), group PRA3_Player] call CFUNC(targetEvent);
    };

    lnbClear IDC;
    {
        private _kitName = _x;
        private _kitDetails = [_kitName, [["displayName", ""], ["UIIcon", ""]]] call EFUNC(Kit,getKitDetails);
        _kitDetails params ["_displayName", "_UIIcon"];

        private _usedKits = {(_x getVariable [QEGVAR(Kit,kit), ""]) == _kitName} count ([group PRA3_Player] call CFUNC(groupPlayers));

        private _rowNumber = lnbAddRow [IDC, [_displayName, format ["%1 / %2", _usedKits, [_kitName] call EFUNC(Kit,getUsableKitCount)]]];
        [IDC, [_rowNumber, 0], _x] call CFUNC(lnbSave);

        lnbSetPicture [IDC, [_rowNumber, 0], _UIIcon];

        if (_x == _selectedKit) then {
            DUMP(_rowNumber)
            DUMP(_selectedKit)
            lnbSetCurSelRow [IDC, _rowNumber];
        };

        nil
    } count _visibleKits;
//    private _lnbData = [];
//    _lnbData pushBack [_displayName, _x, _UIIcon];
//    [303, _lnbData] call FUNC(updateListNBox); // This may trigger an lbSelChanged event
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_WeaponTabs_update), {
    disableSerialization;

    // Get the selected value
    private _selectedEntry = lnbCurSelRow 303;
    if (_selectedEntry == -1) exitWith {};
    private _selectedKit = [303, [_selectedEntry, 0]] call CFUNC(lnbLoad);

    // Get the kit data
    private _selectedTabIndex = (lbCurSel 304);
    private _selectedKitDetails = [_selectedKit, [[["primaryWeapon", "secondaryWeapon", "handGunWeapon"] select _selectedTabIndex, ""]]] call EFUNC(Kit,getKitDetails);

    // WeaponPicture
    ctrlSetText [306, getText (configFile >> "CfgWeapons" >> _selectedKitDetails select 0 >> "picture")];

    // WeaponName
    ctrlSetText [307, getText (configFile >> "CfgWeapons" >> _selectedKitDetails select 0 >> "displayName")];
}] call CFUNC(addEventHandler);
