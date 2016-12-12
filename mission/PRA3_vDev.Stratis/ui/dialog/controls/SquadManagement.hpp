class PRA3_UI_SquadManagement : RscControlsGroupNoScrollbars {
    idc = 200;
    x = safeZoneX;
    y = PY(10) + safeZoneY;
    w = PX(40);
    h = PY(98);

    class Controls {
        class MySquad : RscControlsGroupNoScrollbars {
            idc = 201;
            x = PX(4);
            y = PY(2);
            w = PX(35);
            h = PY(50);
            class Controls {
                class BackgroundHeader : BgDarkTransparent {
                    idc = 299;
                    text = "#(argb,8,8,3)color(0.13,0.54,0.21,1)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(35);
                    h = PY(4);
                };

                class SquadIconBg : BgDarkTransparent {
                    idc = 204;
                    x = PX(1);
                    y = PY(1);
                    w = PX(2);
                    h = PY(2);
                    text = "#(argb,8,8,3)color(1,1,1,1)";
                };

                class SquadIcon : BgDarkTransparent {
                    idc = 205;
                    x = PX(1.2);
                    y = PY(1.2);
                    w = PX(1.6);
                    h = PY(1.6);
                    colorText[] = {0,0,0,1};
                    text = "A3\ui_f\data\igui\cfg\simpletasks\letters\a_ca.paa";
                };

                class Header : TxtBold {
                    idc = 202;
                    style = ST_LEFT;
                    text = "JOIN OR CREATE A SQUAD";
                    x = PX(4);
                    y = PY(1);
                    w = PX(29);
                };

                class HeaderSecondary : Header {
                    idc = 203;
                    style = ST_RIGHT;
                    text = "";
                    font = "RobotoCondensed";
                };

                class ListEntry0 : RscControlsGroupNoScrollbars {
                    idc = 210;
                    x = PX(0);
                    y = PY(4);
                    w = PX(35);
                    h = PY(4);
                    onMouseMoving = "['PRA3_UI_RespawnScreen_SquadMemberListEntry_onMouseMoving', _this] call CLib_fnc_localEvent;";
                    class Controls {

                        class Background: BgDarkTransparent {
                            idc = 1;
                            w = PX(35);
                            h = PY(4);
                        };

                        class TeamColor: BgDarkTransparent {
                            idc = 2;
                            w = PX(0.5);
                            h = PY(4);
                        };

                        class RoleIcon: BgDarkTransparent {
                            idc = 12;
                            x = PX(0.5);
                            y = PY(0.5);
                            w = PX(3);
                            h = PY(3);
                        };

                        class RightTextColumn : TxtMedium {
                            idc = 3;
                            style = ST_RIGHT;
                            colorText[] = {0.8,0.8,0.8,1};
                            font = "RobotoCondensed";
                            text = "Squad Leader";
                            x = PX(4);
                            y = PY(1);
                            w = PX(30);
                        };

                        class LeftTextColumn : TxtMedium {
                            idc = 4;
                            style = ST_LEFT;
                            text = "Hoegnison";
                            x = PX(4);
                            y = PY(1);
                            w = PX(30);
                        };

                        class BtnKick : RscActiveText {
                            idc = 5;
                            text = "KICK";
                            color[] = {1,1,1,1};
                            colorActive[] = {0.8,0.2,0,1};
                            x = PX(35-5);
                            y = PY(0);
                            w = PX(5);
                            h = PY(4);
                            shadow = 0;
                        };

                        class BtnPromote : BtnKick {
                            idc = 6;
                            text = "PROMOTE";
                            color[] = {1,1,1,1};
                            colorActive[] = {1.3*0.13,1.3*0.54,1.3*0.21,1};
                            x = PX(35-12);
                            y = PY(0);
                            w = PX(7);
                            h = PY(4);
                        };

                        class TeamYellow : RscPicture {
                            idc = 7;
                            text = "#(argb,8,8,3)color(0.98,0.7,0.12,1)";
                            x = PX(35-15);
                            y = PY(1);
                            w = PX(2);
                            h = PY(2);
                        };
                        class TeamGreen : TeamYellow {
                            idc = 8;
                            text = "#(argb,8,8,3)color(0.13,0.54,0.21,1)";
                            x = PX(35-17);
                        };
                        class TeamBlue : TeamYellow {
                            idc = 9;
                            text = "#(argb,8,8,3)color(0.18,0.5,0.93,1)";
                            x = PX(35-19);
                        };
                        class TeamRed : TeamYellow {
                            idc = 10;
                            text = "#(argb,8,8,3)color(0.8,0.2,0.0,1)";
                            x = PX(35-21);
                        };
                        class TeamWhite : TeamYellow {
                            idc = 11;
                            text = "#(argb,8,8,3)color(0.8,0.8,0.8,1)";
                            x = PX(35-23);
                        };
                    };
                };
                class ListEntry1 : ListEntry0 {
                    idc = 211;
                    y = PY(8);
                };
                class ListEntry2 : ListEntry0 {
                    idc = 212;
                    y = PY(12);
                };
                class ListEntry3 : ListEntry0 {
                    idc = 213;
                    y = PY(16);
                };
                class ListEntry4 : ListEntry0 {
                    idc = 214;
                    y = PY(20);
                };
                class ListEntry5 : ListEntry0 {
                    idc = 215;
                    y = PY(24);
                };
                class ListEntry6 : ListEntry0 {
                    idc = 216;
                    y = PY(28);
                };
                class ListEntry7 : ListEntry0 {
                    idc = 217;
                    y = PY(32);
                };
                class ListEntry8 : ListEntry0 {
                    idc = 218;
                    y = PY(36);
                };
                class ListEntry9 : ListEntry0 {
                    idc = 219;
                    y = PY(40);
                };
            };
        };

        /*
        class NewSquadDescriptionInput : PRA3_RscEdit {
            idc = 204;
            x = PX(3.5);
            y = PY(4);
            w = PX(GWIDTH-23);
            h = PY(3);
            onChar = "'PRA3_UI_RespawnScreen_SquadDescriptionInput_TextChanged' call CLib_fnc_localEvent;";
        };
        */

        class BtnShowSquadList : BtnWhite {
            idc = 207;
            text = " SQUADS";
            style = 0;
            x = PX(21.5-17.5);
            y = PY(92);
            w = PX(17.5);
            colorBackground[] = {0.12,0.1,0.15,1};
            colorText[] = {1,1,1,1};
            onButtonClick = "'PRA3_UI_RespawnScreen_BtnShowSquadList_onButtonClick' call CLib_fnc_localEvent;";
        };


        class CreateSquadBtn : BtnWhite {
            idc = 206;
            text = "CREATE SQUAD";
            x = PX(21.5);
            y = PY(92);
            w = PX(17.5);
            onButtonClick = "'PRA3_UI_RespawnScreen_CreateSquadBtn_onButtonClick' call CLib_fnc_localEvent;";
        };


        class SquadList : RscControlsGroup {
            idc = 230;

            x = PX(4);
            y = PY(62);
            w = PX(35);
            h = PX(40);

            class Controls {
                class BackgroundHeader : BgDarkLightTransparent {
                    idc = 231;
                    x = PX(0);
                    y = PY(0);
                    w = PX(35);
                    h = PY(40);
                };

                class ListEntry0 : RscControlsGroupNoScrollbars {
                    idc = 240;
                    x = PX(0);
                    y = PY(0);
                    w = PX(35);
                    h = PY(4);
                    onMouseMoving = "['PRA3_UI_RespawnScreen_SquadListEntry_onMouseMoving', _this] call CLib_fnc_localEvent;";
                    class Controls {

                        class SquadIconBg : BgDarkTransparent {
                            idc = 1;
                            x = PX(1);
                            y = PY(1);
                            w = PX(2);
                            h = PY(2);
                            text = "#(argb,8,8,3)color(0,0,0,1)";
                        };

                        class SquadIcon : BgDarkTransparent {
                            idc = 2;
                            x = PX(1.2);
                            y = PY(1.2);
                            w = PX(1.6);
                            h = PY(1.6);
                            colorText[] = {1,1,1,1};
                            text = "A3\ui_f\data\igui\cfg\simpletasks\letters\a_ca.paa";
                        };

                        class RightTextColumn : TxtMedium {
                            idc = 3;
                            style = ST_RIGHT;
                            colorText[] = {0.8,0.8,0.8,1};
                            font = "RobotoCondensed";
                            text = "Rifle Squad | 8 / 9";
                            x = PX(4);
                            y = PY(1);
                            w = PX(30);
                        };

                        class LeftTextColumn : TxtMedium {
                            idc = 4;
                            style = ST_LEFT;
                            text = "ALPHA";
                            x = PX(4);
                            y = PY(1);
                            w = PX(30);
                        };

                        class BtnJoin : RscActiveText {
                            idc = 5;
                            text = "JOIN";
                            shadow = 0;
                            color[] = {0.8,0.8,0.8,0.8};
                            colorActive[] = {1,1,1,1};
                            x = PX(35-6.5);
                            y = PY(0);
                            w = PX(5);
                            h = PY(4);
                        };
                    };
                };

                class ListEntry1 : ListEntry0 {
                    idc = 241;
                    y = PY(4);
                };

                class ListEntry2 : ListEntry0 {
                    idc = 242;
                    y = PY(8);
                };

                class ListEntry3 : ListEntry0 {
                    idc = 243;
                    y = PY(12);
                };

                class ListEntry4 : ListEntry0 {
                    idc = 244;
                    y = PY(16);
                };

                class ListEntry5 : ListEntry0 {
                    idc = 245;
                    y = PY(20);
                };

                class ListEntry6 : ListEntry0 {
                    idc = 246;
                    y = PY(24);
                };

                class ListEntry7 : ListEntry0 {
                    idc = 247;
                    y = PY(28);
                };

                class ListEntry8 : ListEntry0 {
                    idc = 248;
                    y = PY(32);
                };

                class ListEntry9 : ListEntry0 {
                    idc = 249;
                    y = PY(36);
                };

                class ListEntry10 : ListEntry0 {
                    idc = 250;
                    y = PY(40);
                };


                class ListEntry11 : ListEntry0 {
                    idc = 251;
                    y = PY(44);
                };

            };
        };
        /*

        class JoinLeaveBtn : PRA3_RscButtonMenu {
            idc = 211;
            text = "JOIN";
            x = PX(GWIDTH-6);
            y = PY(43.5);
            w = PX(6);
            h = PY(3);
            fade = 1;

            onButtonClick = "'PRA3_UI_RespawnScreen_JoinLeaveBtn_onButtonClick' call CLib_fnc_localEvent;";
        };

        class KickBtn : PRA3_RscButtonMenu {
            idc = 212;
            text = "KICK";
            x = PX(GWIDTH-12.5);
            y = PY(43.5);
            w = PX(6);
            h = PY(3);
            fade = 1;

            onButtonClick = "'PRA3_UI_RespawnScreen_KickBtn_onButtonClick' call CLib_fnc_localEvent;";
        };

        class PromoteBtn : PRA3_RscButtonMenu {
            idc = 213;
            text = "PROMOTE";
            x = PX(GWIDTH-22);
            y = PY(43.5);
            w = PX(9);
            h = PY(3);
            fade = 1;

            onButtonClick = "'PRA3_UI_RespawnScreen_PromoteBtn_onButtonClick' call CLib_fnc_localEvent;";
        };
        */
    };
};
