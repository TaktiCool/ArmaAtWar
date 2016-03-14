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
EPREP(Rally,serverInitRally)
EPREP(Rally,clientInitRally)
EPREP(Rally,canPlaceRally)

// TicketBleed
EPREP(Tickets,postInitTickets)

// Respawn
EPREP(Respawn,clientInitRespawn)
EPREP(Respawn,changeSide)
EPREP(Respawn,createSquad)
EPREP(Respawn,joinLeave)
EPREP(Respawn,kick)
EPREP(Respawn,promote)

// Kit
EPREP(Kit,clientInitKit)
EPREP(Kit,getAllKits)
EPREP(Kit,getKitDetails)
EPREP(Kit,canUseKit)
EPREP(Kit,addContainer)
EPREP(Kit,applyKit)
EPREP(Kit,loadConfigKit)

// VehicleRespawn
EPREP(VehicleRespawn,serverInitVehicleRespawn)
EPREP(VehicleRespawn,clientInitVehicleRespawn)
EPREP(VehicleRespawn,performVehicleRespawn)
