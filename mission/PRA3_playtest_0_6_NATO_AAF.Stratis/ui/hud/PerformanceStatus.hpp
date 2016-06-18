#undef size
#define size 3.2
class PRA3_UI_PerformanceStatus {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['PRA3_UI_PerformanceStatus', _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScollbars {
            idc = 9090;
            x = safeZoneX + safeZoneW - PX(size+1);
            y = 0.5 - PY(size+5);
            w = PX(size);
            h = PY((size*2)+1);

            class Controls {
                class serverPerformance : RscPicture {
                    idc = 9091;
                    text = "ui\media\badServerFrames_ca.paa";
                    x = PX(0);
                    y = PY(0);
                    w = PX(size);
                    h = PY(size);
                };
                class clientPerformance : serverPerformance {
                    text = "ui\media\badClientFrames_ca.paa";
                    idc = 9092;
                    y = PY(size+1);
                };
            };
        };
    };
};
