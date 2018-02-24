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
        versionStr = QUOTE(VERSION);
        versionAr[] = {VERSION_AR};
        requiredAddons[] = {"CLib"};
    };
};

#include "CfgFunctions.hpp"
#include "CfgCLibModules.hpp"
#include "CfgCLibLocalisation.hpp"
#include "CfgCLibSettings.hpp"

#include "\tc\AAW\addons\AAW_Server\FOB\cfgCLibSimpleObject.hpp"
#include "AAW.hpp"
