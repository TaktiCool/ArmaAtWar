class PRA3_UI_RespawnScreen {
    idd = 1000;
    onLoad = "'PRA3_UI_RespawnScreen_onLoad' call PRA3_Core_fnc_localEvent;";
    onUnload = "'PRA3_UI_RespawnScreen_onUnload' call PRA3_Core_fnc_localEvent;";

    class controlsBackground {
        #define GHEIGHT 82
        class MapBackground : RscPicture {
            idc = 600;
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            x = PX(72) + safeZoneX;
            y = PY(10) + safeZoneY;
            w = safeZoneW - PX(77);
            h = PY(GHEIGHT);
        };

        class Map : RscMapControl {
            idc = 700;
            x = PX(72.5) + safeZoneX;
            y = PY(10.5) + safeZoneY;
            w = safeZoneW - PX(78);
            h = PY(GHEIGHT-1);
        };
    };

    class Controls {
        #undef GHEIGHT
        #define GWIDTH 40
        #define GHEIGHT 3
        class TeamInfo : RscControlsGroupNoScollbars {
            idc = 100;
            x = PX(5) + safeZoneX;
            y = PY(10) + safeZoneY;
            w = PX(GWIDTH);
            h = PY(GHEIGHT);

            class Controls {
                class Background : RscPicture {
                    idc = 101;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
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
                    w = PX(3);
                    h = PY(2);
                };

                class TeamName : PRA3_H1Text {
                    idc = 103;
                    text = "US ARMY";
                    x = PX(4);
                    y = PY(0);
                    w = PX(GWIDTH-13);
                    h = PY(GHEIGHT);
                };

                class ChangeSideBtn : PRA3_RscButtonMenu {
                    idc = 104;
                    text = "CHANGE";
                    x = PX(GWIDTH-9);
                    y = PY(0);
                    w = PX(9);
                    h = PY(GHEIGHT);

                    onButtonClick = "'PRA3_UI_RespawnScreen_ChangeSideBtn_onButtonClick' call PRA3_Core_fnc_localEvent;";
                };
            };
        };
        #undef GHEIGHT
        #define GHEIGHT 44.5
        class SquadManagement : RscControlsGroupNoScollbars {
            idc = 200;
            x = PX(5) + safeZoneX;
            y = PY(14) + safeZoneY;
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

                class Heading : PRA3_H2Text {
                    idc = 202;
                    text = "SQUAD";
                    x = PX(0.5);
                    y = PY(0.5);
                    w = PX(GWIDTH-1);
                    h = PY(3);
                };

                class NewSquadDesignator : PRA3_RscText {
                    idc = 203;
                    text = "";
                    x = PX(0.5);
                    y = PY(4);
                    w = PX(2.5);
                    h = PY(3);
                };

                class NewSquadDescriptionInput : PRA3_RscEdit {
                    idc = 204;
                    x = PX(3.5);
                    y = PY(4);
                    w = PX(GWIDTH-23);
                    h = PY(3);
                    onChar = "'PRA3_UI_RespawnScreen_SquadDescriptionInput_TextChanged' call PRA3_Core_fnc_localEvent;";
                };

                class SquadTypeCombo : PRA3_RscCombo {
                    idc = 205;
                    x = PX(GWIDTH-19.5);
                    y = PY(4);
                    w = PX(10);
                    h = PY(3);
                };

                class CreateSquadBtn : PRA3_RscButtonMenu {
                    idc = 206;
                    text = "CREATE";
                    x = PX(GWIDTH-9);
                    y = PY(4);
                    w = PX(8);
                    h = PY(3);

                    onButtonClick = "'PRA3_UI_RespawnScreen_CreateSquadBtn_onButtonClick' call PRA3_Core_fnc_localEvent;";
                };

                class SquadList : PRA3_RscListNBox {
                    idc = 207;
                    x = PX(0);
                    y = PY(8);
                    w = PX(GWIDTH);
                    h = PY(14.5);

                    columns[] = {0,0.075,0.5,0.85};

                    onLBSelChanged = "'PRA3_UI_RespawnScreen_SquadManagement_update' call PRA3_Core_fnc_localEvent;";
                };

                class BackgroundSquadDetails : RscPicture {
                    idc = 208;
                    text = "#(argb,8,8,3)color(0.1,0.1,0.1,1)";
                    x = PX(0);
                    y = PY(GHEIGHT-22);
                    w = PX(GWIDTH);
                    h = PY(22);
                };

                class HeadingSquadDetails : PRA3_H2Text {
                    idc = 209;
                    text = "";
                    x = PX(0.5);
                    y = PY(GHEIGHT-22);
                    w = PX(GWIDTH-22);
                    h = PY(3);
                };

                class SquadMemberList : PRA3_RscListNBox {
                    idc = 210;
                    x = PX(0);
                    y = PY(GHEIGHT-18.3);
                    w = PX(GWIDTH);
                    h = PY(18.3);

                    columns[] = {0};

                    onLBSelChanged = "'PRA3_UI_RespawnScreen_SquadManagement_update' call PRA3_Core_fnc_localEvent;";
                };

                class JoinLeaveBtn : PRA3_RscButtonMenu {
                    idc = 211;
                    text = "JOIN";
                    x = PX(GWIDTH-6);
                    y = PY(GHEIGHT-22);
                    w = PX(6);
                    h = PY(3);

                    onButtonClick = "'PRA3_UI_RespawnScreen_JoinLeaveBtn_onButtonClick' call PRA3_Core_fnc_localEvent;";
                };

                class KickBtn : PRA3_RscButtonMenu {
                    idc = 212;
                    text = "KICK";
                    x = PX(GWIDTH-12.5);
                    y = PY(GHEIGHT-22);
                    w = PX(6);
                    h = PY(3);

                    onButtonClick = "'PRA3_UI_RespawnScreen_KickBtn_onButtonClick' call PRA3_Core_fnc_localEvent;";
                };

                class PromoteBtn : PRA3_RscButtonMenu {
                    idc = 213;
                    text = "PROMOTE";
                    x = PX(GWIDTH-22);
                    y = PY(GHEIGHT-22);
                    w = PX(9);
                    h = PY(3);

                    onButtonClick = "'PRA3_UI_RespawnScreen_PromoteBtn_onButtonClick' call PRA3_Core_fnc_localEvent;";
                };
            };
        };
        #undef GHEIGHT
        #define GHEIGHT 38.5
        class RoleManagement : RscControlsGroupNoScollbars {
            idc = 300;
            x = PX(5) + safeZoneX;
            y = PY(59.5) + safeZoneY;
            w = PX(GWIDTH);
            h = PY(GHEIGHT);

            class Controls {
                class Background : RscPicture {
                    idc = 301;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(GWIDTH);
                    h = PY(GHEIGHT-15.4);
                };

                class Heading : PRA3_H2Text {
                    idc = 302;
                    text = "ROLE";
                    x = PX(0.5);
                    y = PY(0.5);
                    w = PX(GWIDTH-1);
                    h = PY(3);
                };

                class RoleList : PRA3_RscListNBox {
                    idc = 303;
                    x = PX(0);
                    y = PY(4);
                    w = PX(GWIDTH);
                    h = PY(19);

                    columns[] = {0,0.85};

                    onLBSelChanged = "'PRA3_UI_RespawnScreen_RoleList_onLBSelChanged' call PRA3_Core_fnc_localEvent;";
                };

                class WeaponTabs : RscToolbox {
                    idc = 304;
                    x = PX(0);
                    y = PY(GHEIGHT-15.5);
                    w = PX(GWIDTH);
                    h = PY(2.5);

                    colorBackground[] = {0.2, 0.2, 0.2, 0.8};
                    colorSelectedBg[] = {0.1, 0.1, 0.1, 1};

                    sizeEx = PY(2);
                    rows = 1;
                    columns = 3;
                    strings[] = {"Primary", "Secondary", "Special"};

                    onToolBoxSelChanged = "'PRA3_UI_RespawnScreen_WeaponTabs_onToolBoxSelChanged' call PRA3_Core_fnc_localEvent;";
                };

                class WeaponBackground : RscPicture {
                    idc = 305;
                    text = "#(argb,8,8,3)color(0.1,0.1,0.1,1)";
                    x = PX(0);
                    y = PY(GHEIGHT-13);
                    w = PX(GWIDTH);
                    h = PY(13);
                };

                class WeaponPicture : RscPicture {
                    idc = 306;
                    text = "";
                    style = ST_KEEP_ASPECT_RATIO + ST_PICTURE;
                    x = PX(7);
                    y = PY(GHEIGHT-13);
                    w = PX(GWIDTH-14);
                    h = PY(10);
                };

                class WeaponName : PRA3_RscText {
                    idc = 307;
                    style = ST_CENTER;
                    text = "";
                    x = PX(0);
                    y = PY(GHEIGHT-3);
                    w = PX(GWIDTH);
                    h = PY(3);
                };
            };
        };

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

        #undef GHEIGHT
        #undef GWIDTH
        #define GWIDTH 26
        #define GHEIGHT 5
        class DeployButton : PRA3_RscButtonMenu_Colored {
            idc = 500;
            text = "DEPLOY";
            sizeEx = PY(4);
            colorBackground[] = {0.77, 0.51, 0.08, 1};
            x = safeZoneW - PX(GWIDTH+5) + safeZoneX;
            y = PY(93) + safeZoneY;
            w = PX(GWIDTH);
            h = PY(GHEIGHT);

            colorText[] = {0,0,0,1};

            action = "'PRA3_UI_RespawnScreen_DeployButton_action' call PRA3_Core_fnc_localEvent;";
        };
    };
};
