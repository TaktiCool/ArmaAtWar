#define DFNC(f) class f
#define FNC(f) DFNC(f)
#define APIFNC(f) DFNC(f) {api = 1;}
#define MODULE(m) class m

class CfgCLibModules {
    class PRA3 {
        path = "\pr\PRA3\addons\PRA3_Server"; // TODO add Simplifyed Macro for this
        dependency[] = {"CLib"};
        // Common
        MODULE(Common) {
            // dependency[] = {"CLib/Core", "CLib/PerFrame", "CLib/Events", "CLib/Localisation", "CLib/ConfigCaching", "CLib/3dGraphics", "CLib/extensionFramework", "CLib/Gear", "CLib/Interaction", "CLib/lnbData", "CLib/MapGraphics", "CLib/Mutex", "CLib/Namespaces", "CLib/RemoteExecution", "CLib/Statemachine", "CLib/StatusEffects", "CLib/Settings"};
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
            MODULE(Respawn) {
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
            dependency[] = {"PRA3/Common"};

            FNC(clientInit);
            FNC(removeLineMarker);
            FNC(addLineMarker);
        };

        MODULE(Deployment) {
            dependency[] = {"PRA3/Common"};
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
            dependency[] = {"PRA3/Common"};
            FNC(serverInit);
        };

        // Kit
        MODULE(Kit) {
            dependency[] = {"PRA3/Common"};
            FNC(clientInit);
            FNC(getAllKits);
            FNC(getKitDetails);
            FNC(getUsableKitCount);
            FNC(applyKit);
            FNC(checkVehicleRestrictions);
        };

        // Logistic
        MODULE(Logistic) {
            dependency[] = {"PRA3/Common"};
            FNC(serverInit);
            FNC(clientInit);
            FNC(clientInitActions);
            FNC(clientInitCargoInventory);
            FNC(getWeight);
            FNC(dragObject);
            FNC(dropObject);
            FNC(spawnCrate);
        };

        // Nametags
        MODULE(Nametags) {
            dependency[] = {"PRA3/Common"};
            FNC(clientInit);
        };

        // RespawnUI
        MODULE(RespawnUI) {
            dependency[] = {"PRA3/Common", "PRA3/Deployment", "PRA3/Kit", "PRA3/Squad", "PRA3/Sector"};
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
            dependency[] = {"PRA3/Common"};
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
            dependency[] = {"PRA3/Common"};
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
            dependency[] = {"PRA3/Common"};
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
            dependency[] = {"PRA3/Common", "PRA3/Sector"};
            FNC(init);
        };

        // UnitTracker
        MODULE(UnitTracker) {
            dependency[] = {"PRA3/Common"};
            FNC(clientInit);
            FNC(addUnitToTracker);
            FNC(addGroupToTracker);
        };

        // VehicleRespawn
        MODULE(VehicleRespawn) {
            dependency[] = {"PRA3/Common"};
            FNC(serverInit);
            FNC(clientInit);
            FNC(performVehicleRespawn);
        };
    };
};
