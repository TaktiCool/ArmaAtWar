class GVAR(RespawnScreen) {
    idd = -1;
    onLoad = "[_this select 0] call PRA3_mission_fnc_initRespawnScreen;";
    onUnLoad = "[_this select 0] call PRA3_mission_fnc_closeRespawnScreen;";
    class Controls {

        #define GWIDTH 40
        #define GHEIGHT 3
        class TeamInfo : RscControlsGroupNoScollbars {
            idc = 100;
            x = 0.5 - PX(75);
            y = safeZoneY + PY(10);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);

            class Controls {
                class Background : RscPicture {
                    idc = 101;
                    text = "#(argb,8,8,3)color(0.2,0.2,0.2,0.75)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(GWIDTH);
                    h = PY(GHEIGHT);
                };
                class TeamFlag : RscPicture {
                    idc = 102;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(0.5);
                    y = PY(0.5);
                    w = PX(3.33);
                    h = PY(2);
                };

                class TeamName : PRA3_H1Text {
                    idc = 103;
                    text = "US ARMY";
                    x = PX(5);
                    y = PY(0);
                    w = PX(GWIDTH-6);
                    h = PY(GHEIGHT);
                };
            };
        };

        #define GHEIGHT 44.5
        class SquadManagement : RscControlsGroupNoScollbars {
            idc = 200;
            x = 0.5 - PX(75);
            y = safeZoneY + PY(14);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);

            class Controls {
                class Background : RscPicture {
                    idc = 201;
                    text = "#(argb,8,8,3)color(0.2,0.2,0.2,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(GWIDTH);
                    h = PY(GHEIGHT);
                };

                class Heading : PRA3_H2Text {
                    idc = 202;
                    text = "SQUAD";
                    x = PX(0.5);
                    y = PY(0);
                    w = PX(GWIDTH-0.5);
                };

                class NewSquadDesignator : PRA3_RscText {
                    idc = 203;
                    x = PX(1);
                    y = PY(4);
                    w = PX(2);
                };

                class NewSquadDescriptionInput : PRA3_RscEdit {
                    idc = 204;
                    x = PX(4);
                    y = PY(4);
                    w = PX(26.5);
                };

                class CreateSquadBtn : PRA3_RscButtonMenu {
                    idc = 205;
                    text = "CREATE";
                    x = PX(31);
                    y = PY(4);
                    w = PX(8);

                    onButtonClick = "[_this] call PRA3_mission_fnc_createSquadBtn;";
                };

                class SquadList : RscListNBox {
                    idc = 206;
                    x = 0;
                    y = PY(8);
                    w = PX(GWIDTH);
                    h = PY(14.5);
                    sizeEx = PY(2);
                    rowHeight = PY(3.5);
                    columns[] = {0,0.1,0.75,0.85};
                };



                class BackgroundSquadDetails : RscPicture {
                    idc = 207;
                    text = "#(argb,8,8,3)color(0.2,0.2,0.2,1)";
                    x = PX(0);
                    y = PY(22.5);
                    w = PX(GWIDTH);
                    h = PY(22);
                };

                class HeadingSquadDetails : PRA3_H2Text {
                    idc = 208;
                    text = "ALPHA";
                    x = PX(0.5);
                    y = PY(22.5);
                    w = PX(GWIDTH/2);
                };

                class SquadMemberList : RscListNBox {
                    idc = 209;
                    x = 0;
                    y = PY(26.5);
                    w = PX(GWIDTH);
                    h = PY(10.5);

                    rowHeight = PY(3.5);
                };

                class JoinLeaveBtn : PRA3_RscButtonMenu {
                    idc = 210;
                    text = "JOIN";
                    x = PX(34);
                    y = PY(22.5);
                    w = PX(6);

                    onButtonClick = "[_this] call PRA3_mission_fnc_joinLeaveBtn;";
                };

                class KickBtn : PRA3_RscButtonMenu {
                    idc = 211;
                    text = "KICK";
                    x = PX(27.5);
                    y = PY(22.5);
                    w = PX(6);

                    onButtonClick = "[_this] call PRA3_mission_fnc_kickSquadMemberBtn;";
                };

                class PromoteBtn : PRA3_RscButtonMenu {
                    idc = 212;
                    text = "PROMOTE";
                    x = PX(18);
                    y = PY(22.5);
                    w = PX(9);

                    onButtonClick = "[_this] call PRA3_mission_fnc_promoteSquadMemberBtn;";
                };
            };
        };
    };
};
