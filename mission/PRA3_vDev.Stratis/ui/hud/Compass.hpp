#define LINE(var) \
class Line##var : Line01 {\
    idc = 70##var##;\
};

#define BEARING(var) \
class Bearing##var : Bearing01 {\
    idc = 71##var##;\
};

class PRA3_UI_Compass {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['PRA3_UI_Compass', _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScollbars {
            idc = 7000;
            x = 0.5 - PX(46.25);
            y = PY(101) + safeZoneY;
            w = PX(92.5);
            h = PY(4);

            class Controls {
                class Line01 : RscText {
                    idc = 7001;
                    //text = "#(argb,8,8,3)color(1,1,1,1)";
                    colorBackground[] = {1,1,1,1};
                    x = PX(0);
                    y = PY(1);
                    w = PX(2.2);
                    h = PY(0.3);
                };
                LINE(02)
                LINE(03)
                LINE(04)
                LINE(05)
                LINE(06)
                LINE(07)
                LINE(08)
                LINE(09)
                LINE(10)
                LINE(11)
                LINE(12)
                LINE(13)
                LINE(14)
                LINE(15)
                LINE(16)
                LINE(17)
                LINE(18)
                LINE(19)
                LINE(20)
                LINE(21)
                LINE(22)
                LINE(23)
                LINE(24)
                LINE(25)
                LINE(26)
                LINE(27)
                LINE(28)
                LINE(29)
                LINE(30)
                LINE(31)
                LINE(32)
                LINE(33)
                LINE(34)
                LINE(35)
                LINE(36)
                LINE(37)
                LINE(38)
                class Bearing01 : PRA3_RscText {
                    idc = 7101;
                    text = "000";
                    style = ST_CENTER;
                    x = PX(0);
                    y = PY(2);
                    w = PX(3);
                    h = PY(1.5);
                };
                BEARING(02)
                BEARING(03)
                BEARING(04)
                BEARING(05)
                BEARING(06)
                BEARING(07)
                BEARING(08)
                BEARING(09)
                BEARING(10)
                BEARING(11)
                BEARING(12)
                BEARING(13)
                BEARING(14)
                class Needle : RscPicture {
                    idc = 7201;
                    text = "ui\media\fob_ca.paa";
                    angle = 180;
                    x = PX(46.25) - PX(1);
                    y = PY(1);
                    w = PX(2);
                    h = PY(1);
                };
            };
        };
    };
};
