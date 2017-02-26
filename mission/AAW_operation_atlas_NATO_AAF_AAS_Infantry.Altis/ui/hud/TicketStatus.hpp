class AAW_UI_TicketStatus {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['AAW_UI_TicketStatus', _this select 0];";
    class Controls {

        class TicketsLeft : RscControlsGroupNoScrollbars {
            idc = 2010;
            x = 0.5 - PX(40);
            y = safeZoneY;
            w = PX(40);
            h = PY(5);
            class Controls {
                class TeamFlagBG : RscPicture {
                    idc = 2019;
                    text = "#(argb,8,8,3)color(0.0,0.4,0.8,1)";
                    x = PX(40-4);
                    y = PY(0.5);
                    w = PX(3.6);
                    h = PY(3.6);
                };

                class TeamFlag : RscPicture {
                    idc = 2011;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(40-4+0.5);
                    y = PY(0.5+0.5);
                    w = PX(2.6);
                    h = PY(2.6);
                };

                class TeamName : AAW_RscText {
                    idc = 2012;
                    text = "NATO";
                    style = ST_RIGHT;
                    x = PX(0);
                    y = PY(0.2);
                    w = PX(36);
                    h = PY(2.5);
                    sizeEx = PY(2.8);
                    font = "RobotoCondensedBold";
                    shadow = 1;
                };

                class Tickets : AAW_RscText {
                    idc = 2013;
                    text = "1234";
                    style = ST_RIGHT;
                    x = PX(0);
                    y = PY(2.4);
                    w = PX(36);
                    h = PY(2);
                    font = "RobotoCondensed";
                    shadow = 1;
                };

            };
        };

        class TicketsRight : RscControlsGroupNoScrollbars {
            idc = 2020;
            x = 0.5;
            y = safeZoneY;
            w = PX(40);
            h = PY(4);
            class Controls {
                class TeamFlagBG : RscPicture {
                    idc = 2029;
                    text = "#(argb,8,8,3)color(0.6,0.0,0.0,1)";
                    x = PX(0.5);
                    y = PY(0.5);
                    w = PX(3.6);
                    h = PY(3.6);
                };

                class TeamFlag : RscPicture {
                    idc = 2021;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(0.5+0.5);
                    y = PY(0.5+0.5);
                    w = PX(2.6);
                    h = PY(2.6);
                };

                class TeamName : AAW_RscText {
                    idc = 2022;
                    text = "NATO";
                    style = ST_LEFT;
                    x = PX(4);
                    y = PY(0.2);
                    w = PX(36);
                    h = PY(2.5);
                    sizeEx = PY(2.9);
                    font = "RobotoCondensedBold";
                    shadow = 1;
                };

                class Tickets : AAW_RscText {
                    idc = 2023;
                    text = "1234";
                    style = ST_Left;
                    x = PX(4);
                    y = PY(2.4);
                    w = PX(36);
                    h = PY(2);
                    font = "RobotoCondensed";
                    shadow = 1;
                };

            };
        };


        /*
        class CtrlGroup : RscControlsGroupNoScrollbars {
            idc = 2000;
            x = 0.5 - PX(25.5);
            y = PY(0.5) + safeZoneY;
            w = PX(42+2*4.5);
            h = PY(4.5);

            class Controls {
                class FlagImage0 : RscPicture {
                    idc = 2001;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(4);
                    h = PY(4);
                };
                class TicketValue0 : RscText {
                    idc = 2002;
                    text = "9999";
                    font = "PuristaBold";
                    sizeEx = PY(2.2);
                    shadow = 1;
                    colorBackground[] = {0,0,0,0};
                    colorText[] = {1,1,1,1};
                    x = PX(0);
                    y = PY(0);
                    w = PX(4);
                    h = PY(4);
                    style = ST_CENTER;
                };
                class FlagImage1 : FlagImage0 {
                    idc = 2003;
                    x = PX(42+4);
                };
                class TicketValue1 : TicketValue0 {
                    idc = 2004;
                    x = PX(42+4);
                };
            };
        };
        */
    };
};
