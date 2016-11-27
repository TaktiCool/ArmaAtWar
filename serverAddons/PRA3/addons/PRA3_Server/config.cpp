#include "macros.hpp"
class CfgPatches {
    class PRA3_Server {
        units[] = {};
        weapons[] = {};
        requiredVersion = 1.56;
        author = "PRA3 Team: NetFusion, Hoeginson, BadGuy, joko // Jonas";
        authors[] = {"joko // Jonas", "NetFusion", "Hoeginson", "BadGuy", "PRA3 Team"};
        authorUrl = "";
        version = VERSION;
        versionStr = QUOTE(VERSION);
        versionAr[] = {VERSION_AR};
        requiredAddons[] = {"Clib"};
    };
};

#include "CfgCLibModules.hpp"

#include "CfgCLibLocalisation.hpp"

class RscPicture;
class RscTextNoShadow;
class RscTitle;
class RscStructuredText;
class CfgUIFramework {
    #include "\pr\PRA3\addons\PRA3_Server\RespawnUI\CfgUIFramework.hpp"
};

#include "\pr\PRA3\addons\PRA3_Server\FOB\cfgClibSimpleObject.hpp"
#include "PRA3.hpp"
