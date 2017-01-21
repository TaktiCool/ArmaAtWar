#include "controls\TeamInfo.hpp"
#include "controls\SquadManagement.hpp"
#include "controls\RoleManagement.hpp"
#include "controls\DeploymentManagement.hpp"

class AAW_UI_RespawnScreen {
    idd = 1000;
    onLoad = "['AAW_UI_RespawnScreen_onLoad', _this] call CLib_fnc_localEvent;";
    onUnload = "'AAW_UI_RespawnScreen_onUnload' call CLib_fnc_localEvent;";


    class ControlsBackground {

    };

    class Controls {

        class TeamInfo : AAW_UI_TeamInfo {};
        class MissionName : RscControlsGroupNoScrollbars {
            idc = 500;
            x = safeZoneX + safeZoneW - PX(64);
            y = safeZoneY;
            w = PX(60);
            h = PY(10);

            class Controls {
                class MissionName : TxtLarge {
                    idc = 501;
                    style = ST_RIGHT;
                    y = PY(2.6);
                    w = PX(60);
                    text = "OPERATION SPARTAN SHIELD";
                };

                class MissionType : TxtMedium {
                    idc = 502;
                    style = ST_RIGHT;
                    y = PY(5.6);
                    w = PX(60);
                    text = "Advance & Secure";
                };
            };
        };

        class SquadManagement : AAW_UI_SquadManagement {};
    };
};
