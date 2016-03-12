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

// Rally System
EPREP(Rally,clientInitRally)
EPREP(Rally,isRallyPlaceable)

// TicketBleed
EPREP(TicketBleed,postInitTicketBleed)

// Respawn
EPREP(Respawn,clientInitRespawn)
EPREP(Respawn,initRespawn)
EPREP(Respawn,changeSide)
EPREP(Respawn,createSquad)
EPREP(Respawn,joinLeave)
EPREP(Respawn,kick)
EPREP(Respawn,promote)

// Kit
EPREP(Kit,postInitKit)
EPREP(Kit,addContainer)
EPREP(Kit,applyKit)
EPREP(Kit,loadConfigKit)
EPREP(Kit,getAllKits)

// VehicleRespawn
EPREP(VehicleRespawn,serverInitVehicleRespawn)
EPREP(VehicleRespawn,clientInitVehicleRespawn)
EPREP(VehicleRespawn,performVehicleRespawn)
