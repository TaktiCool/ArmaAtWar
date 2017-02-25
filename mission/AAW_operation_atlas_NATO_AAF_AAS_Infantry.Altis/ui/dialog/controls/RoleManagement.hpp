#undef GHEIGHT
#undef GWIDTH
#define GWIDTH 40
#define GHEIGHT 60.5

class AAW_UI_RoleManagement : RscControlsGroupNoScrollbars {
    idc = 300;
    x = safeZoneX + safeZoneW - PX(40);
    y = PY(10.5) + safeZoneY;
    w = PX(GWIDTH);
    h = PY(GHEIGHT);
    fade = 1;

    class Controls {
        class Background : RscPicture {
            idc = 399;
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            x = PX(0);
            y = PY(0);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);
        };
        class HeadingBackground : AAW_RscHeaderBackground {
            idc = 301;
            y = PY(0);
        };
        class Heading : AAW_H2Text {
            idc = 302;
            text = "ROLE";
            x = PX(0.5);
            y = PY(0);
            w = PX(GWIDTH-1);
            h = PY(3);
        };
        class RoleList : AAW_RscListNBox {
            idc = 303;
            x = PX(0);
            y = PY(4);
            w = PX(GWIDTH);
            h = PY(36);

            columns[] = {0,0.85};

            onLBSelChanged = "'AAW_UI_RespawnScreen_RoleList_onLBSelChanged' call CLib_fnc_localEvent;";
        };
        class WeaponTabs : RscToolbox {
            idc = 304;
            x = PX(0);
            y = PY(40);
            w = PX(GWIDTH);
            h = PY(2.5);

            colorBackground[] = {0.2, 0.2, 0.2, 0.8};
            colorSelectedBg[] = {0.1, 0.1, 0.1, 1};

            sizeEx = PY(2);
            rows = 1;
            columns = 3;
            strings[] = {"Primary", "Secondary", "Special"};

            onToolBoxSelChanged = "'AAW_UI_RespawnScreen_WeaponTabs_onToolBoxSelChanged' call CLib_fnc_localEvent;";
        };
        class WeaponBackground : RscPicture {
            idc = 305;
            text = "#(argb,8,8,3)color(0.1,0.1,0.1,1)";
            x = PX(0);
            y = PY(42.5);
            w = PX(GWIDTH);
            h = PY(GHEIGHT-42.5);
        };
        class WeaponPicture : RscPicture {
            idc = 306;
            text = "";
            style = ST_KEEP_ASPECT_RATIO + ST_PICTURE;
            x = PX(7);
            y = PY(44);
            w = PX(GWIDTH-14);
            h = PY(10);
        };
        class WeaponName : AAW_RscText {
            idc = 307;
            style = ST_CENTER;
            text = "";
            x = PX(0);
            y = PY(GHEIGHT-3);
            w = PX(GWIDTH);
            h = PY(3);
        };
    };
};
