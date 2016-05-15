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

                if (_map != ((findDisplay 12) displayCtrl 51)) exitWith {};
                private _pos = _map ctrlMapWorldToScreen getPosVisual leader _group;
                _pos set [0, (_pos select 0) + 15/640];
                _pos set [1, (_pos select 1) - 15/640];

                ([UIVAR(GroupInfo)] call BIS_fnc_rscLayer) cutRsc [UIVAR(GroupInfo),"PLAIN",0.2];
                private _display = uiNamespace getVariable [UIVAR(GroupInfo),displayNull];
                (_display displayCtrl 6000) ctrlSetPosition _pos;
                (_display displayCtrl 6001) ctrlSetText toUpper groupId _group;
                private _groupType = _group getVariable [QEGVAR(Squad,Type), ""];
                private _groupSize = [format [QEGVAR(Squad,GroupTypes_%1_groupSize), _groupType], 0] call CFUNC(getSetting);
                private _units = units _group;
                (_display displayCtrl 6002) ctrlSetText ((_group getVariable [QEGVAR(Squad,Type), ""])+" Squad");
                (_display displayCtrl 6003) ctrlSetText (_group getVariable [QEGVAR(Squad,Description), ""]);
                (_display displayCtrl 6004) ctrlSetText format ["%1 / %2",count _units, _groupSize];
                private _squadUnits = "";
                private _unitCount = {
                    private _selectedKit = _x getVariable [QEGVAR(kit,kit), ""];
                    private _kitIcon = ([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;
                    (_display displayCtrl 6006) lnbSetPicture [[_rowNumber, 0], _kitIcon];
                    _squadUnits = _squadUnits + format["<img size='0.7' color='#ffffff' image='%1'/> %2<br />", _kitIcon,  [_x] call CFUNC(name)];
                    true;
                } count _units;

                (_display displayCtrl 6006) ctrlSetStructuredText parseText _squadUnits;

                _pos = ctrlPosition (_display displayCtrl 6005);
                _pos set [3, _unitCount*PY(1.8) + PY(0.4)];
                (_display displayCtrl 6005) ctrlSetPosition _pos;

                _pos = ctrlPosition (_display displayCtrl 6006);
                _pos set [3, _unitCount*PY(1.8)];
                (_display displayCtrl 6006) ctrlSetPosition _pos;

                {
                    (_display displayCtrl _x) ctrlCommit 0;
                    nil;
                } count [6000, 6001, 6002, 6003, 6004, 6005, 6006];

                [{
                    disableSerialization;
                    params ["_params", "_id"];
                    _params params ["_group", "_map"];

                    private _pos = _map ctrlMapWorldToScreen getPosVisual leader _group;
                    _pos set [0, (_pos select 0) + 15/640];
                    _pos set [1, (_pos select 1) - 15/640];

                    private _display = uiNamespace getVariable [UIVAR(GroupInfo),displayNull];
                    if (!isNull _display) then {
                        (_display displayCtrl 6000) ctrlSetPosition _pos;
                        (_display displayCtrl 6000) ctrlCommit 0;
                    } else {
                        _id call CFUNC(removePerFrameHandler);
                    };
                    if (!visibleMap) then {
                        if (!isNull _display) then {
                            ([UIVAR(GroupInfo)] call BIS_fnc_rscLayer) cutFadeOut 0.2;
                        };
                        _id call CFUNC(removePerFrameHandler);
                    };
                }, 0, [_group, _map]] call CFUNC(addPerFrameHandler);
            },
            group _newUnit
        ] call CFUNC(addMapIconEventHandler);

        [
            _groupIconId,
            "hoverout",
            {
                disableSerialization;
                private _display = uiNamespace getVariable [UIVAR(GroupInfo),displayNull];
                if (!isNull _display) then {
                    ([UIVAR(GroupInfo)] call BIS_fnc_rscLayer) cutFadeOut 0.2;
                };

            },
            group _newUnit
        ] call CFUNC(addMapIconEventHandler);
        GVAR(currentIcons) pushBack _groupIconId;
    };

};
