#undef GHEIGHT
#undef GWIDTH
#define GWIDTH 40
#define GHEIGHT 4

class PRA3_UI_TeamInfo : RscControlsGroupNoScollbars {
    idc = 100;
    x = safeZoneX;
    y = safeZoneY;
    w = PX(GWIDTH);
    h = PY(GHEIGHT);
    fade = 1;
    class Controls {
        class TeamFlag : RscPicture {
            idc = 102;
            text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
            x = PX(0.5);
            y = PY(0.75);
            w = PX(3);
            h = PY(3);
        };

        class TeamName : PRA3_H1Text {
            idc = 103;
            text = "US ARMY";
            x = PX(4);
            y = PY(0.25);
            w = PX(GWIDTH-12);
            h = PY(GHEIGHT-0.5);
            colorText[] = {1,1,1,1};
            font = "PuristaBold";
        };

        class ChangeSideBtn : PRA3_RscButtonMenu {
            idc = 104;
            text = "CHANGE";
            x = PX(GWIDTH-9);
            y = PY(0.75);
            w = PX(8);
            h = PY(3);

            onButtonClick = "'PRA3_UI_RespawnScreen_ChangeSideBtn_onButtonClick' call PRA3_Core_fnc_localEvent;";
        };
    };
};
