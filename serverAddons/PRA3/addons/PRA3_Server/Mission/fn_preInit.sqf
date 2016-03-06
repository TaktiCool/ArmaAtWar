#include "macros.hpp"

PREP(init)



// Sector
EPREP(Sector,createSectorLogic)
EPREP(Sector,createSectorTrigger)
EPREP(Sector,getSector)
EPREP(Sector,initSector)
EPREP(Sector,isCaptureable)
EPREP(Sector,loop)
EPREP(Sector,showCaptureStatus)
//EPREP(Sector,renderIcons)



// Groups
EPREP(Groups,postInitGroups)

// Respawn
EPREP(Respawn,clientInitRespawn)
EPREP(Respawn,onLoadRespawnScreen)
EPREP(Respawn,onUnLoadRespawnScreen)
EPREP(Respawn,changeSide)
EPREP(Respawn,createSquad)
EPREP(Respawn,joinLeave)
EPREP(Respawn,kick)
EPREP(Respawn,promote)

// Loadouts
EPREP(Loadouts,postInitLoadout)
EPREP(Loadouts,addContainer)
EPREP(Loadouts,applyLoadout)
EPREP(Loadouts,Loadout_loadConfig)
EPREP(Loadouts,getAllLoadouts)
