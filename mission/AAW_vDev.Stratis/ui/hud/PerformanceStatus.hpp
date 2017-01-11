class AAW_UI_PerformanceStatus {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['AAW_UI_PerformanceStatus', _this select 0];";
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
            };
        };
    };
};
