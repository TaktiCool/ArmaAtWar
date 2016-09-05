enableSaving [false, false];
enableEnvironment false;
enableSentences false;
waitUntil {!isNil "PRA3_Core_fnc_loadModules"}; // we Send More Data since update 0.9 that we maybe better build in a wait check that we realy dont call a Nil Function
// disableRemoteSensors true;
(getArray (missionConfigFile >> "PRA3" >> "loadModules")) call PRA3_Core_fnc_loadModules;
