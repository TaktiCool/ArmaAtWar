class AAW_UI_WelcomeScreen {
    idd = 2000;
    onLoad = "['AAW_UI_WelcomeScreen_onLoad', _this] call CLib_fnc_localEvent;";
    onUnload = "'AAW_UI_WelcomeScreen_onUnload' call CLib_fnc_localEvent;";

    class Controls {
        class Background : RscPicture {
            idc = 900;
            text = "#(argb,8,8,3)color(0,0,0,1)";
            x = safeZoneX;
            y = safeZoneY;
            w = safeZoneW;
            h = safeZoneH;
        };
        class Content : RscHTML {
            idc = 100;
            x = safeZoneX;
            y = safeZoneY;
            w = safeZoneW;
            h = safeZoneH - PY(6);
        };
        class CloseButton : AAW_RscButtonMenu_Colored {
            idc = 200;
            style = ST_CENTER;
            text = "CLOSE";
            sizeEx = PY(4);
            x = safeZoneX;
            y = safeZoneY + safeZoneH - PY(6);
            w = safeZoneW;
            h = PY(6);
            colorText[] = {0,0,0,1};
            action = "'AAW_UI_WelcomeScreen_CloseButton_action' call CLib_fnc_localEvent;";
        };
    };
};
