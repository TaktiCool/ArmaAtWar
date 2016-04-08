// Autoload
EPREP(Autoload,autoloadEntryPoint)
EPREP(Autoload,callModules)
EPREP(Autoload,loadModules)
EPREP(Autoload,loadModulesServer)

// Per Frame Eventhandler
EPREP(PreFrame,addPerFrameHandler)
EPREP(PreFrame,removePerFrameHandler)
EPREP(PreFrame,initPerFrameHandler)
EPREP(PreFrame,execNextFrame)
EPREP(PreFrame,wait)
EPREP(PreFrame,waitUntil)

// Namespaces
EPREP(Namespaces,createNamespace)
EPREP(Namespaces,deleteNamespace)
EPREP(Namespaces,getVariableLoc)
EPREP(Namespaces,getLogicGroup)

// Events
EPREP(Events,initEvents)
EPREP(Events,addEventhandler)
EPREP(Events,removeEventhandler)

// Trigger Events
EPREP(Events,localEvent)
EPREP(Events,targetEvent)
EPREP(Events,globalEvent)
EPREP(Events,serverEvent)

// Base Eventhandler
EPREP(Events,clientInitEvents)
EPREP(Events,serverInitEvents)
EPREP(Events,hcInitEvents)

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
EPREP(Notification,displayNotification)
EPREP(Notification,handleNotificationQueue)

// Settings
EPREP(Settings,initSettings)
EPREP(Settings,loadSettings)
EPREP(Settings,getSetting)

// lnbData
EPREP(lnbData,initlnbData)
EPREP(lnbData,lnbLoad)
EPREP(lnbData,lnbSave)

// respawn
EPREP(Respawn,serverInitRespawn)
EPREP(Respawn,respawn)

// Gear
EPREP(Gear,addContainer)
EPREP(Gear,copyGear)
EPREP(Gear,saveGear)
EPREP(Gear,restoreGear)
EPREP(Gear,addItem)
EPREP(Gear,addMagazine)
EPREP(Gear,addWeapon)
EPREP(Gear,getAllGear)

// Init
PREP(init)

// Other Functions
PREP(addPerformanceCounter)
PREP(blurScreen)
PREP(cachedCall)
PREP(codeToString)
PREP(createPPEffect)
PREP(disableUserInput)
PREP(directCall)
PREP(findSavePosition)
PREP(fixFloating)
PREP(getNearestLocationName)
PREP(getFOV)
PREP(isAlive)
PREP(name)
PREP(setVariablePublic)
