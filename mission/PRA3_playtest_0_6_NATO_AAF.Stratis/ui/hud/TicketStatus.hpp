class PRA3_UI_TicketStatus {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['PRA3_UI_TicketStatus', _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScollbars {
            idc = 2000;
            x = 0.5 - PX(25.5);
            y = PY(0.5) + safeZoneY;
            w = PX(42+2*4.5);
            h = PY(3);

            class Controls {
                class FlagImage0 : RscPicture {
                    idc = 2001;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(4.5);
                    h = PY(3);
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
                    w = PX(4.5);
                    h = PY(3);
                    style = ST_CENTER;
                };
                class FlagImage1 : FlagImage0 {
                    idc = 2003;
                    x = PX(42+4.5);
                };
                class TicketValue1 : TicketValue0 {
                    idc = 2004;
                    x = PX(42+4.5);
                };
            };
        };
    };
};
