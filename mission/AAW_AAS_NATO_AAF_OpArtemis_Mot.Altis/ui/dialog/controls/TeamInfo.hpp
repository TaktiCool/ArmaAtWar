#define GWIDTH 40
#define GHEIGHT 4.5

class AAW_UI_TeamInfo : RscControlsGroupNoScrollbars {
    idc = 100;
    x = safeZoneX;
    y = PY(6) + safeZoneY;
    w = PX(GWIDTH);
    h = PY(GHEIGHT);
    fade = 1;
    class Controls {
        class Background : RscPicture {
            idc = 199;
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            x = PX(0);
            y = PY(0);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);
        };
        class TeamFlagBG : RscPicture {
            idc = 198;
            text = "#(argb,8,8,3)color(0.0,0.4,0.8,1)";
            x = PX(1);
            y = PY(0);
            w = PX(3.6);
            h = PY(3.6);
        };
        class TeamFlag : RscPicture {
            idc = 102;
            text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
            x = PX(1+0.5);
            y = PY(0+0.5);
            w = PX(2.6);
            h = PY(2.6);
        };
        class TeamName : AAW_H1Text {
            idc = 103;
            text = "US ARMY";
            x = PX(5);
            y = PY(0);
            w = PX(GWIDTH-12);
            h = PY(GHEIGHT-1);
            colorText[] = {1,1,1,1};
            font = "PuristaBold";
        };
        class ChangeSideBtn : AAW_RscButtonMenu {
            idc = 104;
            text = "CHANGE";
            x = PX(GWIDTH-9);
            y = PY(0.3);
            w = PX(8);
            h = PY(3);
            onButtonClick = "'AAW_UI_RespawnScreen_ChangeSideBtn_onButtonClick' call CLib_fnc_localEvent;";
        };
    };
};
