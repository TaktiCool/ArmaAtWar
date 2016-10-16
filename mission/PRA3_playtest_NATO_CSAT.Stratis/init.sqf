enableSaving [false, false];
enableEnvironment false;
enableSentences false;
waitUntil {!isNil "CLib_fnc_loadModules"};
call CLib_fnc_loadModules;
