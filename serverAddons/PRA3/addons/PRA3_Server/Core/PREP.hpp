// Autoload
EPREP(Autoload,autoloadEntryPoint)
EPREP(Autoload,callModules)
EPREP(Autoload,loadModules)
EPREP(Autoload,loadModulesServer)

// Config Caching
EPREP(ConfigCaching,returnParents)
EPREP(ConfigCaching,initConfigCaching)

//Entity Variables
EPREP(EntityVariables,initEntityVariables)

// Events
EPREP(Events,initEvents)
EPREP(Events,addEventHandler)
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

// Gear
EPREP(Gear,addContainer)
EPREP(Gear,copyGear)
EPREP(Gear,saveGear)
EPREP(Gear,restoreGear)
EPREP(Gear,addItem)
EPREP(Gear,addMagazine)
EPREP(Gear,addWeapon)
EPREP(Gear,getAllGear)

// Interaction
EPREP(Interaction,addAction)
EPREP(Interaction,clientInitInteraction)
EPREP(Interaction,loop)
EPREP(Interaction,inRange)

// lnbData
EPREP(lnbData,initlnbData)
EPREP(lnbData,lnbLoad)
EPREP(lnbData,lnbSave)

// Map Icon Render
EPREP(MapIcons,clientInitMapIcons)
EPREP(MapIcons,addMapIcon)
EPREP(MapIcons,removeMapIcon)
EPREP(MapIcons,registerMapControl)
EPREP(MapIcons,unregisterMapControl)
EPREP(MapIcons,drawMapIcons)
EPREP(MapIcons,mouseClickEH)
EPREP(MapIcons,mouseMovingEH)
EPREP(MapIcons,getIconAtPos)

// Map Icon Render Events
EPREP(MapIcons,addMapIconEventHandler)
EPREP(MapIcons,removeMapIconEventHandler)
EPREP(MapIcons,triggerMapIconEvent)

// Mutex
EPREP(Mutex,initClientMutex)
EPREP(Mutex,initServerMutex)
EPREP(Mutex,mutex)

// Namespaces
EPREP(Namespaces,createNamespace)
EPREP(Namespaces,deleteNamespace)
EPREP(Namespaces,getVariableLoc)
EPREP(Namespaces,getLogicGroup)

// Notification System
EPREP(Notification,clientInitNotification)
EPREP(Notification,displayNotification)
EPREP(Notification,handleNotificationQueue)

// Per Frame Eventhandler
EPREP(PerFrame,addPerFrameHandler)
EPREP(PerFrame,removePerFrameHandler)
EPREP(PerFrame,initPerFrameHandler)
EPREP(PerFrame,execNextFrame)
EPREP(PerFrame,wait)
EPREP(PerFrame,waitUntil)

// respawn
EPREP(Respawn,serverInitRespawn)
EPREP(Respawn,respawn)

// Settings
EPREP(Settings,initSettings)
EPREP(Settings,loadSettings)
EPREP(Settings,getSetting)

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
PREP(fixPosition)
PREP(getNearestLocationName)
PREP(getFOV)
PREP(isAlive)
PREP(name)
PREP(sanitizeString)
PREP(setVariablePublic)

#ifdef isDev
    PREP(serverInit)
#endif
