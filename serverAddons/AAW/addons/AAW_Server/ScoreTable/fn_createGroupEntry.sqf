#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:


    Parameter(s):


    Returns:

*/
params ["_ctrlGroup", "_group"];

private _display = ctrlParent _ctrlGroup;

private _groupColor = ["#(argb,8,8,3)color(0.6,0,0,1)", "#(argb,8,8,3)color(0.0,0.4,0.8,1)"] select (side _group == side group CLib_player);

_groupColor = [_groupColor, "#(argb,8,8,3)color(0.13,0.54,0.21,1)"] select (_group == group CLib_player);

private _groupHeight = PY(3);

private _playerBg = _display ctrlCreate ["RscPicture", -1, _ctrlGroup];

private _groupBg = _display ctrlCreate ["RscPicture", -1, _ctrlGroup];
_groupBg ctrlSetPosition [PX(0), PY(0), PX(79), PY(3)];
_groupBg ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.3)";
_groupBg ctrlCommit 0;

private _groupDesignatorBg = _display ctrlCreate ["RscPicture", -1, _ctrlGroup];
_groupDesignatorBg ctrlSetPosition [PX(0), PY(0), PX(3), PY(3)];
_groupDesignatorBg ctrlSetText _groupColor;
_groupDesignatorBg ctrlCommit 0;

private _groupDesignator = _display ctrlCreate ["RscPicture", -1, _ctrlGroup];
_groupDesignator ctrlSetPosition [PX(0.5), PY(0.5), PX(2), PY(2)];
_groupDesignator ctrlSetText format ["A3\ui_f\data\igui\cfg\simpletasks\letters\%1_ca.paa", toLower ((groupId _group) select [0, 1])];
_groupDesignator ctrlCommit 0;

private _groupDescriptionTxt = (_group getVariable [QEGVAR(Squad,Description), str _group]);
if (_groupDescriptionTxt == "") then {
    _groupDescriptionTxt = groupId _group;
};

private _groupDescription = _display ctrlCreate ["RscTitle", -1, _ctrlGroup];
_groupDescription ctrlSetFontHeight PY(2.2);
_groupDescription ctrlSetFont "RobotoCondensedBold";
_groupDescription ctrlSetPosition [PX(3.5), PY(0), PX(28), PY(3)];
_groupDescription ctrlSetText toUpper _groupDescriptionTxt;
_groupDescription ctrlCommit 0;

private _groupType = _display ctrlCreate ["RscTitle", -1, _ctrlGroup];
_groupType ctrlSetFontHeight PY(2.2);
_groupType ctrlSetFont "RobotoCondensed";
_groupType ctrlSetTextColor [0.8, 0.8, 0.8, 1];
_groupType ctrlSetPosition [PX(32), PY(0), PX(16), PY(3)];
_groupType ctrlSetText ([format [QUOTE(PREFIX/CfgGroupTypes/%1/displayName), _group getVariable [QEGVAR(Squad,Type), ""]], ""] call CFUNC(getSetting));
_groupType ctrlCommit 0;

{
    private _font = ["RobotoCondensed", "RobotoCondensedBold"] select (_x == CLib_player);
    private _playerGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlGroup];
    _playerGroup ctrlSetPosition [0, _groupHeight, PX(79), PY(4)];
    _playerGroup ctrlCommit 0;


    /*
    private _playerHoverBg = _display ctrlCreate ["RscPicture", -1, _playerGroup];
    _playerHoverBg ctrlSetPosition [PX(0), PY(0.5), PX(79), PY(3)];
    _playerHoverBg ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.3)";
    _playerHoverBg ctrlSetFade 0;
    _playerHoverBg ctrlCommit 0;

    _playerHoverBg ctrlAddEventHandler ["mouseEnter",{
        params ["_ctrl"];
        hint "Enter";
        _ctrl ctrlSetFade 0;
        _ctrl ctrlCommit 0.2;
    }];

    _playerHoverBg ctrlAddEventHandler ["mouseExit",{
        params ["_ctrl"];
        hint "Exit";
        _ctrl ctrlSetFade 1;
        _ctrl ctrlCommit 0.2;
    }];
    */

    private _uid = getPlayerUID _x;

    private _scores = GVAR(ScoreNamespace) getVariable [_uid + "_SCORES", [0, 0, 0, 0, 0]];

    private _selectedKit = _x getVariable [QEGVAR(Kit,kit), ""];
    private _kitIcon = ([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0;

    private _ctrlKitIcon = _display ctrlCreate ["RscPicture", -1, _playerGroup];
    _ctrlKitIcon ctrlSetPosition [PX(0.5), PY(1), PX(2), PY(2)];
    _ctrlKitIcon ctrlSetText _kitIcon;
    _ctrlKitIcon ctrlCommit 0;

    private _ctrlPlayerName = _display ctrlCreate ["RscTitle", -1, _playerGroup];
    _ctrlPlayerName ctrlSetFontHeight PY(2.2);
    _ctrlPlayerName ctrlSetFont _font;
    _ctrlPlayerName ctrlSetTextColor [1, 1, 1, 1];
    _ctrlPlayerName ctrlSetPosition [PX(3.5), PY(0.5), PX(28), PY(3)];
    _ctrlPlayerName ctrlSetText ([_x] call CFUNC(name));
    _ctrlPlayerName ctrlCommit 0;

    private _ctrlPlayerKills = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
    _ctrlPlayerKills ctrlSetFontHeight PY(2.2);
    _ctrlPlayerKills ctrlSetFont _font;
    _ctrlPlayerKills ctrlSetPosition [PX(49), PY(0.5), PX(6), PY(3)];
    _ctrlPlayerKills ctrlSetText str (_scores select 0);
    _ctrlPlayerKills ctrlCommit 0;

    private _ctrlPlayerDeaths = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
    _ctrlPlayerDeaths ctrlSetFontHeight PY(2.2);
    _ctrlPlayerDeaths ctrlSetFont _font;
    _ctrlPlayerDeaths ctrlSetPosition [PX(55), PY(0.5), PX(6), PY(3)];
    _ctrlPlayerDeaths ctrlSetText str (_scores select 1);
    _ctrlPlayerDeaths ctrlCommit 0;

    private _ctrlPlayerMedical = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
    _ctrlPlayerMedical ctrlSetFontHeight PY(2.2);
    _ctrlPlayerMedical ctrlSetFont _font;
    _ctrlPlayerMedical ctrlSetPosition [PX(61), PY(0.5), PX(6), PY(3)];
    _ctrlPlayerMedical ctrlSetText str (_scores select 2);
    _ctrlPlayerMedical ctrlCommit 0;

    private _ctrlPlayerCaptured = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
    _ctrlPlayerCaptured ctrlSetFontHeight PY(2.2);
    _ctrlPlayerCaptured ctrlSetFont _font;
    _ctrlPlayerCaptured ctrlSetPosition [PX(67), PY(0.5), PX(6), PY(3)];
    _ctrlPlayerCaptured ctrlSetText str (_scores select 3);
    _ctrlPlayerCaptured ctrlCommit 0;

    private _ctrlPlayerScore = _display ctrlCreate ["RscTextNoShadow", -1, _playerGroup];
    _ctrlPlayerScore ctrlSetFontHeight PY(2.2);
    _ctrlPlayerScore ctrlSetFont _font;
    _ctrlPlayerScore ctrlSetPosition [PX(73), PY(0.5), PX(6), PY(3)];
    _ctrlPlayerScore ctrlSetText str (_scores select 4);
    _ctrlPlayerScore ctrlCommit 0;

    _groupHeight = _groupHeight + PY(4);
    nil;
} count ([_group] call CFUNC(groupPlayers));
//} count units _group;

_playerBg ctrlSetPosition [0, 0, PX(79), _groupHeight];
_playerBg ctrlSetText "#(argb,8,8,3)color(0.4,0.4,0.4,0.3)";
_playerBg ctrlCommit 0;

_groupHeight;
