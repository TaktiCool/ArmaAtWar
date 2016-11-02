
class CfgCLibLocalisation {

    class PRA3 {

        // Vehicle Respawn
        class VehicleRespawn {
            class NewVehicleAvailable {
                English = "New vehicle available: %1";
                German = "Neues Fahrzeug verfügbar: %1";
                Polish = "Nowy pojazd dostępny: %1";
            };
        };

        // Squad
        class Squad {
            class waitToSwitchSide {
                English = "You need wait %1 seconds until you can change sides again";
                German = "Du musst %1 Sekunden warten bis du die Seite wieder wechseln kannst";
                Polish = "Musisz poczekać %1 sekund przed ponowną zmianą strony";
            };
            class MaxPlayerCount {
                English = "Maximum player count on the enemy side has been reached.";
                German = "Maximale Spieleranzahl auf gegnerischen Seite erreicht.";
                Polish = "Drużyna przeciwna osiągneła maksymalną ilość graczy.";
            };
        };

        // Sector
        class Sector {
            class YouSC {
                English = "You have captured sector %1";
                German = "Du hast Sektor %1 eingenommen";
                Polish = "Zdobyłeś sektor %1";
                
            };

            class YourTSC {
                English = "Your team has captured sector %1";
                German = "Dein Team hat Sektor %1 eingenommen";
                Polish = "Twoja drużyna zdobyła sektor %1";
            };

            class YouSL {
                English = "You have lost sector %1";
                German = "Dein Team hat Sektor %1 verloren";
                Polish = "Utraciłeś sektor %1";
            };
            class YouSN {
                English = "You have neutralized sector %1";
                German = "Du hast Sektor %1 neutralisiert";
                Polish = "Zneutralizowałeś sektor %1";
            };
            class YourTSN {
                English = "Your has team neutralized sector %1";
                German = "Dein Team hat Sektor %1 neutralisiert";
                Polish = "Twoja drużyna zneutralizowała sektor %1";
            };
        };


        // RespawnUI
        class RespawnUI {
            class JoinASquad {
                English = "You have to join a squad!";
                German = "Du musst erst einem Squad beitreten!";
                Polish = "Musisz dołączyć do oddziału!";
            };
            class ChooseARole {
                English = "You have to select a role!";
                German = "Du musst erst eine Rolle auswählen!";
                Polish = "Musisz wybrać rolę!";
            };
            class selectSpawn {
                English = "You have to select a spawnpoint!";
                German = "Du musst erst einen Spawn Punkt auswählen!";
                Polish = "Musisz wybrać punkt respawnu!";
            };
        };


        // Logistic
        class Logistic {
            class Drag {
                English = "Drag %1";
                German = "Ziehe %1";
                Polish = "Ciągnij %1";
            };
            class Drop {
                English = "Drop";
                German = "Loslassen";
                Polish = "Upuść";
            };
            class loadItem {
                English = "Load item into %1";
                German = "Lade Objekt in %1";
                Polish = "Załaduj przedmiot %1";
            };
            class noCargoSpace {
                English = "No cargo space available";
                German = "Kein Ladeplatz mehr frei";
                Polish = "Nie ma wolnej przestrzeni ładunkowej";
            };
            class UnloadItem {
                English = "Unload item out of %1";
                German = "Entlade Objekt aus %1";
                Polish = "Wyładuj przedmiot z %1";
            };
            class itemToHeavy {
                English = "Item is %1kg too heavy";
                German = "Das Objekt ist %1kg zu schwer";
                Polish = "Przedmiot jest za ciężki o %1kg";
            };
        };

        // Deployment
        class Deployment {
            class SpawnsRemaining {
                English = "%1 (%2 spawns remaining)";
                German = "%1 (%2 Spawns übrig)";
                Polish = "%1 (pozostało %2 respawn-ów)";
            };
            // - Rally
            class CreateRally {
                English = "Create Rally Point";
                German = "Platziere Rally Punkt";
                Polish = "Stwórz punkt zbiórki";
            };
            class cantPlaceRally {
                English = "You can not place a rallypoint at this position";
                German = "Du kannst hier keinen Rally Punkt platzieren";
                Polish = "Nie możesz utworzyć punktu zbiórki w tym miejscu";
            };
            class RallyPlaced {
                English = "Your Squadleader has placed a rally near %1";
                German = "Dein Squadleader hat einen Rally nahe %1 erstellt";
                Polish = "Dowódca drużyny ustalił punkt zbiórki w pobliżu %1";
            };

            // - FOB
            class FOBTakeDown {
                English = "Destroy FOB";
                German = "FOB zerstören";
                Polish = "Zniszcz FOB";
            };
            class PlaceFOB {
                English = "Place FOB";
                German = "FOB Platzieren";
                Polish = "Stwórz FOB";
            };
            class FOBPlaced {
                English = "Squad %1 has placed a FOB near %2";
                German = "Squad %1 hat ein FOB nahe %1 platziert";
                Polish = "Drużyna %1 utworzyła FOB w pobliżu %2";
            };

        };

        // Kit
        class Kit {
            class NotAllowToDrive {
                English = "You're not allowed to use this vehicle";
                German = "Du darfst dieses Fahrzeug nicht benutzen";
                Polish = "Nie możesz używać tego pojazdu";
            };
        };
    };
};
