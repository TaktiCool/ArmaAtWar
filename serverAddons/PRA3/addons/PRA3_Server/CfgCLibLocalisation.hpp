
class CfgCLibLocalisation {

    supportedLanguages[] = {"English", "German", "Spanish", "French", "Polish", "Czech", "Italian", "Hungarian", "Portuguese", "Russian"};

    // Vehicle Respawn
    class ELSTRING(VehicleRespawn,NewVehicleAvailable) {
        English = "New vehicle available: %1";
        German = "Neues Fahrzeug verfügbar: %1";
    };

    class ELSTRING(Squad,waitToSwitchSide) {
        English = "You need wait %1 seconds until you can change sides again";
        German = "Du musst %1 Sekunden warten bis du die Seite wieder wechseln kannst";
    };
    class ELSTRING(Squad,MaxPlayerCount) {
        English = "Maximum player count on the enemy side has been reached.";
        German = "Maximale Spieleranzahl auf gegnerischen Seite erreicht.";
    };

    // Sector
    class ELSTRING(Sector,YouSC) {
        English = "You have captured sector %1";
        German = "Du hast Sektor %1 eingenommen";
    };

    class ELSTRING(Sector,YourTSC) {
        English = "Your team has captured sector %1";
        German = "Dein Team hat Sektor %1 eingenommen";
    };

    class ELSTRING(Sector,YouSL) {
        English = "You have lost sector %1";
        German = "Dein Team hat Sektor %1 verloren";
    };
    class ELSTRING(Sector,YouSN) {
        English = "You have neutralized sector %1";
        German = "Du hast Sektor %1 neutralisiert";
    };
    class ELSTRING(Sector,YourTSN) {
        English = "Your has team neutralized sector %1";
        German = "Dein Team hat Sektor %1 neutralisiert";
    };

    // RespawnUI
    class ELSTRING(RespawnUI,JoinASquad) {
        English = "You have to join a squad!";
        German = "Du musst erst einem Squad beitreten!";
    };
    class ELSTRING(RespawnUI,ChooseARole) {
        English = "You have to select a role!";
        German = "Du musst erst eine Rolle auswählen!";
    };
    class ELSTRING(RespawnUI,selectSpawn) {
        English = "You have to select a spawnpoint!";
        German = "Du musst erst einen Spawn Punkt auswählen!";
    };

    // Logistic
    class ELSTRING(Logistic,Drag) {
        English = "Drag %1";
        German = "Ziehe %1";
    };
    class ELSTRING(Logistic,Drop) {
        English = "Drop";
        German = "Loslassen";
    };
    class ELSTRING(Logistic,loadItem) {
        English = "Load item into %1";
        German = "Lade Objekt in %1";
    };
    class ELSTRING(Logistic,noCargoSpace) {
        English = "No cargo space available";
        German = "Kein Ladeplatz mehr frei";
    };
    class ELSTRING(Logistic,UnloadItem) {
        English = "Unload item out of %1";
        German = "Entlade Objekt aus %1";
    };
    class ELSTRING(Logistic,itemToHeavy) {
        English = "Item is %1kg too heavy";
        German = "Das Objekt ist %1kg zu schwer";
    };

    // Deployment
    class ELSTRING(Deployment,SpawnsRemaining) {
        English = "%1 (%2 spawns remaining)";
        German = "%1 (%2 Spawns übrig)";
    };
    // - Rally
    class ELSTRING(Deployment,CreateRally) {
        English = "Create Rally Point";
        German = "Platziere Rally Punkt";
    };
    class ELSTRING(Deployment,cantPlaceRally) {
        English = "You can not place a rallypoint at this position";
        German = "Du kannst hier keinen Rally Punkt platzieren";
    };
    class ELSTRING(Deployment,RallyPlaced) {
        English = "Your Squadleader has placed a rally near %1";
        German = "Dein Squadleader hat einen Rally nahe %1 erstellt";
    };

    // - FOB
    class ELSTRING(Deployment,FOBTakeDown) {
        English = "Destroy FOB";
        German = "FOB zerstören";
    };
    class ELSTRING(Deployment,PlaceFOB) {
        English = "Place FOB";
        German = "FOB Platzieren";
    };
    class ELSTRING(Deployment,FOBPlaced) {
        English = "Squad %1 has placed a FOB near %2";
        German = "Squad %1 hat ein FOB nahe %1 platziert";
    };

    // Kit
    class ELSTRING(Kit,NotAllowToDrive) {
        English = "You're not allowed to use this vehicle";
        German = "Du darfst dieses Fahrzeug nicht benutzen";
    };

    // Revive
    class ELSTRING(Revive,IFAK) {
        English = "First Aid Kit";
        German = "Erste-Hilfe-Kasten";
    };
    class ELSTRING(Revive,Bandaging) {
        English = "Bandaging %1 ...";
        German = "Verbinde %1 ...";
    };
    class ELSTRING(Revive,Healing) {
        English = "Healing %1 ...";
        German = "Heile %1 ...";
    };
    class ELSTRING(Revive,Reviving) {
        English = "Reviving %1 ...";
        German = "Wiederbelebe %1 ...";
    };
    class ELSTRING(Revive,UnConOnScreenTextL1) {
        English = "You are unconscious and bleeding";
        German = "Du bist ohnmächtig und blutest";
    };
    class ELSTRING(Revive,UnConOnScreenTextL2) {
        English = "Wait for help or respawn ...";
        German = "Warte für Hilfe oder respawne ...";
    };
    class ELSTRING(Revive,PressToRevive) {
        English = "Press SPACE to revive the casualty";
        German = "LEER drücken um den Verwundeten wiederzubeleben";
    };
    class ELSTRING(Revive,ActionAComrade) {
        English = "to %1 your team mate";
        German = "drücken um einen Kameraden zu %1";
    };
    class ELSTRING(Revive,ActionAYourSelf) {
        English = "to %1 yourself";
        German = "drücken um sich selbst zu %1";
    };
    class ELSTRING(Revive,bandageItem) {
        English = "bandage";
        German = "bandagieren";
    };
    class ELSTRING(Revive,healItem) {
        English = "heal";
        German = "heilen";
    };
    class ELSTRING(Revive,bandagedAcion) {
        English = "bandaged";
        German = "bandagiert";
    };
    class ELSTRING(Revive,healedAction) {
        English = "healed";
        German = "geheilt";
    };
    class ELSTRING(Revive,revivedAction) {
        English = "revived";
        German = "wiederbelebt";
    };
    class ELSTRING(Revive,LocalActionText) {
        English = "You are being %1!";
        German = "Du wirst %1!";
    };
};
