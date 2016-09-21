#define DFNC(f) class f
#define FNC(f) DFNC(f)
#define APIFNC(f) DFNC(f) {api = 1;}
#define MODULE(m) class m

class CLibBaseFunction;
class CLibBaseModule;


class CfgCLibModules {
    class PRA3 {
        dependency[] = {"CLib"};
        path = "\pr\PRA3\addons\PRA3_Server"; // TODO add Simplifyed Macro for this

        // Common
        MODULE(Common) {
            // Init
            FNC(init);

            // Misc
            FNC(getNearestLocationName);
            FNC(isAlive);

            //Entity Variables
            MODULE(EntityVariables) {
                FNC(initEntityVariables);
            };

            // Respawn
            MODULE(Respawn){
                FNC(respawn);
                FNC(respawnNewSide);
            };

            // Notification
            MODULE(Notification) {
                FNC(clientInitNotification);
                FNC(displayNotification);
                FNC(handleNotificationQueue);
            };

            // Performance Info
            MODULE(PerformanceInfo) {
                FNC(clientInitPerformance);
                FNC(serverInitPerformance);
            };
        };

        // CompassUI
        MODULE(CompassUI) {
            FNC(clientInit);
            FNC(removeLineMarker);
            FNC(addLineMarker);
        };

        MODULE(Deployment) {
            FNC(serverInit);
            FNC(clientInit);
            FNC(addPoint);
            FNC(removePoint);
            FNC(getAvailablePoints);
            FNC(prepareSpawn);

            // Rally System
            MODULE(Rally) {
                FNC(serverInitRally);
                FNC(clientInitRally);
                FNC(placeRally);
                FNC(destroyRally);
                FNC(canPlaceRally);
            };

            // FOB system
            MODULE(FOB) {
                FNC(clientInitFOB);
                FNC(placeFOB);
                FNC(destroyFOB);
                FNC(canPlaceFOB);
            };
        };

        // GarbageCollector
        MODULE(GarbageCollector) {
            FNC(serverInit);
        };

        // Kit
        MODULE(Kit) {
            FNC(clientInit);
            FNC(getAllKits);
            FNC(getKitDetails);
            FNC(getUsableKitCount);
            FNC(applyKit);
            FNC(checkVehicleRestrictions);
        };

        // Logistic
        MODULE(Logistic) {
            FNC(serverInit);
            FNC(clientInit);
            FNC(clientInitActions);
            FNC(clientInitCargoInventory);
            FNC(getWeight);
            FNC(dragObject);
            FNC(dropObject);
            FNC(spawnCrate);
        };

        // Mission
        MODULE(Mission) {
            FNC(init);
        };

        // Nametags
        MODULE(Nametags) {
            FNC(clientInit);
        };

        // RespawnUI
        MODULE(RespawnUI) {
            FNC(clientInit);
            FNC(clientInitDeployment);
            FNC(clientInitRole);
            FNC(clientInitSquad);
            FNC(clientInitCamera);
            FNC(showDisplayInterruptEH);
            FNC(updateListNBox);
            FNC(fadeControl);
        };

        // Revive
        MODULE(Revive) {
            // General
            FNC(clientInit);
            FNC(bloodEffect);

            // HitEffects
            MODULE(HitEffects) {
                FNC(clientInitHitEffectsUI);
                FNC(blood);
                FNC(fatigue);
                FNC(unconscious);
            };

            // Treatments
            MODULE(Treatments) {
                FNC(clientInitTreatments);
                FNC(clientInitTreatmentsUI);
                FNC(bandage);
                FNC(heal);
                FNC(revive);
            };

            // Handle Damage
            MODULE(HandleDamage) {
                FNC(clientInitHandleDamage);
                FNC(handleDamage);
                FNC(handleDamageCached);
                FNC(translateSelection);
            };
        };

        // Sector
        MODULE(Sector) {
            FNC(init);
            FNC(clientInit);
            FNC(serverInit);
            FNC(createSectorLogic);
            FNC(drawSector);
            FNC(getSector);
            FNC(isCaptureable);
            FNC(sectorUpdatePFH);
            FNC(showCaptureStatus);
            FNC(updateDependencies);
        };

        // Squad
        MODULE(Squad) {
            FNC(clientInit);
            FNC(getNextSquadId);
            FNC(canUseSquadType);
            FNC(switchSide);
            FNC(createSquad);
            FNC(joinSquad);
            FNC(leaveSquad);
            FNC(kickMember);
            FNC(promoteMember);
            FNC(canSwitchSide);
        };

        // Tickets
        MODULE(Tickets) {
            FNC(Init);
        };

        // UnitTracker
        MODULE(UnitTracker) {
            FNC(clientInit);
            FNC(addUnitToTracker);
            FNC(addGroupToTracker);
        };

        // VehicleRespawn
        MODULE(VehicleRespawn) {
            FNC(serverInit);
            FNC(clientInit);
            FNC(performVehicleRespawn);
        };
    };
};
