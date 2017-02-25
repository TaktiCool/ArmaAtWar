#undef GHEIGHT
#undef GWIDTH
#define GWIDTH 40
#define GHEIGHT 37

class AAW_UI_DeploymentManagement : RscControlsGroupNoScrollbars {
    idc = 400;
    x = safeZoneX + safeZoneW - PX(40);
    y = PY(71) + safeZoneY;
    w = PX(GWIDTH);
    h = PY(GHEIGHT);
    fade = 1;

    class Controls {
        class Background : RscPicture {
            idc = 499;
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            x = PX(0);
            y = PY(0);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);
        };
        class HeadingBackground : AAW_RscHeaderBackground {
            idc = 401;
            y = PY(0);
        };
        class Heading : AAW_H2Text {
            idc = 402;
            text = "DEPLOYMENT";
            x = PX(0.5);
            y = PY(0);
            w = PX(GWIDTH-1);
            h = PY(3);
        };
        class SpawnPointList : AAW_RscListNBox {
            idc = 403;
            x = PX(0);
            y = PY(4);
            w = PX(GWIDTH);
            h = PY(GHEIGHT-10);

            columns[] = {0,0.075,0.875};

            onLBSelChanged = "'AAW_UI_RespawnScreen_SpawnPointList_onLBSelChanged' call CLib_fnc_localEvent;";
        };
        class DeployButton : AAW_RscButtonMenu_Colored {
            idc = 404;
            text = "DEPLOY";
            sizeEx = PY(4);
            x = PX(0);
            y = PY(GHEIGHT - 6);
            w = PX(GWIDTH);
            h = PY(6);
            colorText[] = {0,0,0,1};
            action = "'AAW_UI_RespawnScreen_DeployButton_action' call CLib_fnc_localEvent;";
        };
    };
};
