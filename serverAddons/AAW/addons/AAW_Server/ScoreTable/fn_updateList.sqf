#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:


    Parameter(s):


    Returns:

*/
params ["_listGroup", "_side", "_extended"];

(ctrlPosition _listGroup) params ["_listGroupX", "_listGroupY", "_listGroupWidth", "_listGroupHeight"];
_listGroupWidth = _listGroupWidth - PX(1); // ListGroup is smaller due to possible Scrollbar

{ctrlDelete _x; nil} count (_listGroup getVariable [QGVAR(entries), []]);
private _display = uiNamespace getVariable [QGVAR(scoreTable), displayNull];
private _entries = [];
private _verticalPosition = 0;
private _squadEntry = _listGroup;
{ // Squad loop
    private _squadEntryHeight = 0;
    private _ctrlSquadBackground = ctrlNull;

    if (_extended) then {
        private _groupId = groupId _x;
        private _groupDescription = _x getVariable [QEGVAR(Squad,Description), str _x];
        private _groupType = _x getVariable [QEGVAR(Squad,Type), ""];
        if (_groupDescription == "") then {
            _groupDescription = _groupId;
        };

        _squadEntry = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _listGroup];

        _ctrlSquadBackground = _display ctrlCreate ["RscPicture", -1, _squadEntry];
        _ctrlSquadBackground ctrlSetText "#(argb,8,8,3)color(0.4,0.4,0.4,0.3)";

        private _ctrlSquadHeaderBackground = _display ctrlCreate ["RscPicture", -1, _squadEntry];
        _ctrlSquadHeaderBackground ctrlSetPosition [PX(0), PY(0), _listGroupWidth, PY(3)];
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
        _ctrlSquadDescription ctrlSetPosition [PX(3.5), PY(0), PX(20), PY(3)];
        _ctrlSquadDescription ctrlSetText toUpper _groupDescription;
        _ctrlSquadDescription ctrlCommit 0;

        private _ctrlSquadType = _display ctrlCreate ["RscTitle", -1, _squadEntry];
        _ctrlSquadType ctrlSetFontHeight PY(2.2);
        _ctrlSquadType ctrlSetFont "RobotoCondensed";
        _ctrlSquadType ctrlSetTextColor [0.8, 0.8, 0.8, 1];
        _ctrlSquadType ctrlSetPosition [PX(21), PY(0), PX(16), PY(3)];
        _ctrlSquadType ctrlSetText ([format [QUOTE(PREFIX/CfgGroupTypes/%1/displayName), _groupType], ""] call CFUNC(getSetting));
        _ctrlSquadType ctrlCommit 0;

        _squadEntryHeight = PY(3);

        _entries pushBack _squadEntry;
    };

    { // Player loop
        private _uid = getPlayerUID _x;
        private _scores = GVAR(ScoreNamespace) getVariable [_uid + "_SCORES", [0, 0, 0, 0, 0, 0]];
        private _font = ["RobotoCondensed", "RobotoCondensedBold"] select (_x == CLib_player);
        private _selectedKit = _x getVariable [QEGVAR(Kit,kit), ""];

        private _playerRow = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _squadEntry];
        _playerRow ctrlSetPosition [0, _squadEntryHeight, _listGroupWidth, PY(4)];
        _playerRow ctrlCommit 0;

        if (_extended) then {
            private _ctrlKitIcon = _display ctrlCreate ["RscPicture", -1, _playerRow];
            _ctrlKitIcon ctrlSetPosition [PX(0.5), PY(1), PX(2), PY(2)];
            _ctrlKitIcon ctrlSetText (([_selectedKit, [["UIIcon", "\a3\ui_f\data\IGUI\Cfg\Actions\clear_empty_ca.paa"]]] call EFUNC(Kit,getKitDetails)) select 0);
            _ctrlKitIcon ctrlCommit 0;
        };

        private _ctrlPlayerName = _display ctrlCreate ["RscTitle", -1, _playerRow];
        _ctrlPlayerName ctrlSetFontHeight PY(2.2);
        _ctrlPlayerName ctrlSetFont _font;
        _ctrlPlayerName ctrlSetTextColor [1, 1, 1, 1];
        if (_extended) then {
            _ctrlPlayerName ctrlSetPosition [PX(3.5), PY(0.5), PX(20), PY(3)];
        } else {
            _ctrlPlayerName ctrlSetPosition [PX(1), PY(0.5), PX(38), PY(3)];
        };
        _ctrlPlayerName ctrlSetText ([_x] call CFUNC(name));
        _ctrlPlayerName ctrlCommit 0;

        if (_extended) then {

            private _ctrlPlayerRole = _display ctrlCreate ["RscTitle", -1, _playerRow];
            _ctrlPlayerRole ctrlSetFontHeight PY(2.2);
            _ctrlPlayerRole ctrlSetFont _font;
            _ctrlPlayerRole ctrlSetTextColor [0.8, 0.8, 0.8, 1];
            _ctrlPlayerRole ctrlSetPosition [PX(21), PY(0.5), PX(18), PY(3)];
            _ctrlPlayerRole ctrlSetText (([_selectedKit, [["displayName", ""], ["UIIcon", ""]]] call EFUNC(Kit,getKitDetails)) select 0);
            _ctrlPlayerRole ctrlCommit 0;

            {
                private _ctrlScoreText = _display ctrlCreate ["RscTextNoShadow", -1, _playerRow];
                _ctrlScoreText ctrlSetFontHeight PY(2.2);
                _ctrlScoreText ctrlSetFont _font;
                _ctrlScoreText ctrlSetPosition [PX(6) * _forEachIndex + _listGroupWidth - PX(36), PY(0.5), PX(6), PY(3)];
                _ctrlScoreText ctrlSetText str _x;
                _ctrlScoreText ctrlCommit 0;
            } forEach _scores;
        } else {
            private _ctrlPlayerScore = _display ctrlCreate ["RscTextNoShadow", -1, _playerRow];
            _ctrlPlayerScore ctrlSetFontHeight PY(2.2);
            _ctrlPlayerScore ctrlSetFont "RobotoCondensed";
            _ctrlPlayerScore ctrlSetPosition [_listGroupWidth - PX(7), PY(0.5), PX(6), PY(3)];
            _ctrlPlayerScore ctrlSetText str (_scores select 5);
            _ctrlPlayerScore ctrlCommit 0;

            _entries pushBack _playerRow;
        };

        _squadEntryHeight = _squadEntryHeight + PY(4);
        nil
    } count ([_x] call CFUNC(groupPlayers));

    if (_extended) then {
        _ctrlSquadBackground ctrlSetPosition [0, 0, _listGroupWidth, _squadEntryHeight];
        _ctrlSquadBackground ctrlCommit 0;

        _squadEntry ctrlSetPosition [0, _verticalPosition, _listGroupWidth, _squadEntryHeight];
        _squadEntry ctrlCommit 0;
    };
    _verticalPosition = _verticalPosition + _squadEntryHeight;
    if (_extended) then {
        _verticalPosition = _verticalPosition + PY(1);
    };
    nil
} count (allGroups select {side _x == _side && groupId _x in EGVAR(Squad,squadIds) && count units _x > 0});

_listGroup setVariable [QGVAR(entries), _entries];

if (!_extended) then {
    private _ctrlEnemyPlayerBackground = _display ctrlCreate ["RscPicture", -1, _listGroup];
    _ctrlEnemyPlayerBackground ctrlSetPosition [0, 0, _listGroupWidth, _verticalPosition];
    _ctrlEnemyPlayerBackground ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.2)";
    _ctrlEnemyPlayerBackground ctrlCommit 0;
};
