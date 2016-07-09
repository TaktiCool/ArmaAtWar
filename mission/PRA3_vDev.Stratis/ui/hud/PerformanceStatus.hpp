#define BAR(var) \
class Bar##var : Bar1 {\
    idc = 9101 + var;\
    x = PX(3 + (0.2 * (var - 1)));\
};

class PRA3_UI_PerformanceStatus {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['PRA3_UI_PerformanceStatus', _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScrollbars {
            idc = 9000;
            x = safeZoneX + safeZoneW - PX(12);
            y = 0.5 - PY(5);
            w = PX(11);
            h = PY(13.4);

            class Controls {
                class ServerPerformanceIndicator : RscPicture {
                    idc = 9001;
                    text = "ui\media\badServerFrames_ca.paa";
                    x = PX(11 - 3.2);
                    y = PY(0);
                    w = PX(3.2);
                    h = PY(3.2);
                };
                class ClientPerformanceIndicator : ServerPerformanceIndicator {
                    text = "ui\media\badClientFrames_ca.paa";
                    idc = 9002;
                    y = PY(3.2 + 1);
                };

                class FrameChartGroup : RscControlsGroupNoScrollbars {
                    idc = 9100;
                    x = PX(0);
                    y = PY((3.2 + 1) * 2);
                    w = PX(11);
                    h = PY(5);

                    class Controls {
                        class FPSText : PRA3_RscText {
                            idc = 9101;
                            style = ST_RIGHT;
                            x = PX(0);
                            y = PY(0);
                            w = PX(3);
                            h = PY(1.5);
                        };

                        class Bar1 : RscPicture {
                            idc = 9102;
                            x = PX(3);
                            y = PY(0);
                            w = PX(0.2);
                            h = PY(5);
                        };
                        BAR(2)
                        BAR(3)
                        BAR(4)
                        BAR(5)
                        BAR(6)
                        BAR(7)
                        BAR(8)
                        BAR(9)
                        BAR(10)
                        BAR(11)
                        BAR(12)
                        BAR(13)
                        BAR(14)
                        BAR(15)
                        BAR(16)
                        BAR(17)
                        BAR(18)
                        BAR(19)
                        BAR(20)
                        BAR(21)
                        BAR(22)
                        BAR(23)
                        BAR(24)
                        BAR(25)
                        BAR(26)
                        BAR(27)
                        BAR(28)
                        BAR(29)
                        BAR(30)
                        BAR(31)
                        BAR(32)
                        BAR(33)
                        BAR(34)
                        BAR(35)
                        BAR(36)
                        BAR(37)
                        BAR(38)
                        BAR(39)
                        BAR(40)
                    };
                };
            };
        };
    };
};
