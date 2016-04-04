#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init Kit Module

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(KitGroups), missionConfigFile >> "PRA3" >> "KitGroups"] call CFUNC(loadSettings);
{
    [format [QGVAR(Kit_%1), configName _x], _x >> "Kits"] call CFUNC(loadSettings);
    nil
} count ("true" configClasses (missionConfigFile >> "PRA3" >> "Sides"));

["vehicleChanged", {
    (_this select 0) params ["_newVehicle", "_oldVehicle"];

    // Check restrictions if player entered a vehicle
    if (_newVehicle != PRA3_Player) then {
        call FUNC(checkVehicleRestrictions);
    };
}] call CFUNC(addEventHandler);

// SeatSwitchedMan ist not working because we need the old position
["assignedVehicleRoleChanged", {
    (_this select 0) params ["_newVehicleRole", "_oldVehicleRole"];

    // Check restriction if player switched the seat
    if (!(_oldVehicleRole isEqualTo [])) then {
        [_oldVehicleRole] call FUNC(checkVehicleRestrictions);
    };
}] call CFUNC(addEventHandler);

/*
 * UI STUFF
 */
GVAR(lastRoleManagementUIUpdateFrame) = 0;

[UIVAR(RespawnScreen_RoleManagement_update), {
    if (!dialog || GVAR(lastRoleManagementUIUpdateFrame) == diag_frameNo) exitWith {};
    GVAR(lastRoleManagementUIUpdateFrame) = diag_frameNo;

    disableSerialization;

    // RoleList
#define IDC 303
    private _selectedLnbRow = lnbCurSelRow IDC;
    private _previousSelectedKit = PRA3_Player getVariable [QGVAR(kit), ""];
    private _selectedKit = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), _previousSelectedKit] select (_selectedLnbRow == -1);
    PRA3_Player setVariable [QGVAR(kit), _selectedKit, true];
    private _visibleKits = call FUNC(getAllKits) select {[_x] call FUNC(getUsableKitCount) > 0};

    if (_visibleKits isEqualTo []) then {
        lnbSetCurSelRow [IDC, -1];
        _selectedKit = "";
        PRA3_Player setVariable [QGVAR(kit), _selectedKit, true];
    } else {
        if (_selectedKit == "" || !(_selectedKit in _visibleKits)) then {
            _selectedKit = _visibleKits select 0;
            PRA3_Player setVariable [QGVAR(kit), _selectedKit, true];
        };
    };

    if (_previousSelectedKit != _selectedKit) then {
        [UIVAR(RespawnScreen_RoleManagement_update), group PRA3_Player] call CFUNC(targetEvent);
    };

    lnbClear IDC;
    {
        private _kitName = _x;
        private _kitDetails = [_kitName, [["displayName", ""], ["UIIcon", ""]]] call FUNC(getKitDetails);
        _kitDetails params ["_displayName", "_UIIcon"];

        private _usedKits = {(_x getVariable [QGVAR(kit), ""]) == _kitName} count units group PRA3_Player;

        private _rowNumber = lnbAddRow [IDC, [_displayName, format ["%1 / %2", _usedKits, [_kitName] call FUNC(getUsableKitCount)]]];
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
    private _selectedKitDetails = [_selectedKit, [[["primaryWeapon", "secondaryWeapon", "handGunWeapon"] select _index, ""]]] call FUNC(getKitDetails);

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
