#include "macros.hpp"
class CfgPatches {
    class AAW_Server {
        name = "Arma At War";
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.70;
        author = "AAW Team";
        authors[] = {"joko // Jonas", "NetFusion", "Hoegnison", "BadGuy"};
        authorUrl = "https://www.atwar-mod.com/";
        url = "https://www.atwar-mod.com/";
        version = VERSION;
        versionStr = VERSION;
        versionAr[] = {VERSION_AR};
        requiredAddons[] = {"CLib"};
    };
};

#include "CfgCLibModules.hpp"
#include "CfgCLibLocalisation.hpp"
#include "CfgCLibSettings.hpp"

class cfgCLibSimpleObject {
    #include "\tc\AAW\addons\AAW_Server\FOB\cfgCLibSimpleObject.hpp"
    #include "\tc\AAW\addons\AAW_Server\Rally\cfgCLibSimpleObject.hpp"
};
#include "AAW.hpp"
class CfgCLibLoadoutsClassBase;
class CfgCLibLoadouts {
    #include "\tc\AAW\addons\AAW_Server\Kit\cfgLoadouts.hpp"
};
