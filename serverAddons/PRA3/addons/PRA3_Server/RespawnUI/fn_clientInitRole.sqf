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

GVAR(lastRoleManagementUIUpdateFrame) = 0;

[UIVAR(RespawnScreen_RoleManagement_update), {
    if (!dialog || GVAR(lastRoleManagementUIUpdateFrame) == diag_frameNo) exitWith {};
    GVAR(lastRoleManagementUIUpdateFrame) = diag_frameNo;

    disableSerialization;

    // RoleList
#define IDC 303
    private _selectedLnbRow = lnbCurSelRow IDC;
    private _previousSelectedKit = PRA3_Player getVariable [QEGVAR(Kit,kit), ""];
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

        private _usedKits = {(_x getVariable [QEGVAR(Kit,kit), ""]) == _kitName} count units group PRA3_Player;

        private _rowNumber = lnbAddRow [IDC, [_displayName, format ["%1 / %2", _usedKits, [_kitName] call EFUNC(Kit,getUsableKitCount)]]];
        [IDC, [_rowNumber, 0], _x] call CFUNC(lnbSave);

        lnbSetPicture [IDC, [_rowNumber, 0], _UIIcon];

        if (_x == _selectedKit) then {
            lnbSetCurSelRow [IDC, _rowNumber];
        };

        nil
    } count _visibleKits;

    // WeaponTabs
#undef IDC
#define IDC 304
    private _index = (lbCurSel IDC);
    if !(_index in [0,1,2]) then {
        _index = 0;
    };
    private _selectedKitDetails = [_selectedKit, [[["primaryWeapon", "secondaryWeapon", "handGunWeapon"] select _index, ""]]] call EFUNC(Kit,getKitDetails);

    // WeaponPicture
#undef IDC
#define IDC 306
    ctrlSetText [IDC, getText (configFile >> "CfgWeapons" >> _selectedKitDetails select 0 >> "picture")];

    // WeaponName
#undef IDC
#define IDC 307
    ctrlSetText [IDC, getText (configFile >> "CfgWeapons" >> _selectedKitDetails select 0 >> "displayName")];
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_RoleList_onLBSelChanged), {
    [UIVAR(RespawnScreen_RoleManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_WeaponTabs_onToolBoxSelChanged), {
    [UIVAR(RespawnScreen_RoleManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);
