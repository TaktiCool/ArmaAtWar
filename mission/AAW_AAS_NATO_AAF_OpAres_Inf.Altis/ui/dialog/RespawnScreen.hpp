#include "controls\TeamInfo.hpp"
#include "controls\SquadManagement.hpp"
#include "controls\RoleManagement.hpp"
#include "controls\DeploymentManagement.hpp"

class AAW_UI_RespawnScreen {
    idd = 1000;
    onLoad = "['AAW_UI_RespawnScreen_onLoad', _this] call CLib_fnc_localEvent;";
    onUnload = "'AAW_UI_RespawnScreen_onUnload' call CLib_fnc_localEvent;";

    class ControlsBackground {
        class Map : RscMapControl {
            idc = 800;
            x = PX(40) + safeZoneX;
            y = safeZoneY;
            //y = PY(10.5) + safeZoneY;
            w = safeZoneW - PX(80);
            //h = safeZoneH-PY(10.5);
            h = safeZoneH;
        };
    };
    class Controls {
        class TeamInfo : AAW_UI_TeamInfo {};
        class SquadManagement : AAW_UI_SquadManagement {};
        class RoleManagement : AAW_UI_RoleManagement {};
        class DeploymentManagement : AAW_UI_DeploymentManagement {};
        class MissionName : RscControlsGroupNoScrollbars {
            idc = 500;
            x = safeZoneX;
            y = safeZoneY;
            w = PX(40);
            h = PY(6);
            fade = 1;

            class Controls {
                class Background : RscPicture {
                    idc = 599;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(40);
                    h = PY(6);
                };
                class MissionName : RscStructuredText {
                    idc = 501;
                    x = PX(0.5);
                    y = PY(1.5);
                    w = PX(39);
                    h = PY(3);
                    shadow = 0;
                    size = PY(2.9);
                    text = "Operation Altis";
                    class Attributes {
                        font = "PuristaMedium";
                        color = "#C48013";
                        align = "left";
                        shadow = 0;
                    };
                };
            };
        };
        class Tickets : RscControlsGroupNoScrollbars {
            idc = 600;
            x = safeZoneX + safeZoneW - PX(40);
            y = safeZoneY;
            w = PX(40);
            h = PY(10.5);
            fade = 1;

            class Controls {
                class Background : RscPicture {
                    idc = 699;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(40);
                    h = PY(10.5);
                };
                class TeamFlag : RscPicture {
                    idc = 601;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(20-4);
                    y = PY(3.5);
                    w = PX(3.5);
                    h = PY(3.5);
                };
                class TeamFlag2 : TeamFlag {
                    idc = 602;
                    x = PX(20+0.5);
                };
                class TeamName : AAW_RscText {
                    idc = 603;
                    text = "NATO";
                    style = ST_RIGHT;
                    x = PX(1);
                    y = PY(3);
                    w = PX(15);
                    h = PY(2.5);
                    sizeEx = PY(2.9);
                    font = "PuristaSemiBold";
                };
                class TeamName2 : TeamName {
                    idc = 604;
                    text = "CSAT";
                    style = ST_LEFT;
                    x = PX(20+4);
                    y = PY(3);
                };
                class Tickets : AAW_RscText {
                    idc = 605;
                    text = "1234";
                    style = ST_RIGHT;
                    x = PX(1);
                    y = PY(5.2);
                    w = PX(15);
                    h = PY(2);
                };
                class Tickets2 : Tickets {
                    idc = 606;
                    style = ST_LEFT;
                    x = PX(20+4);
                };
            };
        };
        class Notification : RscControlsGroupNoScrollbars {
            idc = 700;
            x = 0.5 - PX(25);
            y = PY(0.5) + safeZoneY;
            w = PX(50);
            h = PY(3.5);
            fade = 1;

            class Controls {
                class Background : RscPicture {
                    idc = 799;
                    text = "ui\media\notification_gradient_ca.paa";
                    x = PX(0);
                    y = PY(0);
                    w = PX(50);
                    h = PY(4);
                    colorText[] = {0.8,0.8,0.8,1};
                };
                class NotificationText : RscStructuredText {
                    idc = 701;
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
