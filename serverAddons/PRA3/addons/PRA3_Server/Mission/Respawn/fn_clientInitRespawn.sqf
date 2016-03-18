#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    -

    Parameter(s):
    -

    Returns:
    -
*/

[UIVAR(RespawnScreen_onLoad), {
    GVAR(selectWeaponTabIndex) = 0;

    showHUD [true,true,true,true,true,true,false,true];

    [UIVAR(RespawnScreen), true] call CFUNC(blurScreen);

    // The dialog needs one frame until access to controls via IDC is possible
    [{
        [UIVAR(RespawnScreen_TeamInfo_update)] call CFUNC(localEvent);
        [UIVAR(RespawnScreen_SquadManagement_update)] call CFUNC(localEvent);
        [UIVAR(RespawnScreen_RoleManagement_update)] call CFUNC(localEvent);
    }] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_onUnload), {
    showHUD [true,true,true,true,true,true,true,true];

    [UIVAR(RespawnScreen), false] call CFUNC(blurScreen);
}] call CFUNC(addEventHandler);

["Killed", {
    setPlayerRespawnTime 10e10;

    createDialog UIVAR(RespawnScreen);
}] call CFUNC(addEventHandler);

["groupChanged", {
    [UIVAR(RespawnScreen_SquadManagement_update)] call CFUNC(globalEvent);
}] call CFUNC(addEventHandler);

["playerSideChanged", {
    [UIVAR(RespawnScreen_TeamInfo_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["leaderChanged", {
    [UIVAR(RespawnScreen_SquadManagement_update)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

GVAR(selectWeaponTabIndex) = 0;
[QGVAR(updateWeaponList), {
    (_this select 0) params ["_control", "_entryIndex"];
    if (!isNil "_entryIndex") then {
        GVAR(selectWeaponTabIndex) = _entryIndex;
    };
    disableSerialization;

    if (!dialog) exitWith {};

    private _currentSelection = lnbCurSelRow 303;

    if (_currentSelection >= 0) then {
        private _kitName = [303, [_currentSelection, 0]] call CFUNC(lnbLoad);
        private _kitDetails = [_kitName, [[["primaryWeapon", "secondaryWeapon", "handGunWeapon"] select GVAR(selectWeaponTabIndex), ""]]] call FUNC(getKitDetails);
        ctrlSetText [306, getText (configFile >> "CfgWeapons" >> _kitDetails select 0 >> "picture")];
        ctrlSetText [307, getText (configFile >> "CfgWeapons" >> _kitDetails select 0 >> "displayName")];
    };
}] call CFUNC(addEventHandler);

[QGVAR(updateMapControl), {
    disableSerialization;

    if (!dialog) exitWith {};

    private _map = (findDisplay 1000) displayCtrl 700;
    private _currentSelection = lnbCurSelRow 403;

    if (_currentSelection >= 0) then {
        _map ctrlMapAnimAdd [0.5, 0.15, [403, [_currentSelection, 0]] call CFUNC(lnbLoad)];
        ctrlMapAnimCommit _map;
    };
}] call CFUNC(addEventHandler);

[QGVAR(updateDeploymentList), {
    disableSerialization;

    if (!dialog) exitWith {};

    lnbClear 403;

    private _base = ["base_" + (str playerSide)] call FUNC(getSector);
    private _rowNumber = lnbAddRow [403, ["BASE"]];
    [403, [_rowNumber, 0], getPos _base] call CFUNC(lnbSave);
    lnbSetPicture [403, [_rowNumber, 0], "a3\ui_f\data\map\Markers\Military\box_ca.paa"];

    private _rallyPoint = (group PRA3_Player) getVariable [QGVAR(rallyPoint), [0, [], [], 0]];
    _rallyPoint params ["_placedTime", "_position", "_objects", "_spawnCount"];
    if (!(_position isEqualTo []) && _spawnCount > 0) then { // if spawnCount is zero the rally point should not exist (handle this on spawn)
        _rowNumber = lnbAddRow [403, ["RALLYPOINT " + ((group PRA3_Player) getVariable [QGVAR(Id), ""])]];
        [403, [_rowNumber, 0], _position] call CFUNC(lnbSave);
        lnbSetPicture [403, [_rowNumber, 0], "a3\ui_f\data\map\Markers\Military\triangle_ca.paa"];
    };

    lnbSetCurSelRow [403, 0];
}] call CFUNC(addEventHandler);

[QGVAR(requestSpawn), {
    disableSerialization;

    if (!dialog) exitWith {};

    // Check squad
    if ((group PRA3_Player) getVariable [QGVAR(Id), ""] == "") exitWith {systemChat "Join a squad!"};

    // Check role
    [{
        private _currentRoleSelection = lnbCurSelRow 303;
        if (_currentRoleSelection < 0) exitWith {systemChat "Select a role!"};
        private _kitName = [303, [_currentRoleSelection, 0]] call CFUNC(lnbLoad);
        if (!([_kitName] call FUNC(canUseKit))) exitWith {systemChat "Select another role!"};

        // Check deployment
        private _currentDeploymentSelection = lnbCurSelRow 403;
        if (_currentDeploymentSelection < 0) exitWith {systemChat "Select spawn point!"};
        private _deployPosition = [403, [_currentDeploymentSelection, 0]] call CFUNC(lnbLoad);
        //@todo rally ticket check

        [playerSide, group PRA3_Player, _deployPosition] call FUNC(respawn);

        // Apply selected kit
        [_kitName] call FUNC(applyKit);
        [QGVAR(updateRoleList), group PRA3_Player] call CFUNC(targetEvent);

        closeDialog 2;
    }] call CFUNC(mutex);
}] call CFUNC(addEventHandler);