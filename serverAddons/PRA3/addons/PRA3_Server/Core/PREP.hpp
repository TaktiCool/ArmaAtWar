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
PREP(disableUserInput)
PREP(setVariablePublic)
PREP(createPPEffect)
PREP(getAllGear)
PREP(getNearestLocationName)
PREP(findSavePosition)
PREP(directCall)
PREP(getFOV)
PREP(addContainer)
PREP(copyGear)
