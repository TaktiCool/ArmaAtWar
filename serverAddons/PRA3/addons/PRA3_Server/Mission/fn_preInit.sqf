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
EPREP(Deployment,serverInitDeployment)
EPREP(Deployment,clientInitDeployment)
EPREP(Deployment,addDeploymentPoint)
EPREP(Deployment,removeDeploymentPoint)
EPREP(Deployment,canPlaceRally)
EPREP(Deployment,placeRally)
EPREP(Deployment,destroyRally)

// TicketBleed
EPREP(Tickets,postInitTickets)

// Respawn
EPREP(Respawn,clientInitRespawn)
EPREP(Respawn,respawn)

// Squad system
EPREP(Squad,clientInitSquad)
EPREP(Squad,getNextSquadId)
EPREP(Squad,canUseSquadType)
EPREP(Squad,changeSide)
EPREP(Squad,createSquad)
EPREP(Squad,joinSquad)
EPREP(Squad,leaveSquad)
EPREP(Squad,kickMember)
EPREP(Squad,promoteMember)

// Kit
EPREP(Kit,clientInitKit)
EPREP(Kit,getAllKits)
EPREP(Kit,getKitDetails)
EPREP(Kit,getUsableKitCount)
EPREP(Kit,applyKit)
EPREP(Kit,addContainer)
EPREP(Kit,addWeapon)
EPREP(Kit,addMagazine)
EPREP(Kit,addItem)
EPREP(Kit,checkVehicleRestrictions)

// VehicleRespawn
EPREP(VehicleRespawn,serverInitVehicleRespawn)
EPREP(VehicleRespawn,clientInitVehicleRespawn)
EPREP(VehicleRespawn,performVehicleRespawn)
