
PREP(init)

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
EPREP(Respawn,serverInitRespawn)
EPREP(Respawn,respawn)

// Squad system
EPREP(Squad,clientInitSquad)
EPREP(Squad,getNextSquadId)
EPREP(Squad,canUseSquadType)
EPREP(Squad,switchSide)
EPREP(Squad,createSquad)
EPREP(Squad,joinSquad)
EPREP(Squad,leaveSquad)
EPREP(Squad,kickMember)
EPREP(Squad,promoteMember)

// VehicleRespawn
EPREP(VehicleRespawn,serverInitVehicleRespawn)
EPREP(VehicleRespawn,clientInitVehicleRespawn)
EPREP(VehicleRespawn,performVehicleRespawn)
