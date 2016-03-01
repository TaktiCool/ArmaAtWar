class GVAR(RespawnScreen) {
    idd = -1;
    onLoad = "uiNamespace setVariable [""BG_respawn_RespawnScreen"", _this select 0];";
    class Controls {


        #define GWIDTH 35
        #define GHEIGHT 40

        class SquadList : RscControlsGroup {
            idc = 200;
            x = 0.5 - PX(75);
            y = safeZoneY + PY(14);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);



            class Controls {
                class Background : RscPicture {
                    idc = 201;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(GWIDTH);
                    h = PY(GHEIGHT);
                };

                class Heading : BG_H2Text {
                    idc = 202;
                    text = "SQUADS";
                    x = PX(0.5);
                    y = PY(0);
                    w = PX(GWIDTH-0.5);
                };

                class BackgroundList : RscPicture {
                    idc = 203;
                    text = "#(argb,8,8,3)color(0.2,0.2,0.2,1)";
                    x = PX(1);
                    y = PY(4);
                    w = PX(33);
                    h = PY(31.5);
                };

                class SquadList : RscListNBox {
                    idc = 204;
                    x = PX(1);
                    y = PY(4);
                    w = PX(33);
                    h = PY(31.5);
                    font = "PuristaMedium";
                    sizeEx = PY(2);
                    colorSelectBackground2[] = {0.4,0.4,0.4,1};
                	colorSelectBackground[] = {0.4,0.4,0.4,1};
                    colorSelect2[] = {1,1,1,1};
                	colorSelect[] = {1,1,1,1};
                    rowHeight = PY(3);
                    columns[] = {-0.01,1/8,6/8};
                };

                class NewSquadBackground : RscPicture {
                    idc = 205;
                    text = "#(argb,8,8,3)color(0.2,0.2,0.2,1)";
                    x = PX(1);
                    y = PY(36);
                    w = PX(GWIDTH-2);
                    h = PY(3);
                };

                class NewSquadDesignator : BG_RscText {
                    idc = 206;
                    x = PX(4.5);
                    y = PY(36);
                    w = PX(2);
                };

                class NewSquadDescriptionInput : BG_RscEdit {
                    idc = 207;
                    x = PX(7);
                    y = PY(36);
                    w = PX(18.5);
                };

                class CreateSquadBtn : BG_RscButtonMenu {
                    idc = 208;
                    text = "CREATE";
                    x = PX(26);
                    y = PY(36);
                    w = PX(8);

                    onButtonClick = "[_this] call BG_respawn_fnc_createSquadBtn;";
                };
            };
        };

        #define GWIDTH 29
        #define GHEIGHT 40
        class SquadManagement : RscControlsGroup {
            idc = 300;
            x = 0.5 - PX(40);
            y = safeZoneY + PY(14);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);



            class Controls {
                class Background : RscPicture {
                    idc = 301;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(GWIDTH);
                    h = PY(GHEIGHT);
                };

                class Heading : BG_H2Text {
                    idc = 302;
                    text = "BRAVO";
                    x = PX(0.5);
                    y = PY(0);
                    w = PX(GWIDTH-0.5);
                };

                class PlayerCount : BG_RscText {
                    idc = 302;
                    text = "6 / 9";
                    colorText[] = {0.4,0.4,0.4,1};
                    x = PX(23);
                    y = PY(0);
                    w = PX(4);
                };

                class SquadDescriptionInput : BG_RscEdit {
                    idc = 303;
                    x = PX(1);
                    y = PY(4);
                    w = PX(18.5);
                };

                class ChangeBtn : BG_RscButtonMenu {
                    idc = 304;
                    text = "CHANGE";
                    x = PX(20);
                    y = PY(4);
                    w = PX(8);
                };


                class BackgroundList : RscPicture {
                    idc = 305;
                    text = "#(argb,8,8,3)color(0.2,0.2,0.2,1)";
                    x = PX(1);
                    y = PY(8);
                    w = PX(27);
                    h = PY(27.5);
                };

                class SquadList : RscListNBox {
                    idc = 306;
                    x = PX(1);
                    y = PY(8);
                    w = PX(27);
                    h = PY(27.5);
                    font = "PuristaMedium";
                    sizeEx = PY(2);
                    colorSelectBackground2[] = {0.4,0.4,0.4,1};
                	colorSelectBackground[] = {0.4,0.4,0.4,1};
                    colorSelect2[] = {1,1,1,1};
                	colorSelect[] = {1,1,1,1};
                    rowHeight = PY(3);
                    columns[] = {-0.01,1/8,6/8};
                };

                class JoinLeaveBtn : BG_RscButtonMenu {
                    idc = 307;
                    text = "JOIN";
                    x = PX(20);
                    y = PY(36);
                    w = PX(8);
                };

                class PromoteBtn : BG_RscButtonMenu {
                    idc = 308;
                    text = "PROMOTE";
                    x = PX(1);
                    y = PY(36);
                    w = PX(8);
                };

                class KickBtn : BG_RscButtonMenu {
                    idc = 309;
                    text = "KICK";
                    x = PX(9.5);
                    y = PY(36);
                    w = PX(8);
                };
            };
        };
        #define GWIDTH 35
        #define GHEIGHT 3
        class TeamInfo : RscControlsGroup {
            idc = 100;
            x = 0.5 - PX(75);
            y = safeZoneY + PY(10);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);

            class Controls {
                class Background : RscPicture {
                    idc = 101;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    colorBackground[] = {0,0,0,0.8};
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

                class TeamName : BG_H1Text {
                    idc = 103;
                    text = "US ARMY";
                    x = PX(5);
                    y = PY(0);
                    w = PX(GWIDTH-6);
                    h = PY(GHEIGHT);
                };
            };
        };
    };
};
