#include "macros.hpp"
class CfgPatches {
    class AAW_Server {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.70;
        author = "AAW Team: NetFusion, Hoegnison, BadGuy, joko // Jonas";
        authors[] = {"joko // Jonas", "NetFusion", "Hoegnison", "BadGuy", "AAW Team"};
        authorUrl = "https://www.atwar-mod.com/";
        version = VERSION;
        versionStr = QUOTE(VERSION);
        versionAr[] = {VERSION_AR};
        requiredAddons[] = {"CLib"};
    };
};

#include "CfgCLibModules.hpp"
#include "CfgCLibLocalisation.hpp"
#include "CfgCLibSettings.hpp"

#include "\tc\AAW\addons\AAW_Server\FOB\cfgCLibSimpleObject.hpp"
#include "AAW.hpp"
