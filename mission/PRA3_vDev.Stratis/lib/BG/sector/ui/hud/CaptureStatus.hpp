class GVAR(CaptureStatus) {
    idd = -1;
    duration = 999999;
    onLoad = "uiNamespace setVariable [""BG_sector_CaptureStatus"", _this select 0];";
    class Controls {
        class CtrlGroup : RscControlsGroup {
            idc = 100;
            x = 0.5 - PX(20);
            y = safeZoneY + PY(0.5);
            w = PX(40);
            h = PY(4);

            class Controls {
                class Background : RscPicture {
                    text = "#(argb,8,8,3)color(0,0,0,0.8)";
                    x = PX(0);
                    y = PY(0);
                    w = PX(40);
                    h = PY(3.5);
                };
                class FlagImage : RscPicture {
                    idc = 101;
                    text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
                    x = PX(0.5);
                    y = PY(0.5);
                    w = PX(3);
                    h = PY(2);
                };
                class SectorDesignator : RscText {
                    idc = 102;
                    text = "X";
                    font = "PuristaBold";
                    sizeEx = PY(2.5);
                    shadow = 0;
                    colorBackground[] = {0,0,0,0};
                    colorText[] = {1,1,1,1};
                    x = PX(4);
                    y = PY(0.5);
                    w = PX(2);
                    h = PY(2);
                };
                class SectorName : RscText {
                    idc = 103;
                    text = "Sector Name";
                    font = "PuristaMedium";
                    sizeEx = PY(2.5);
                    shadow = 0;
                    colorBackground[] = {0,0,0,0};
                    colorText[] = {1,1,1,1};
                    x = PX(7);
                    y = PY(0.5);
                    w = PX(33);
                    h = PY(2);
                };

                class BackgroundProgress : RscText {
                    shadow = 0;
                    colorBackground[] = {"(profilenamespace getvariable ['Map_Unknown_R',0])","(profilenamespace getvariable ['Map_Unknown_G',1])","(profilenamespace getvariable ['Map_Unknown_B',1])","(profilenamespace getvariable ['Map_Unknown_A',0.8])"};
                    x = PX(0);
                    y = PY(3);
                    w = PX(40);
                    h = PY(0.6);
                };

                class Progress : RscProgress {
                    idc = 104;
                    colorFrame[] = {0,0,0,0};
                    colorBar[] = {"(profilenamespace getvariable ['Map_BLUFOR_R',0])","(profilenamespace getvariable ['Map_BLUFOR_G',1])","(profilenamespace getvariable ['Map_BLUFOR_B',1])","(profilenamespace getvariable ['Map_BLUFOR_A',0.8])"};                    x = PX(0);
                    y = PY(3);
                    w = PX(40);
                    h = PY(0.6);
                };
            };
        };
    };
};
