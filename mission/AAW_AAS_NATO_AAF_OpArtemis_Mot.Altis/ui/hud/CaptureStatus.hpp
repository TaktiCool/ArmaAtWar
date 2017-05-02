class AAW_UI_CaptureStatus {
    idd = -1;
    duration = 1e11;
    onLoad = "uiNamespace setVariable ['AAW_UI_CaptureStatus', _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroupNoScrollbars {
            idc = 1000;
            x = 0.5 - PX(20);
            y = PY(0.5) + safeZoneY;
            w = PX(40);
            h = PY(4);

            class Controls {

                class Background : RscPicture {
                    idc = 1999;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(40);
                    h = PY(3.6);
                };

                class BackgroundFlag : RscPicture {
                    idc = 1997;
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(3.6);
                    h = PY(3.6);
                };

                class FlagImage : RscPicture {
                    idc = 1001;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(0.5);
                    y = PY(0.5);
                    w = PX(2.6);
                    h = PY(2.6);
                };
                /*
                class SectorDesignator : RscText {
                    idc = 1002;
                    text = "X";
                    font = "PuristaBold";
                    sizeEx = PY(2.5);
                    shadow = 0;
                    colorBackground[] = {0,0,0,0};
                    colorText[] = {1,1,1,1};
                    x = PX(4);
                    y = PY(0.1);
                    w = PX(2);
                    h = PY(2);
                };

                class SectorName : RscText {
                    idc = 1003;
                    text = "Sector Name";
                    font = "PuristaMedium";
                    sizeEx = PY(2.5);
                    shadow = 0;
                    colorBackground[] = {0,0,0,0};
                    colorText[] = {1,1,1,1};
                    x = PX(7);
                    y = PY(0.1);
                    w = PX(33);
                    h = PY(2.5);
                };
                */

                class BackgroundProgress : RscPicture {
                    idc = 1998;
                    text = "#(argb,8,8,3)color(0.93,0.7,0.01,1)";
                    x = PX(3.6);
                    y = PY(3.1);
                    w = PX(40-3.6);
                    h = PY(0.5);
                };

                class Progress : RscProgress {
                    idc = 1004;
                    colorFrame[] = {0,0,0,0};
                    colorBar[] = {"(profilenamespace getvariable ['Map_BLUFOR_R',0])","(profilenamespace getvariable ['Map_BLUFOR_G',1])","(profilenamespace getvariable ['Map_BLUFOR_B',1])","(profilenamespace getvariable ['Map_BLUFOR_A',0.8])"};
                    x = PX(3.6);
                    y = PY(3.1);
                    w = PX(40-3.6);
                    h = PY(0.5);
                };

                class SectorDescription : RscStructuredText {
                    idc = 1002;
                    shadow = 0;
                    x = PX(0);
                    y = PY(0.3);
                    w = PX(40);
                    h = PY(3);
                    text = "TEST";
                    size = PY(2.5);
                    class Attributes
                    {
                        font = "RobotoCondensed";
                        color = "#ffffff";
                        align = "center";
                        shadow = 1;
                    };
                };


            };
        };
    };
};
