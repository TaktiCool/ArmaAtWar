#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Add or Update Unit in Tracker

    Parameter(s):
    0: New Unit <Object>
    1: Old Unit <Object>

    Returns:
    0: Return Name <TYPE>
*/
params ["_newUnit", "_oldUnit"];

private _sideColor = +(missionNamespace getVariable format [QEGVAR(Mission,SideColor_%1), playerSide]);
private _groupColor = [0, 0.87, 0, 1];
if (side _newUnit == playerSide && !(isHidden _newUnit || !simulationEnabled _newUnit)) then {
    private _iconId = _newUnit getVariable [QGVAR(playerIconId), ""];
    if (_iconId == "") then {
        private _oldIconId = _oldUnit getVariable [QGVAR(playerIconId), ""];
        if (_oldIconId == "") then {
            _iconId = format [QGVAR(player_%1), GVAR(playerCounter)];
            GVAR(playerCounter) = GVAR(playerCounter) + 1;
        } else {
            _iconId = _oldIconId;
        };

        _newUnit setVariable [QGVAR(playerIconId), _iconId];
    };

    private _color = [_sideColor, _groupColor] select (group PRA3_Player isEqualTo group _newUnit);

    private _manIcon = [_newUnit getVariable [QEGVAR(Kit,mapIcon), "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa"], _color, _newUnit, 20, _newUnit, "", 1];
    private _manDescription = ["a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1,1,1,1], _newUnit, 20, 0, name _newUnit, 2];

    [_iconId, [_manIcon]] call CFUNC(addMapIcon);
    [_iconId, [_manIcon, _manDescription], "hover"] call CFUNC(addMapIcon);

    GVAR(currentIcons) pushBack _iconId;

    if (_newUnit == leader _newUnit) then {
        private _groupType = _group getVariable [QGVAR(Type), "Rifle"];
        private _groupMapIcon = [format [QGVAR(GroupTypes_%1_mapIcon), _groupType], "\A3\ui_f\data\map\markers\nato\b_inf.paa"] call CFUNC(getSetting);
        private _groupIconId = format [QGVAR(Group_%1), groupId group _newUnit];
        [
            _groupIconId,
            [
                [_groupMapIcon, _color, [_newUnit, [0, -20]], 25],
                ["a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1,1,1,1], [_newUnit, [0, -20]], 25, 0, (groupId group _newUnit) select [0, 1], 2]
            ]
        ] call CFUNC(addMapIcon);

        [
            _groupIconId,
            "hover",
            {
                disableSerialization;
                (_this select 0) params ["_map", "_xPos", "_yPos"];
                (_this select 1) params ["_group"];


                if (_group isEqualTo GVAR(currentHoverGroup)) exitWith {};
                GVAR(currentHoverGroup) == _group;
                //if (_map != ((findDisplay 12) displayCtrl 51)) exitWith {};

                private _pos = _map ctrlMapWorldToScreen getPosVisual leader _group;
                _pos set [0, (_pos select 0) + 15/640];
                _pos set [1, (_pos select 1) - 15/640];

                private _display = ctrlParent _map;
                private _idd = ctrlIDD _display;

                private _ctrlGrp = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_Group), _idd], controlNull];
                private _ctrlSquadName = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_SquadName), _idd], controlNull];
                private _ctrlSquadType = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_SquadType), _idd], controlNull];
                private _ctrlSquadDescription = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_SquadDescription), _idd], controlNull];
                private _ctrlSquadMemberCount = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_SquadMemberCount), _idd], controlNull];
                private _ctrlBgBottom = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_BgBottom), _idd], controlNull];
                private _ctrlMemberList = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_MemberList), _idd], controlNull];
                private _textSize = PY(1.8)/(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
                if (isNull _ctrlGrp) then {
                    _ctrlGrp = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
                    _ctrlGrp ctrlSetFade 0;
                    _ctrlGrp ctrlCommit 0;
                    uiNamespace setVariable [format [UIVAR(GroupInfo_%1_Group), _idd], _ctrlGrp];

                    private _ctrlBg = _display ctrlCreate ["RscPicture", -1, _ctrlGrp];
                    _ctrlBg ctrlSetText "#(argb,8,8,3)color(0,0,0,0.8)";
                    _ctrlBg ctrlSetPosition [0, 0, PX(17), PY(4)];
                    _ctrlBg ctrlCommit 0;

                    _ctrlBgBottom = _display ctrlCreate ["RscPicture", -1, _ctrlGrp];
                    _ctrlBgBottom ctrlSetText "#(argb,8,8,3)color(0,0,0,0.8)";
                    _ctrlBgBottom ctrlSetPosition [0, PY(4.2), PX(17), PY(12)];
                    uiNamespace setVariable [format [UIVAR(GroupInfo_%1_BgBottom), _idd], _ctrlBgBottom];

                    _ctrlSquadName = _display ctrlCreate ["RscText", -1, _ctrlGrp];
                    _ctrlSquadName ctrlSetFontHeight PY(1.8);
                    _ctrlSquadName ctrlSetPosition [0, 0, PX(8), PY(2)];
                    _ctrlSquadName ctrlSetFont "PuristaBold";
                    _ctrlSquadName ctrlSetText "ALPHA";
                    uiNamespace setVariable [format [UIVAR(GroupInfo_%1_SquadName), _idd], _ctrlSquadName];

                    _ctrlSquadType = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];
                    _ctrlSquadType ctrlSetFontHeight PY(1.8);
                    _ctrlSquadType ctrlSetPosition [PX(8.5), 0, PX(8.5), PY(2)];
                    _ctrlSquadType ctrlSetFont "PuristaMedium";
                    _ctrlSquadType ctrlSetStructuredText parseText "ALPHA";
                    uiNamespace setVariable [format [UIVAR(GroupInfo_%1_SquadType), _idd], _ctrlSquadType];

                    _ctrlSquadDescription = _display ctrlCreate ["RscText", -1, _ctrlGrp];
                    _ctrlSquadDescription ctrlSetFontHeight PY(1.8);
                    _ctrlSquadDescription ctrlSetPosition [0, PY(1.8), PX(12), PY(2)];
                    _ctrlSquadDescription ctrlSetFont "PuristaMedium";
                    _ctrlSquadDescription ctrlSetText "ALPHA";
                    _ctrlSquadDescription ctrlSetTextColor [0.5,0.5,0.5,1];
                    uiNamespace setVariable [format [UIVAR(GroupInfo_%1_SquadDescription), _idd], _ctrlSquadDescription];

                    _ctrlSquadMemberCount = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];
                    _ctrlSquadMemberCount ctrlSetFontHeight PY(1.8);
                    _ctrlSquadMemberCount ctrlSetPosition [PX(12.5), PY(1.8), PX(4.5), PY(2)];
                    _ctrlSquadMemberCount ctrlSetFont "PuristaMedium";
                    _ctrlSquadMemberCount ctrlSetTextColor [0.5,0.5,0.5,1];
                    _ctrlSquadMemberCount ctrlSetStructuredText parseText "ALPHA";;
                    uiNamespace setVariable [format [UIVAR(GroupInfo_%1_SquadMemberCount), _idd], _ctrlSquadMemberCount];

                    _ctrlMemberList = _display ctrlCreate ["RscStructuredText", -1, _ctrlGrp];
                    _ctrlMemberList ctrlSetFontHeight PY(4);
                    _ctrlMemberList ctrlSetPosition [0, PY(4.4), PX(17), PY(11.9)];
                    _ctrlMemberList ctrlSetFont "PuristaMedium";
                    _ctrlMemberList ctrlSetTextColor [1,1,1,1];
                    _ctrlMemberList ctrlSetText "ALPHA";
                    uiNamespace setVariable [format [UIVAR(GroupInfo_%1_MemberList), _idd], _ctrlMemberList];
                };

                _ctrlGrp ctrlSetPosition [_pos select 0, _pos select 1, PX(17), PY(50)];
                _ctrlGrp ctrlShow true;

                _ctrlSquadName ctrlSetText toUpper groupId _group;

                private _groupType = _group getVariable [QEGVAR(Squad,Type), ""];
                private _groupSize = [format [QEGVAR(Squad,GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);
                private _units = ([_group] call CFUNC(groupPlayers));

                _ctrlSquadType ctrlSetStructuredText parseText format ["<t size=""%1"" align=""right"">%2</t>", _textSize, (_group getVariable [QEGVAR(Squad,Type), ""])+" Squad"];
                _ctrlSquadDescription ctrlSetText (_group getVariable [QEGVAR(Squad,Description), ""]);
                _ctrlSquadMemberCount ctrlSetStructuredText parseText format ["<t size=""%1"" align=""right"">%2 / %3</t>", _textSize, count _units, _groupSize];

                private _squadUnits = "";
                private _unitCount = {
                    private _selectedKit = _x getVariable [QEGVAR(kit,kit), ""];
                    private _kitIcon = ([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;
                    _squadUnits = _squadUnits + format["<img size='0.7' color='#ffffff' image='%1'/> %2<br />", _kitIcon,  [_x] call CFUNC(name)];
                    true;
                } count _units;

                _ctrlMemberList ctrlSetStructuredText parseText format ["<t size=""%1"">%2</t>", _textSize, _squadUnits];

                _ctrlBgBottom ctrlSetPosition [0, PY(4.2), PX(17), _unitCount*PY(1.8) + PY(0.4)];

                _ctrlMemberList ctrlSetPosition [0, PY(4.4), PX(17), _unitCount*PY(1.8)];

                {
                    _x ctrlCommit 0;
                    nil;
                } count [_ctrlGrp, _ctrlSquadName, _ctrlSquadType, _ctrlSquadDescription, _ctrlSquadMemberCount, _ctrlBgBottom, _ctrlMemberList];

                if (GVAR(groupInfoPFH) != -1) then {
                    GVAR(groupInfoPFH) call CFUNC(removePerFrameHandler);
                };

                GVAR(groupInfoPFH) = [{
                    disableSerialization;
                    params ["_params", "_id"];
                    _params params ["_group", "_map"];

                    private _pos = _map ctrlMapWorldToScreen getPosVisual leader _group;
                    _pos set [0, (_pos select 0) + 15/640];
                    _pos set [1, (_pos select 1) - 15/640];

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
                }, 0, [_group, _map]] call CFUNC(addPerFrameHandler);
            },
            group _newUnit
        ] call CFUNC(addMapIconEventHandler);

        [
            _groupIconId,
            "hoverout",
            {
                disableSerialization;
                (_this select 0) params ["_map", "_xPos", "_yPos"];
                (_this select 1) params ["_group"];

                if (GVAR(currentHoverGroup) isEqualTo _group) then {
                    GVAR(currentHoverGroup) = grpNull;
                };

                //private _display = uiNamespace getVariable [UIVAR(GroupInfo),displayNull];
                private _grp = uiNamespace getVariable [format [UIVAR(GroupInfo_%1_Group), ctrlIDD ctrlParent _map], controlNull];
                if (!isNull _grp) then {
                    //ctrlDelete _grp;
                    _grp ctrlShow false;
                    _grp ctrlCommit 0;
                    //([UIVAR(GroupInfo)] call BIS_fnc_rscLayer) cutFadeOut 0.2;
                };

                if (GVAR(groupInfoPFH) != -1) then {
                    GVAR(groupInfoPFH) call CFUNC(removePerFrameHandler);
                };

            },
            group _newUnit
        ] call CFUNC(addMapIconEventHandler);
        GVAR(currentIcons) pushBack _groupIconId;
    };

};
