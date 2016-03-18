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

/*
 * UI STUFF
 */
[UIVAR(RespawnScreen_RoleManagement_update), {
    if (!dialog) exitWith {};

    disableSerialization;

    // RoleList
#define IDC 303
    private _selectedLnbRow = lnbCurSelRow IDC;
    private _selectedKit = [[IDC, [lnbCurSelRow IDC, 0]] call CFUNC(lnbLoad), ""] select (_selectedLnbRow == -1);
    private _visibleKits = call FUNC(getAllKits) select {[_x] call FUNC(canUseKit)};
    lnbClear IDC;
    {
        private _kitName = _x;
        private _kitDetails = [_kitName, [["displayName", ""], ["UIIcon", ""]]] call FUNC(getKitDetails);
        _kitDetails params ["_displayName", "_UIIcon"];

        private _usedKits = {(_x getVariable [QGVAR(Kit), ""]) == _kitName} count units group PRA3_Player;

        private _rowNumber = lnbAddRow [IDC, [_displayName, format ["%1 / %2", _usedKits, "X"]]]; //@todo show available kits
        [IDC, [_rowNumber, 0], _x] call CFUNC(lnbSave);

        lnbSetPicture [IDC, [_rowNumber, 0], _UIIcon];

        if (_x == _selectedKit) then {
            lnbSetCurSelRow [IDC, _rowNumber];
        };

        nil
    } count _visibleKits;
    if ((lnbSize IDC select 0) > 0 && (_selectedKit == "" || !(_selectedKit in _visibleKits))) then {
        lnbSetCurSelRow [IDC, 0];
        _selectedKit = [IDC, [0, 0]] call CFUNC(lnbLoad);
    };

    // WeaponTabs
#define IDC 304


}] call CFUNC(addEventHandler);