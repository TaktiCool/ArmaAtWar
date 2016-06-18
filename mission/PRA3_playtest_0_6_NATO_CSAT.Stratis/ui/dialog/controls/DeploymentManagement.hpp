#undef GHEIGHT
#undef GWIDTH
#define GWIDTH 40
#define GHEIGHT 27.5


class PRA3_UI_DeploymentManagement : RscControlsGroupNoScollbars {
    idc = 400;
    x = safeZoneX + safeZoneW - PX(40);
    y = safeZoneY;
    w = PX(GWIDTH);
    h = PY(GHEIGHT);

    fade = 1;

    class Controls {
        class HeadingBackground : PRA3_RscHeaderBackground {
            idc = 401;
            y = PY(0);
        };

        class Heading : PRA3_H2Text {
            idc = 402;
            text = "DEPLOYMENT";
            x = PX(0.5);
            y = PY(0);
            w = PX(GWIDTH-1);
            h = PY(3);
        };

        class SpawnPointList : PRA3_RscListNBox {
            idc = 403;
            x = PX(0);
            y = PY(4);
            w = PX(GWIDTH);
            h = PY(GHEIGHT-10);

            columns[] = {0,0.075,0.875};

            onLBSelChanged = "'PRA3_UI_RespawnScreen_SpawnPointList_onLBSelChanged' call PRA3_Core_fnc_localEvent;";
        };
    };
};
