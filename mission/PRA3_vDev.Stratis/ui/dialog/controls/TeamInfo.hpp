class PRA3_UI_TeamInfo : RscControlsGroupNoScrollbars {
    idc = 100;
    x = safeZoneX;
    y = safeZoneY;
    w = safeZoneW;
    h = PY(10);

    class Controls {

        class BackgroundTop : BgDarkTransparent {
            idc = 199;
            x = 0;
            y = 0;
            w = safeZoneW;
            h = PY(10);
        };


        class BackgroundFlag : RscPicture {
            idc = -1;
            x = PX(4);
            y = PY(3);
            w = PX(4);
            h = PY(4);
            text = "#(argb,8,8,3)color(0.18,0.5,0.93,1)";
        };

        class Flag : RscPicture {
            idc = 102;
            x = PX(4.5);
            y = PY(3.5);
            w = PX(3);
            h = PY(3);
            text = "a3\data_f\cfgfactionclasses_blu_ca.paa";
        };

        class FactionName : TxtLarge {
            idc = 103;
            x = PX(9);
            y = PY(3.5);
            w = PX(12);
            text = "NATO";
        };
        class BtnChangeSite : BtnWhite {
            idc = 104;
            x = PX(27);
            y = PY(3);
            text = "CHANGE SIDE";
            onButtonClick = "'PRA3_UI_RespawnScreen_ChangeSideBtn_onButtonClick' call CLib_fnc_localEvent;";
        };
    };
};
