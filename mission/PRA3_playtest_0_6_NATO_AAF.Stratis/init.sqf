enableSaving [false, false];
enableEnvironment false;
enableSentences false;
// disableRemoteSensors true;
(getArray (missionConfigFile >> "PRA3" >> "loadModules")) call PRA3_Core_fnc_loadModules;
