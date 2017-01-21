#include "macros.hpp"
/*
    Arma At War

    Author:

    Description:
    [Description]

    Parameter(s):
    None

    Returns:
    None
*/
/*
 * #### TEAM INFO SCREEN ####
 * TEAM INFO
 */
[UIVAR(TeamInfoScreen_onLoad), {
    (_this select 0) params ["_display"];
    uiNamespace setVariable [QGVAR(teamInfoDisplay), _display];

    // The dialog needs one frame until access to controls is possible
    [{
        params ["_display"];

        // Update the values of the UI elements
        UIVAR(RespawnScreen_TeamInfo_update) call CFUNC(localEvent);

        // Fade the control in
        /*
        (_display displayCtrl 100) call FUNC(fadeControl);
        */
    }, _display] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

// When the player side changes update the team info
["playerSideChanged", {
    UIVAR(RespawnScreen_TeamInfo_update) call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_TeamInfo_update), {
    private _display = uiNamespace getVariable [QGVAR(teamInfoDisplay), displayNull];
    if (isNull _display) exitWith {};

    // Update the flag and text
    (_display displayCtrl 102) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1), playerSide], ""]);
    (_display displayCtrl 103) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,SideName_%1), playerSide], ""]);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_ChangeSideBtn_onButtonClick), {
    call EFUNC(Squad,switchSide);
}] call CFUNC(addEventHandler);

/*
 * #### SQUAD SCREEN ####
 */
["missionStarted", {
    ["Squad Screen", CLib_Player, 0, {isNull (uiNamespace getVariable [QGVAR(squadDisplay), displayNull])}, {
        (findDisplay 46) createDisplay UIVAR(SquadScreen);
    },["ignoredCanInteractConditions",["isNotInVehicle"], "showWindow", false]] call CFUNC(addAction);
}] call CFUNC(addEventHandler);

[UIVAR(SquadScreen_onLoad), {
    (_this select 0) params ["_display"];
    uiNamespace setVariable [QGVAR(squadDisplay), _display];

    // The dialog needs one frame until access to controls is possible
    [{
        params ["_display"];

        // Update the values of the UI elements
        UIVAR(RespawnScreen_NewSquadDesignator_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_SquadTypeCombo_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_SquadManagement_update) call CFUNC(localEvent);
        UIVAR(RespawnScreen_SquadMemberManagement_update) call CFUNC(localEvent);

        // Fade the control in
        /*
        (_display displayCtrl 200) call FUNC(fadeControl);
        */
    }, _display] call CFUNC(execNextFrame);
}] call CFUNC(addEventHandler);

/*
 * SQUAD TYPE COMBO
 */
// This should update on side change and when a new squad is created


[UIVAR(RespawnScreen_CreateSquadBtn_onButtonClick), {
    private _display = uiNamespace getVariable [QGVAR(squadDisplay), displayNull];
    if (isNull _display) exitWith {};

    ["", _type] call EFUNC(Squad,createSquad);
}] call CFUNC(addEventHandler);

/*
 * SQUAD LIST
 */
// When the group changes update the squad list for new squad member count
// This needs to be global cause it triggers on side change too
["playerSideChanged", {
    (_this select 0) params ["_newSIde", "_oldSide"];
    [UIVAR(RespawnScreen_SquadManagement_update), _oldSide] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

["groupChanged", {
    [UIVAR(RespawnScreen_SquadManagement_update), playerSide] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_SquadListEntry_onMouseMoving), {
    private _data = _this select 0;
    _data params ["_controlGroup", "_x", "_y", "_over"];

    private _lastHoverState = _controlGroup getVariable ["hoverState", nil];

    if (isNil "_lastHoverState" || {((_lastHoverState || _over) && !(_lastHoverState && _over))}) then {
        _controlGroup setVariable ["hoverState", _over];
        {
            (_controlGroup controlsGroupCtrl _x) ctrlShow _over;
            true;
        } count [5];
        (_controlGroup controlsGroupCtrl 3) ctrlShow !_over;

    };
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_SquadManagement_update), {
    private _display = uiNamespace getVariable [QGVAR(squadDisplay), displayNull];
    if (isNull _display) exitWith {};

    private _ownGroupIndex = -1;

    // Prepare the data for the lnb
    private _lnbData = [];
    {
        private _groupId = groupId _x;
        if (_x == group CLib_Player) then {
            _ownGroupIndex = _forEachIndex;
        };

        private _squadDesignator = _groupId select [0, 1];
        private _description = _x getVariable [QEGVAR(Squad,Description), str _x];
        private _groupType = _x getVariable [QEGVAR(Squad,Type), ""];
        private _groupTypeName = [format [QEGVAR(Squad,GroupTypes_%1_displayName), _groupType], ""] call CFUNC(getSetting);
        private _groupSize = [format [QEGVAR(Squad,GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);

        if (_description == "") then {
            _description = _groupId;
        };

        _lnbData pushBack [[_squadDesignator, _description, _groupTypeName, format ["%1 / %2", count ([_x] call CFUNC(groupPlayers)), _groupSize]], _x];
    } forEach (allGroups select {side _x == playerSide && (groupId _x in EGVAR(Squad,squadIds))});

    // Update the lnb
    private _control = _display displayCtrl 207;
    [_control, _lnbData] call FUNC(updateListNBox); // This may trigger an lbSelChanged event

    for "_i" from 0 to 3 do {
        _control lnbSetColor [[_ownGroupIndex, _i], [0.77, 0.51, 0.08, 1]];
    };
}] call CFUNC(addEventHandler);

/*
 * SQUAD MEMBER LIST
 */
[QGVAR(KitChanged), {
    [UIVAR(RespawnScreen_SquadMemberManagement_update), group CLib_Player] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

[UIVAR(RespawnScreen_SquadMemberListEntry_onMouseMoving), {
    private _data = _this select 0;
    _data params ["_controlGroup", "_x", "_y", "_over"];

    private _lastHoverState = _controlGroup getVariable ["hoverState", nil];

    if (isNil "_lastHoverState" || {(_lastHoverState || _over) && !(_lastHoverState && _over)}) then {
        _controlGroup setVariable ["hoverState", _over];
        {
            (_controlGroup controlsGroupCtrl _x) ctrlShow _over;
            true;
        } count [5,6,7,8,9,10,11];
        (_controlGroup controlsGroupCtrl 3) ctrlShow !_over;

    };
}] call CFUNC(addEventHandler);

["groupChanged", {
    [UIVAR(RespawnScreen_SquadMemberManagement_update), side group CLib_Player] call CFUNC(targetEvent);
}] call CFUNC(addEventHandler);

// SquadManagement
[UIVAR(RespawnScreen_SquadMemberManagement_update), {
    private _display = uiNamespace getVariable [QGVAR(squadDisplay), displayNull];
    if (isNull _display) exitWith {};

    private _controlSquadMemberListHeaderLeft = _display displayCtrl 202;
    private _controlSquadMemberListHeaderRight = _display displayCtrl 203;

    // If player is not in group, show JOIN OR CREATE SQUAD
    if (!(groupId group CLib_Player in EGVAR(Squad,squadIds))) exitWith {
        _controlSquadMemberListHeaderLeft ctrlSetText "JOIN OR CREATE A SQUAD";
        _controlSquadMemberListHeaderRight ctrlShow false;
        (_display displayCtrl 205) ctrlShow false;
        (_display displayCtrl 204) ctrlShow false;
        for "_i" from 210 to 219 do {
            (_display displayCtrl _i) ctrlShow false;
        };
    };

    // HeadingSquadDetails
    _controlSquadMemberListHeaderRight ctrlShow true;
    _controlSquadMemberListHeaderLeft ctrlSetText ((group CLib_Player) getVariable [QEGVAR(Squad,Description), groupId group CLib_Player]);
    (_display displayCtrl 204) ctrlShow true;
    (_display displayCtrl 205) ctrlShow true;
    (_display displayCtrl 205) ctrlSetText format ["A3\ui_f\data\igui\cfg\simpletasks\letters\%1_ca.paa", (groupId group CLib_Player) select [0,1]];
    (_display displayCtrl 205) ctrlSetTextColor [0,0,0,1];
    private _groupType = (group CLib_Player) getVariable [QEGVAR(Squad,Type), ""];
    private _groupTypeName = [format [QEGVAR(Squad,GroupTypes_%1_displayName), _groupType], ""] call CFUNC(getSetting);
    _controlSquadMemberListHeaderRight ctrlSetText format ["%1  |  %2 / %3", _groupTypeName, count ([group CLib_Player] call CFUNC(groupPlayers)), [format [QEGVAR(Squad,GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting)];

    private _lastIndex = -1;

    {

        private _selectedKit = _x getVariable [QEGVAR(Kit,kit), "Rifleman"];
        private _kitIcon = ([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;
        private _kitName = ([_selectedKit, [["displayName", "KitNotFound"]]] call EFUNC(Kit,getKitDetails)) select 0;
        private _memberName = [_x] call CFUNC(name);

        private _ctrlGrp = _display displayCtrl (210+_forEachIndex);
        _ctrlGrp setVariable ["data", _x];
        _ctrlGrp ctrlShow true;
        (_ctrlGrp controlsGroupCtrl 3) ctrlSetText _kitName;
        (_ctrlGrp controlsGroupCtrl 4) ctrlSetText _memberName;
        (_ctrlGrp controlsGroupCtrl 12) ctrlSetText _kitIcon;

        [UIVAR(RespawnScreen_SquadMemberListEntry_onMouseMoving),  [_ctrlGrp, 0, 0, _ctrlGrp getVariable ["hoverState", false]]] call CFUNC(localEvent);

        _lastIndex = _forEachIndex;

    } forEach ([group CLib_Player] call CFUNC(groupPlayers));

    for "_i" from (210+_lastIndex+1) to 219 do {
        (_display displayCtrl _i) ctrlShow false;
        (_display displayCtrl _i) setVariable ["data", objNull];
    };


}] call CFUNC(addEventHandler);
