#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:


    Parameter(s):


    Returns:

*/
private _display = uiNamespace getVariable [QGVAR(scoreTable), displayNull];
if (isNull _display) exitWith {};

/*
 * FRIENDLY LIST
 */
private _ctrlFriendlyPlayerListGroup = _display displayCtrl 1100;
{ctrlDelete _x; nil} count (_ctrlFriendlyPlayerListGroup getVariable [QGVAR(entries), []]);

private _entries = [];
private _verticalPosition = 0;
{ // Squad loop
    private _groupId = groupId _x;
    private _groupDescription = _x getVariable [QEGVAR(Squad,Description), str _x];
    private _groupType = _x getVariable [QEGVAR(Squad,Type), ""];
    if (_groupDescription == "") then {
        _groupDescription = _groupId;
    };

    private _squadEntry = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlFriendlyPlayerListGroup];

    private _ctrlSquadBackground = _display ctrlCreate ["RscPicture", -1, _squadEntry];
    _ctrlSquadBackground ctrlSetText "#(argb,8,8,3)color(0.4,0.4,0.4,0.3)";

    private _ctrlSquadHeaderBackground = _display ctrlCreate ["RscPicture", -1, _squadEntry];
    _ctrlSquadHeaderBackground ctrlSetPosition [PX(0), PY(0), PX(79), PY(3)];
    _ctrlSquadHeaderBackground ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.3)";
    _ctrlSquadHeaderBackground ctrlCommit 0;

    private _ctrlSquadDesignatorBackground = _display ctrlCreate ["RscPicture", -1, _squadEntry];
    _ctrlSquadDesignatorBackground ctrlSetPosition [PX(0), PY(0), PX(3), PY(3)];
    _ctrlSquadDesignatorBackground ctrlSetText (["#(argb,8,8,3)color(0.0,0.4,0.8,1)", "#(argb,8,8,3)color(0.13,0.54,0.21,1)"] select (_x == group CLib_Player));
    _ctrlSquadDesignatorBackground ctrlCommit 0;

    private _ctrlSquadDesignator = _display ctrlCreate ["RscPicture", -1, _squadEntry];
    _ctrlSquadDesignator ctrlSetPosition [PX(0.5), PY(0.5), PX(2), PY(2)];
    _ctrlSquadDesignator ctrlSetText format ["A3\ui_f\data\igui\cfg\simpletasks\letters\%1_ca.paa", toLower (_groupId select [0, 1])];
    _ctrlSquadDesignator ctrlCommit 0;

    private _ctrlSquadDescription = _display ctrlCreate ["RscTitle", -1, _squadEntry];
    _ctrlSquadDescription ctrlSetFontHeight PY(2.2);
    _ctrlSquadDescription ctrlSetFont "RobotoCondensedBold";
    _ctrlSquadDescription ctrlSetPosition [PX(3.5), PY(0), PX(28), PY(3)];
    _ctrlSquadDescription ctrlSetText toUpper _groupDescription;
    _ctrlSquadDescription ctrlCommit 0;

    private _ctrlSquadType = _display ctrlCreate ["RscTitle", -1, _squadEntry];
    _ctrlSquadType ctrlSetFontHeight PY(2.2);
    _ctrlSquadType ctrlSetFont "RobotoCondensed";
    _ctrlSquadType ctrlSetTextColor [0.8, 0.8, 0.8, 1];
    _ctrlSquadType ctrlSetPosition [PX(32), PY(0), PX(16), PY(3)];
    _ctrlSquadType ctrlSetText ([format [QUOTE(PREFIX/CfgGroupTypes/%1/displayName), _groupType], ""] call CFUNC(getSetting));
    _ctrlSquadType ctrlCommit 0;

    private _squadEntryHeight = PY(3);
    { // Player loop
        private _font = ["RobotoCondensed", "RobotoCondensedBold"] select (_x == CLib_player);
        private _uid = getPlayerUID _x;
        private _scores = GVAR(ScoreNamespace) getVariable [_uid + "_SCORES", [0, 0, 0, 0, 0]];
        private _selectedKit = _x getVariable [QEGVAR(Kit,kit), ""];

        private _playerRow = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _squadEntry];
        _playerRow ctrlSetPosition [0, _squadEntryHeight, PX(79), PY(4)];
        _playerRow ctrlCommit 0;

        private _ctrlKitIcon = _display ctrlCreate ["RscPicture", -1, _playerRow];
        _ctrlKitIcon ctrlSetPosition [PX(0.5), PY(1), PX(2), PY(2)];
        _ctrlKitIcon ctrlSetText (([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0);
        _ctrlKitIcon ctrlCommit 0;

        private _ctrlPlayerName = _display ctrlCreate ["RscTitle", -1, _playerRow];
        _ctrlPlayerName ctrlSetFontHeight PY(2.2);
        _ctrlPlayerName ctrlSetFont _font;
        _ctrlPlayerName ctrlSetTextColor [1, 1, 1, 1];
        _ctrlPlayerName ctrlSetPosition [PX(3.5), PY(0.5), PX(28), PY(3)];
        _ctrlPlayerName ctrlSetText ([_x] call CFUNC(name));
        _ctrlPlayerName ctrlCommit 0;

        {
            private _ctrlScoreText = _display ctrlCreate ["RscTextNoShadow", -1, _playerRow];
            _ctrlScoreText ctrlSetFontHeight PY(2.2);
            _ctrlScoreText ctrlSetFont _font;
            _ctrlScoreText ctrlSetPosition [PX(6) * _forEachIndex + PX(49), PY(0.5), PX(6), PY(3)];
            _ctrlScoreText ctrlSetText str _x;
            _ctrlScoreText ctrlCommit 0;
        } forEach _scores;

        _squadEntryHeight = _squadEntryHeight + PY(4);
        nil
    } count ([_x] call CFUNC(groupPlayers));

    _ctrlSquadBackground ctrlSetPosition [0, 0, PX(79), _squadEntryHeight];
    _ctrlSquadBackground ctrlCommit 0;

    _squadEntry ctrlSetPosition [0, _verticalPosition, PX(80), _squadEntryHeight];
    _squadEntry ctrlCommit 0;

    _entries pushBack _squadEntry;
    _verticalPosition = _verticalPosition + _squadEntryHeight + PY(1);
    nil
} count (allGroups select {side _x == playerSide && groupId _x in EGVAR(Squad,squadIds) && count units _x > 0});

/*
 * ENEMY LIST
 */
private _enemySide = (EGVAR(Common,competingSides) - [playerSide]) select 0;
private _ctrlEnemyPlayerListGroup = _display displayCtrl 1200;
{ctrlDelete _x; nil} count (_ctrlEnemyPlayerListGroup getVariable [QGVAR(entries), []]);

_entries = [];
_verticalPosition = 0;
{ // Squad loop
    if (side _x == _enemySide && groupId _x in EGVAR(Squad,squadIds) && count units _x > 0) then {
        { // Player loop
            private _scores = GVAR(ScoreNamespace) getVariable [format ["%1_SCORES", getPlayerUID _x], [0, 0, 0, 0, 0]];

            private _playerEntry = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _ctrlEnemyPlayerListGroup];
            _playerEntry ctrlSetPosition [0, _verticalPosition, PX(39), PY(4)];
            _playerEntry ctrlCommit 0;

            private _ctrlPlayerName = _display ctrlCreate ["RscTitle", -1, _playerEntry];
            _ctrlPlayerName ctrlSetFontHeight PY(2.2);
            _ctrlPlayerName ctrlSetFont "RobotoCondensed";
            _ctrlPlayerName ctrlSetTextColor [1, 1, 1, 1];
            _ctrlPlayerName ctrlSetPosition [PX(1), PY(0.5), PX(38), PY(3)];
            _ctrlPlayerName ctrlSetText ([_x] call CFUNC(name));
            _ctrlPlayerName ctrlCommit 0;

            private _ctrlPlayerScore = _display ctrlCreate ["RscTextNoShadow", -1, _playerEntry];
            _ctrlPlayerScore ctrlSetFontHeight PY(2.2);
            _ctrlPlayerScore ctrlSetFont "RobotoCondensed";
            _ctrlPlayerScore ctrlSetPosition [PX(33), PY(0.5), PX(6), PY(3)];
            _ctrlPlayerScore ctrlSetText str (_scores select 4);
            _ctrlPlayerScore ctrlCommit 0;

            _entries pushBack _playerEntry;
            _verticalPosition = _verticalPosition + PY(4);
            nil
        } count ([_x] call CFUNC(groupPlayers));
    };
    nil
} count allGroups;

_ctrlEnemyPlayerListGroup setVariable [QGVAR(entries), _entries];

private _ctrlEnemyPlayerBackground = _display displayCtrl 1201;
private _position = ctrlPosition _ctrlEnemyPlayerBackground;
_position set [3, _verticalPosition];
_ctrlEnemyPlayerBackground ctrlSetPosition _position;
_ctrlEnemyPlayerBackground ctrlCommit 0;
