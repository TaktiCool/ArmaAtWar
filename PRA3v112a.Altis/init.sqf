enableSaving[false, false];
enableSentences false;

[] execVM "scripts\zlt_fieldrepair.sqf";
execVM "R3F_LOG\init.sqf";

call compileFinal preprocessFileLineNumbers "Script_XENO_Taru_Pod\XENO_Taru_Pod_Mod.sqf";