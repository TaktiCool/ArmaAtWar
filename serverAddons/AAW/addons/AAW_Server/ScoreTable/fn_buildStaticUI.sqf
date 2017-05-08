#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:


    Parameter(s):


    Returns:

*/
params ["_display"];

private _headerBg = _display ctrlCreate ["RscPicture", -1];
_headerBg ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, PY(15.5)];
_headerBg ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.2)";
_headerBg ctrlCommit 0;

/*
private _vsep = _display ctrlCreate ["RscPicture", -1];
_vsep ctrlSetPosition [0, PY(15), safeZoneW, PY(0.5)];
_vsep ctrlSetText "#(argb,8,8,3)color(1,1,1,1)";
_vsep ctrlCommit 0;
*/

private _globalGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_globalGroup ctrlSetPosition [0.5-PX(60), safeZoneY, safeZoneW, safeZoneH];
_globalGroup ctrlCommit 0;


private _title = _display ctrlCreate ["RscTitle", -1, _globalGroup];
_title ctrlSetFontHeight PY(3.2);
_title ctrlSetFont "RobotoCondensedBold";
_title ctrlSetPosition [0, PY(10.5), PX(20), PY(4)];
_title ctrlSetText "SCOREBOARD";
_title ctrlCommit 0;

private _friendlyHeaderBg = _display ctrlCreate ["RscPicture", -1, _globalGroup];
_friendlyHeaderBg ctrlSetPosition [0, PY(17), PX(79), PY(7)];
_friendlyHeaderBg ctrlSetText "#(argb,8,8,3)color(0.0,0.4,0.8,1)";
_friendlyHeaderBg ctrlCommit 0;


private _friendlyFlag = _display ctrlCreate ["RscPictureKeepAspect", -1, _globalGroup];
_friendlyFlag ctrlSetPosition [PX(0.5), PY(17.5), PX(6), PY(6)];
_friendlyFlag ctrlSetText "";
_friendlyFlag ctrlCommit 0;
uiNamespace setVariable [QGVAR(ctrlFriendlyFlag), _friendlyFlag];

private _friendlySideName = _display ctrlCreate ["RscTitle", -1, _globalGroup];
_friendlySideName ctrlSetFontHeight PY(3.3);
_friendlySideName ctrlSetFont "RobotoCondensedBold";
_friendlySideName ctrlSetPosition [PX(7), PY(17), PX(30), PY(4)];
_friendlySideName ctrlSetText "FriendlySideName";
_friendlySideName ctrlCommit 0;
uiNamespace setVariable [QGVAR(ctrlFriendlySideName), _friendlySideName];

private _friendlyTicketCount = _display ctrlCreate ["RscTextNoShadow", -1, _globalGroup];
_friendlyTicketCount ctrlSetFontHeight PY(3.3);
_friendlyTicketCount ctrlSetFont "RobotoCondensedBold";
_friendlyTicketCount ctrlSetPosition [PX(72), PY(17), PX(6), PY(4)];
_friendlyTicketCount ctrlSetText "TICKETS";
_friendlyTicketCount ctrlCommit 0;
uiNamespace setVariable [QGVAR(ctrlFriendlyTicketCount), _friendlyTicketCount];

private _friendlyPlayerCount = _display ctrlCreate ["RscTitle", -1, _globalGroup];
_friendlyPlayerCount ctrlSetFontHeight PY(2.2);
_friendlyPlayerCount ctrlSetFont "RobotoCondensed";
_friendlyPlayerCount ctrlSetPosition [PX(7), PY(20), PX(30), PY(4)];
_friendlyPlayerCount ctrlSetText "XX PLAYERS";
_friendlyPlayerCount ctrlCommit 0;
uiNamespace setVariable [QGVAR(ctrlFriendlyPlayerCount), _friendlyPlayerCount];

private _friendlyKillHeader = _display ctrlCreate ["RscTextNoShadow", -1, _globalGroup];
_friendlyKillHeader ctrlSetFontHeight PY(2.2);
_friendlyKillHeader ctrlSetFont "RobotoCondensedBold";
_friendlyKillHeader ctrlSetPosition [PX(49), PY(20), PX(6), PY(4)];
_friendlyKillHeader ctrlSetText "KILLS";
_friendlyKillHeader ctrlCommit 0;

private _friendlyDeathHeader = _display ctrlCreate ["RscTextNoShadow", -1, _globalGroup];
_friendlyDeathHeader ctrlSetFontHeight PY(2.2);
_friendlyDeathHeader ctrlSetFont "RobotoCondensedBold";
_friendlyDeathHeader ctrlSetPosition [PX(55), PY(20), PX(6), PY(4)];
_friendlyDeathHeader ctrlSetText "DEATHS";
_friendlyDeathHeader ctrlCommit 0;

private _friendlyMedicalHeader = _display ctrlCreate ["RscPictureKeepAspect", -1, _globalGroup];
_friendlyMedicalHeader ctrlSetFontHeight PY(2.2);
_friendlyMedicalHeader ctrlSetFont "RobotoCondensedBold";
_friendlyMedicalHeader ctrlSetPosition [PX(61), PY(21), PX(6), PY(2)];
_friendlyMedicalHeader ctrlSetText "\A3\ui_f\data\igui\cfg\simpletasks\types\heal_ca.paa";
_friendlyMedicalHeader ctrlCommit 0;

private _friendlyCapturedHeader = _display ctrlCreate ["RscPictureKeepAspect", -1, _globalGroup];
_friendlyCapturedHeader ctrlSetFontHeight PY(2.2);
_friendlyCapturedHeader ctrlSetFont "RobotoCondensedBold";
_friendlyCapturedHeader ctrlSetPosition [PX(67), PY(21), PX(6), PY(2)];
_friendlyCapturedHeader ctrlSetText "\A3\ui_f\data\igui\cfg\simpletasks\types\attack_ca.paa";
_friendlyCapturedHeader ctrlCommit 0;

private _friendlyScoreHeader = _display ctrlCreate ["RscTextNoShadow", -1, _globalGroup];
_friendlyScoreHeader ctrlSetFontHeight PY(2.2);
_friendlyScoreHeader ctrlSetFont "RobotoCondensedBold";
_friendlyScoreHeader ctrlSetPosition [PX(73), PY(20), PX(6), PY(4)];
_friendlyScoreHeader ctrlSetText "SCORE";
_friendlyScoreHeader ctrlCommit 0;

private _friendlyPlayerListGroup = _display ctrlCreate ["RscControlsGroupNoHScrollbars", -1, _globalGroup];
_friendlyPlayerListGroup ctrlSetPosition [0, PY(25), PX(80), PY(70)];
_friendlyPlayerListGroup ctrlCommit 0;
uiNamespace setVariable [QGVAR(ctrlFriendlyPlayerListGroup), _friendlyPlayerListGroup];

private _enemyHeaderBg = _display ctrlCreate ["RscPicture", -1, _globalGroup];
_enemyHeaderBg ctrlSetPosition [PX(81), PY(17), PX(39), PY(7)];
_enemyHeaderBg ctrlSetText "#(argb,8,8,3)color(0.6,0,0,1)";
_enemyHeaderBg ctrlCommit 0;

private _enemyFlag = _display ctrlCreate ["RscPictureKeepAspect", -1, _globalGroup];
_enemyFlag ctrlSetPosition [PX(81.5), PY(17.5), PX(6), PY(6)];
_enemyFlag ctrlSetText "";
_enemyFlag ctrlCommit 0;
uiNamespace setVariable [QGVAR(ctrlEnemyFlag), _enemyFlag];

private _enemySideName = _display ctrlCreate ["RscTitle", -1, _globalGroup];
_enemySideName ctrlSetFontHeight PY(3.3);
_enemySideName ctrlSetFont "RobotoCondensedBold";
_enemySideName ctrlSetPosition [PX(88), PY(17), PX(30), PY(4)];
_enemySideName ctrlSetText "EnemySide";
_enemySideName ctrlCommit 0;
uiNamespace setVariable [QGVAR(ctrlEnemySideName), _enemySideName];

private _enemyPlayerCount = _display ctrlCreate ["RscTitle", -1, _globalGroup];
_enemyPlayerCount ctrlSetFontHeight PY(2.2);
_enemyPlayerCount ctrlSetFont "RobotoCondensed";
_enemyPlayerCount ctrlSetPosition [PX(88), PY(20), PX(30), PY(4)];
_enemyPlayerCount ctrlSetText "XX PLAYERS";
_enemyPlayerCount ctrlCommit 0;
uiNamespace setVariable [QGVAR(ctrlEnemyPlayerCount), _enemyPlayerCount];

private _enemyPlayerListGroup = _display ctrlCreate ["RscControlsGroupNoHScrollbars", -1, _globalGroup];
_enemyPlayerListGroup ctrlSetPosition [PX(81), PY(25), PX(40), PY(70)];
_enemyPlayerListGroup ctrlCommit 0;
uiNamespace setVariable [QGVAR(ctrlEnemyPlayerListGroup), _enemyPlayerListGroup];
