#include "macros.hpp"

#ifndef isDev
    private _extRet = "PRA3_server" callExtension "version";
    GVAR(serverExtensionExist) = _extRet != "" && {getText(configFile >> "PRA3_Extension" >> "version") == _extRet};
#endif

// Version Informations
private _missionVersionStr = "";
private _missionVersionAr = getArray(missionConfigFile >> "PRA3" >> "Version");

private _serverVersionStr = "";
private _serverVersionAr = getArray(configFile >> "CfgPatches" >> "PRA3_server" >> "versionAr");

{
    _missionVersionStr = _missionVersionStr + str(_x) + ".";
    nil
} count _missionVersionAr;

{
    _serverVersionStr = _serverVersionStr + str(_x) + ".";
    nil
} count _serverVersionAr;
_missionVersionStr = _missionVersionStr select [0, (count _missionVersionStr - 2)];
_serverVersionStr = _serverVersionStr select [0, (count _serverVersionStr - 2)];
GVAR(VersionInfo) = [[_missionVersionStr,_missionVersionAr], [_serverVersionStr, _serverVersionAr]];
publicVariable QGVAR(VersionInfo);

// The autoloader uses this array to get all function names.
GVAR(functionCache) = [];

// Autoload
EPREP(Autoload,autoloadEntryPoint)
EPREP(Autoload,callModules)
EPREP(Autoload,loadModules)
EPREP(Autoload,loadModulesServer)

// Per Frame Eventhandler
PREP(addPerFrameHandler)
PREP(removePerFrameHandler)
PREP(initPerFrameHandler)
PREP(execNextFrame)
PREP(wait)
PREP(waitUntil)

// Namespaces
PREP(createNamespace)
PREP(deleteNamespace)
PREP(getVariableLoc)

// Events
EPREP(Events,initEvents)
EPREP(Events,addEventhandler)

// Trigger Events
EPREP(Events,localEvent)
EPREP(Events,targetEvent)
EPREP(Events,globalEvent)
EPREP(Events,serverEvent)

// Base Eventhandler
EPREP(Events,clientInitEvents)
EPREP(Events,serverInit)
EPREP(Events,hcInit)

// Interaction
EPREP(Interaction,addAction)
EPREP(Interaction,clientInitInteraction)
EPREP(Interaction,loop)
EPREP(Interaction,inRange)

// Mutex
EPREP(Mutex,initClientMutex)
EPREP(Mutex,initServerMutex)
EPREP(Mutex,mutex)

// Notification System
EPREP(Notification,clientInitNotification)

// Settings
EPREP(Settings,initSettings)
EPREP(Settings,loadSettings)
EPREP(Settings,getSetting)

// lnbData
EPREP(lnbData,initlnbData)
EPREP(lnbData,lnbLoad)
EPREP(lnbData,lnbSave)

// Init
PREP(init)

// Other Functions
PREP(getLogicGroup)
PREP(isAlive)
PREP(cachedCall)
PREP(addPerformanceCounter)
PREP(blurScreen)
PREP(fixFloating)
PREP(name)
PREP(codeToString)
PREP(disalbeUserInput)
PREP(setVariablePublic)
PREP(createPPEffect)
PREP(getAllGear)

// We call the autoloader here. This starts the mod work.
call FUNC(autoloadEntryPoint);
