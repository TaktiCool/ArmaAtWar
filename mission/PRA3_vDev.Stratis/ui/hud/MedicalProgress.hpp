class PRA3_UI_MedicalProgress {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable [""PRA3_UI_MedicalProgress"", _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScollbars {
            idc = 3000;
            x = 0.5 - PX(25);
            y = 1 - PY(10);
            w = PX(50);
            h = PY(10);

            class Controls {
                class BackgroundProgress : RscPicture {
                    idc = 3001;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(50);
                    h = PY(2);
                };

                class Progress : RscProgress {
                    idc = 3002;
                    colorFrame[] = {0,0,0,0};
                    colorBar[] = {1,0.4,0,1};
                    x = PX(0);
                    y = PY(0);
                    w = PX(50);
                    h = PY(2);
                };

                class Text : RscStructuredText {
                    idc = 3003;
                    shadow = 0;
                    x = PX(0);
                    y = PY(0);
                    w = PX(50);
                    h = PY(2);
                    text = "REVIVING in progress ...";
                    size = PY(1.8);
                    class Attributes
                    {
                        font = "PuristaMedium";
                        color = "#ffffff";
                        align = "center";
                        shadow = 0;
                    };
                };
                class HelpText : RscStructuredText {
                    idc = 3004;
                    shadow = 1;
                    x = PX(0);
                    y = PY(3);
                    w = PX(50);
                    h = PY(7);
                    text = "PRESS BLA BLA FOR";
                    size = PY(1.8);
                    class Attributes
                    {
                        font = "PuristaMedium";
                        color = "#ffffff";
                        align = "center";
                        shadow = 1;
                    };
                };


            };
        };
    };
};
