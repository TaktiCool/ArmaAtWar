#include "controls\TeamInfo.hpp"
#include "controls\SquadManagement.hpp"
#include "controls\RoleManagement.hpp"
#include "controls\DeploymentManagement.hpp"

class PRA3_UI_RespawnScreen {
    idd = 1000;
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
            y = safeZoneY;
            //y = PY(10.5) + safeZoneY;
            w = safeZoneW - PX(80);
            //h = safeZoneH-PY(10.5);
            h = safeZoneH;
        };
    };

    class Controls {

        class MissionName : RscStructuredText {
            idc = 604;
            x = PX(0.5) + safeZoneX;
            y = PY(1.5) + safeZoneY;
            w = PX(39);
            h = PY(3);
            shadow = 0;
            size = PY(2.9);
            text = "Operation Altis";
            fade = 1;
            class Attributes {
                font = "PuristaMedium";
                color = "#C48013";
                align = "left";
                shadow = 0;
            };
        };

        class Tickets : RscControlsGroupNoScollbars {
            idc = 800;
            x = safeZoneX + safeZoneW - PX(40);
            y = safeZoneY+PY(3);
            w = PX(40);
            h = PY(6);
            fade = 1;
            class Controls {
                class TeamFlag : RscPicture {
                    idc = 801;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(20-5);
                    y = PY(0.75);
                    w = PX(4.5);
                    h = PY(3);
                };

                class TeamFlag2 : TeamFlag {
                    idc = 802;
                    x = PX(20+0.5);

                };

                class TeamName : PRA3_RscText {
                    idc = 803;
                    text = "NATO";
                    style = ST_RIGHT;
                    x = PX(1);
                    y = PY(0);
                    w = PX(13.5);
                    h = PY(2.5);
                    sizeEx = PY(2.9);
                    font = "PuristaSemiBold";
                };

                class TeamName2 : TeamName {
                    idc = 804;
                    text = "CSAT";
                    style = ST_LEFT;
                    x = PX(20+5.5);
                    y = PY(0);
                };

                class Tickets : PRA3_RscText {
                    idc = 805;
                    text = "1234";
                    style = ST_RIGHT;
                    x = PX(1);
                    y = PY(2.2);
                    w = PX(13.5);
                    h = PY(2);
                };

                class Tickets2 : Tickets {
                    idc = 806;
                    style = ST_LEFT;
                    x = PX(20+5.5);
                };
            };
        };
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

        class Notification : RscControlsGroupNoScollbars {
            idc = 4000;
            x = 0.5 - PX(25);
            y = PY(0.5) + safeZoneY;
            w = PX(50);
            h = PY(3.5);
            fade = 1;

            class Controls {
                class Background : RscPicture {
                    idc = 4001;
                    text = "ui\media\notification_gradient_ca.paa";
                    x = PX(0);
                    y = PY(0);
                    w = PX(50);
                    h = PY(4);
                    colorText[] = {0.8,0.8,0.8,1};
                };

                class NotificationText : RscStructuredText {
                    idc = 4002;
                    shadow = 0;
                    x = PX(0);
                    y = PY(0.2);
                    w = PX(50);
                    h = PY(3);
                    text = "TEST";
                    size = PY(2.5);
                    class Attributes
                    {
                        font = "PuristaMedium";
                        color = "#ffffff";
                        align = "center";
                        shadow = 1;
                    };
                };
            };
        };
    };
};
