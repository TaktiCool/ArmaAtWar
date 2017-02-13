#include "macros.hpp"
/*
    Arma At War

    Author: BadGuy, joko // Jonas

    Description:
    Add or Update Group in Tracker

    Parameter(s):
    0: Group <Group> (Default: grpNull)
    1: Group icon id <String> (Default: "")
    2: Attach offset <Array> (Default: [0, -20])

    Returns:
    0: Return Id <String>
*/

params [
    ["_group", grpNull, [grpNull]],
    ["_groupIconId", "", [""]],
    ["_attachTo", [0, -20], [[]], 2]
];

private _sideColor = +(missionNamespace getVariable format [QEGVAR(Common,SideColor_%1), playerSide]);
private _groupColor = [0, 0.87, 0, 1];

private _color = [_sideColor, _groupColor] select (group CLib_Player isEqualTo _group);

private _groupType = _group getVariable [QEGVAR(Squad,Type), "Rifle"];
private _groupMapIcon = [format [QEGVAR(Squad,GroupTypes_%1_mapIcon), _groupType], "\A3\ui_f\data\map\markers\nato\b_inf.paa"] call CFUNC(getSetting);
private _iconPos = [vehicle leader _group, _attachTo];

[
    _groupIconId,
    [
        ["ICON", _groupMapIcon, _color, _iconPos, 25, 25],
        ["ICON", "a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1, 1, 1, 1], _iconPos, 25, 25, 0, (groupId _group) select [0, 1], 2]
    ]
] call CFUNC(addMapGraphicsGroup);

[
    _groupIconId,
    "hoverin",
    {
        (_this select 0) params ["_map", "_xPos", "_yPos"];
        (_this select 1) params ["_group", "_attachTo"];

        if (_group isEqualTo GVAR(currentHoverGroup)) exitWith {};
        GVAR(currentHoverGroup) = _group;
        //if (_map != ((findDisplay 12) displayCtrl 51)) exitWith {};

        private _pos = _map ctrlMapWorldToScreen getPosVisual (vehicle leader _group);
        _pos set [0, (_pos select 0) + 15 / 640];
        _pos set [1, (_pos select 1) + (((_attachTo) select 1) + 5) / 480];

        private _display = ctrlParent _map;
        private _idd = ctrlIDD _display;

        private _ctrlGrp = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_Group), _idd], controlNull];
        private _ctrlSquadName = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_SquadName), _idd], controlNull];
        private _ctrlSquadType = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_SquadType), _idd], controlNull];
        private _ctrlSquadDescription = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_SquadDescription), _idd], controlNull];
        private _ctrlSquadMemberCount = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_SquadMemberCount), _idd], controlNull];
        private _ctrlBgBottom = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_BgBottom), _idd], controlNull];
        private _ctrlMemberList = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_MemberList), _idd], controlNull];
        private _textSize = PY(1.8) / (((((safeZoneW / safeZoneH) min 1.2) / 1.2) / 25) * 1);
        if (isNull _ctrlGrp) then {
            _ctrlGrp = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
            _ctrlGrp ctrlSetFade 0;
            _ctrlGrp ctrlCommit 0;
            uiNamespace setVariable [format [UIVAR(GroupInfo_%1_Group), _idd], _ctrlGrp];

            private _ctrlBg = _display ctrlCreate ["RscPicture", -1, _ctrlGrp];
            _ctrlBg ctrlSetText "#(argb,8,8,3)color(0,0,0,0.8)";
            _ctrlBg ctrlSetPosition [0, 0, PX(22), PY(4)];
            _ctrlBg ctrlCommit 0;

            _ctrlBgBottom = _display ctrlCreate ["RscPicture", -1, _ctrlGrp];
            _ctrlBgBottom ctrlSetText "#(argb,8,8,3)color(0,0,0,0.8)";
            _ctrlBgBottom ctrlSetPosition [0, PY(4.2), PX(22), PY(12)];
            uiNamespace setVariable [format [UIVAR(GroupInfo_%1_BgBottom), _idd], _ctrlBgBottom];

            _ctrlSquadName = _display ctrlCreate ["RscText", -1, _ctrlGrp];
            _ctrlSquadName ctrlSetFontHeight PY(1.8);
            _ctrlSquadName ctrlSetPosition [0, 0, PX(11), PY(2)];
            _ctrlSquadName ctrlSetFont "PuristaBold";
            _ctrlSquadName ctrlSetText "ALPHA";
            uiNamespace setVariable [format [UIVAR(GroupInfo_%1_SquadName), _idd], _ctrlSquadName];

            _ctrlSquadType = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];
            _ctrlSquadType ctrlSetFontHeight PY(1.8);
            _ctrlSquadType ctrlSetPosition [PX(11), 0, PX(10.5), PY(2)];
            _ctrlSquadType ctrlSetFont "PuristaMedium";
            _ctrlSquadType ctrlSetStructuredText parseText "ALPHA";
            uiNamespace setVariable [format [UIVAR(GroupInfo_%1_SquadType), _idd], _ctrlSquadType];

            _ctrlSquadDescription = _display ctrlCreate ["RscText", -1, _ctrlGrp];
            _ctrlSquadDescription ctrlSetFontHeight PY(1.8);
            _ctrlSquadDescription ctrlSetPosition [0, PY(1.8), PX(21), PY(2)];
            _ctrlSquadDescription ctrlSetFont "PuristaMedium";
            _ctrlSquadDescription ctrlSetText "ALPHA";
            _ctrlSquadDescription ctrlSetTextColor [0.5, 0.5, 0.5, 1];
            uiNamespace setVariable [format [UIVAR(GroupInfo_%1_SquadDescription), _idd], _ctrlSquadDescription];

            _ctrlSquadMemberCount = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];
            _ctrlSquadMemberCount ctrlSetFontHeight PY(1.8);
            _ctrlSquadMemberCount ctrlSetPosition [PX(16), PY(1.8), PX(5.5), PY(2)];
            _ctrlSquadMemberCount ctrlSetFont "PuristaMedium";
            _ctrlSquadMemberCount ctrlSetTextColor [0.5, 0.5, 0.5, 1];
            _ctrlSquadMemberCount ctrlSetStructuredText parseText "ALPHA";
            uiNamespace setVariable [format [UIVAR(GroupInfo_%1_SquadMemberCount), _idd], _ctrlSquadMemberCount];

            _ctrlMemberList = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];
            _ctrlMemberList ctrlSetFontHeight PY(4);
            _ctrlMemberList ctrlSetPosition [0, PY(4.4), PX(22), PY(11.9)];
            _ctrlMemberList ctrlSetFont "PuristaMedium";
            _ctrlMemberList ctrlSetTextColor [1, 1, 1, 1];
            _ctrlMemberList ctrlSetText "ALPHA";
            uiNamespace setVariable [format [UIVAR(GroupInfo_%1_MemberList), _idd], _ctrlMemberList];
        };

        _ctrlGrp ctrlSetPosition [_pos select 0, _pos select 1, PX(22), PY(50)];
        _ctrlGrp ctrlShow true;

        _ctrlSquadName ctrlSetText toUpper groupId _group;

        private _groupType = _group getVariable [QEGVAR(Squad,Type), ""];
        private _groupSize = [format [QEGVAR(Squad,GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);
        private _units = ([_group] call CFUNC(groupPlayers));

        _ctrlSquadType ctrlSetStructuredText parseText format ["<t size=""%1"" align=""right"">%2</t>", _textSize, (_group getVariable [QEGVAR(Squad,Type), ""]) + " Squad"];
        _ctrlSquadDescription ctrlSetText (_group getVariable [QEGVAR(Squad,Description), ""]);
        _ctrlSquadMemberCount ctrlSetStructuredText parseText format ["<t size=""%1"" align=""right"">%2 / %3</t>", _textSize, count _units, _groupSize];

        private _squadUnits = "";
        private _unitCount = {
            private _selectedKit = _x getVariable [QEGVAR(kit,kit), ""];
            private _kitIcon = ([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;
            _squadUnits = _squadUnits + format ["<img size='0.7' color='#ffffff' image='%1'/> %2<br />", _kitIcon, [_x] call CFUNC(name)];
            true;
        } count _units;

        _ctrlMemberList ctrlSetStructuredText parseText format ["<t size=""%1"">%2</t>", _textSize, _squadUnits];

        _ctrlBgBottom ctrlSetPosition [0, PY(4.2), PX(22), _unitCount * PY(1.8) + PY(0.4)];

        _ctrlMemberList ctrlSetPosition [0, PY(4.4), PX(22), _unitCount * PY(1.8)];

        {
            _x ctrlCommit 0;
            nil;
        } count [_ctrlGrp, _ctrlSquadName, _ctrlSquadType, _ctrlSquadDescription, _ctrlSquadMemberCount, _ctrlBgBottom, _ctrlMemberList];

        if (GVAR(groupInfoPFH) != -1) then {
            GVAR(groupInfoPFH) call CFUNC(removePerFrameHandler);
        };

        GVAR(groupInfoPFH) = [{
            params ["_params", "_id"];
            _params params ["_group", "_map", "_attachTo"];

            private _pos = _map ctrlMapWorldToScreen getPosVisual (vehicle leader _group);
            _pos set [0, (_pos select 0) + 15 / 640];
            _pos set [1, (_pos select 1) + ((_attachTo select 1) + 5) / 480];

            private _grp = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_Group), ctrlIDD ctrlParent _map], controlNull];

            if (isNull _grp || (_map == ((findDisplay 12) displayCtrl 51) && !visibleMap) || isNull _map) exitWith {
                _id call CFUNC(removePerFrameHandler);
                _grp ctrlShow false;
                //ctrlDelete _grp;
                _grp ctrlCommit 0;
            };

            _grp ctrlSetPosition _pos;
            _grp ctrlCommit 0;

            /*
            if (!visibleMap) then {
                if (!isNull _display) then {
                    ([UIVAR(GroupInfo)] call BIS_fnc_rscLayer) cutFadeOut 0.2;
                };
                _id call CFUNC(removePerFrameHandler);
            };
            */
        }, 0, [_group, _map, _attachTo]] call CFUNC(addPerFrameHandler);
    },
    [_group, _attachTo]
] call CFUNC(addMapGraphicsEventHandler);

[
    _groupIconId,
    "hoverout",
    {
        (_this select 0) params ["_map", "_xPos", "_yPos"];
        (_this select 1) params ["_group"];

        if (GVAR(currentHoverGroup) isEqualTo _group) then {
            GVAR(currentHoverGroup) = grpNull;
        };

        //private _display = uiNamespace getVariable [UIVAR(GroupInfo),displayNull];
        private _grp = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_Group), ctrlIDD ctrlParent _map], controlNull];
        if !(isNull _grp) then {
            //ctrlDelete _grp;
            _grp ctrlShow false;
            _grp ctrlCommit 0;
            //([UIVAR(GroupInfo)] call BIS_fnc_rscLayer) cutFadeOut 0.2;
        };

        if (GVAR(groupInfoPFH) != -1) then {
            GVAR(groupInfoPFH) call CFUNC(removePerFrameHandler);
        };
    },
    _group
] call CFUNC(addMapGraphicsEventHandler);
_groupIconId;
