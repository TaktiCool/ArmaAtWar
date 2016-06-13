#include "controls\TeamInfo.hpp"
#include "controls\SquadManagement.hpp"
#include "controls\RoleManagement.hpp"
#include "controls\DeploymentManagement.hpp"

class PRA3_UI_RespawnScreen {
    idd = 1000;
    enableSimulation = 1;
    onLoad = "'PRA3_UI_RespawnScreen_onLoad' call PRA3_Core_fnc_localEvent;";
    onUnload = "'PRA3_UI_RespawnScreen_onUnload' call PRA3_Core_fnc_localEvent;";

    class controlsBackground {

        class BackgroundLeft : RscPicture {
            idc = 601;
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            x = safeZoneX;
            y = safeZoneY;
            w = PX(40);
            h = safeZoneH;
            fade = 1;
        };

        class BackgroundRight : RscPicture {
            idc = 602;
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            x = safeZoneX+safeZoneW - PX(40);
            y = safeZoneY;
            w = PX(40);
            h = safeZoneH;
            fade = 1;
        };

        class BackgroundHeader : RscPicture {
            idc = 603;
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            x = safeZoneX;
            y = safeZoneY;
            w = PX(40);
            h = PY(6);
            fade = 1;
        };

        class Map : RscMapControl {
            idc = 700;
            x = PX(40) + safeZoneX;
            y = PY(10.5) + safeZoneY;
            w = safeZoneW - PX(80);
            h = safeZoneH-PY(10.5);
        };
    };

    class Controls {

        class TeamInfo : PRA3_UI_TeamInfo {
            y = PY(6) + safeZoneY;
        };
        class SquadManagement : PRA3_UI_SquadManagement {
            y = PY(10.5) + safeZoneY;
        };

        class RoleManagement : PRA3_UI_RoleManagement {
            y = PY(10.5) + safeZoneY;
        };
        class DeploymentManagement : PRA3_UI_DeploymentManagement {
            y = PY(70.5) + safeZoneY;
        };
        /*
        #undef GHEIGHT
        #undef GWIDTH
        #define GWIDTH 25
        #define GHEIGHT 26.5
        class DeploymentManagement : RscControlsGroupNoScollbars {
            idc = 400;
            x = PX(46) + safeZoneX;
            y = PY(10) + safeZoneY;
            w = PX(GWIDTH);
            h = PY(GHEIGHT);

            class Controls {
                class Background : RscPicture {
                    idc = 401;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(GWIDTH);
                    h = PY(GHEIGHT);
                };

                class Heading : PRA3_H2Text {
                    idc = 402;
                    text = "DEPLOYMENT";
                    x = PX(0.5);
                    y = PY(0.5);
                    w = PX(GWIDTH-1);
                    h = PY(3);
                };

                class SpawnPointList : PRA3_RscListNBox {
                    idc = 403;
                    x = PX(0);
                    y = PY(4);
                    w = PX(GWIDTH);
                    h = PY(22.5);

                    columns[] = {0,0.075,0.875};

                    onLBSelChanged = "'PRA3_UI_RespawnScreen_SpawnPointList_onLBSelChanged' call PRA3_Core_fnc_localEvent;";
                };
            };
        };
        */

        class DeployButton : PRA3_RscButtonMenu_Colored {
            idc = 500;
            text = "DEPLOY";
            sizeEx = PY(4);
            x = safeZoneW - PX(40) + safeZoneX;
            y = safeZoneY + safeZoneH - PY(6) ;
            w = PX(40);
            h = PY(6);
            fade = 1;

            colorText[] = {0,0,0,1};

            action = "'PRA3_UI_RespawnScreen_DeployButton_action' call PRA3_Core_fnc_localEvent;";
        };
    };
};
