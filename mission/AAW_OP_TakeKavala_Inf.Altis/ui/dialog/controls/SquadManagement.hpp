#undef GHEIGHT
#undef GWIDTH
#define GWIDTH 40
#define GHEIGHT 97.5

class AAW_UI_SquadManagement : RscControlsGroupNoScrollbars {
    idc = 200;
    x = safeZoneX;
    y = PY(10.5) + safeZoneY;
    w = PX(GWIDTH);
    h = PY(GHEIGHT);
    fade = 1;

    class Controls {
        class Background : RscPicture {
            idc = 299;
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
            x = PX(0);
            y = PY(0);
            w = PX(GWIDTH);
            h = PY(GHEIGHT);
        };
        class HeadingBackground : AAW_RscHeaderBackground {
            idc = 201;
            y = PY(0);
        };
        class Heading : AAW_H2Text {
            idc = 202;
            text = "SQUAD";
            x = PX(0.5);
            y = PY(0);
            w = PX(GWIDTH-1);
            h = PY(3);
        };

        class NewSquadDesignator : AAW_RscText {
            idc = 203;
            text = "";
            x = PX(0.5);
            y = PY(4);
            w = PX(2.5);
            h = PY(3);
        };

        class NewSquadDescriptionInput : AAW_RscEdit {
            idc = 204;
            x = PX(3.5);
            y = PY(4);
            w = PX(GWIDTH-23);
            h = PY(3);
            onChar = "'AAW_UI_RespawnScreen_SquadDescriptionInput_TextChanged' call CLib_fnc_localEvent;";
        };

        class SquadTypeCombo : AAW_RscCombo {
            idc = 205;
            x = PX(GWIDTH-19.5);
            y = PY(4);
            w = PX(10);
            h = PY(3);
        };

        class CreateSquadBtn : AAW_RscButtonMenu {
            idc = 206;
            text = "CREATE";
            x = PX(GWIDTH-9);
            y = PY(4);
            w = PX(8);
            h = PY(3);

            onButtonClick = "'AAW_UI_RespawnScreen_CreateSquadBtn_onButtonClick' call CLib_fnc_localEvent;";
        };

        class SquadList : AAW_RscListNBox {
            idc = 207;
            x = PX(0);
            y = PY(8);
            w = PX(GWIDTH);
            h = PY(43.5-8);

            columns[] = {0,0.075,0.5,0.85};

            onLBSelChanged = "'AAW_UI_RespawnScreen_SquadList_onLBSelChanged' call CLib_fnc_localEvent;";
        };

        class BackgroundSquadDetails : RscPicture {
            idc = 208;
            text = "#(argb,8,8,3)color(0.1,0.1,0.1,1)";
            x = PX(0);
            y = PY(43.5);
            w = PX(GWIDTH);
            h = PY(54);
        };

        class HeadingSquadDetails : AAW_H2Text {
            idc = 209;
            text = "";
            x = PX(0.5);
            y = PY(43.5);
            w = PX(GWIDTH-22);
            h = PY(3);
        };

        class SquadMemberList : AAW_RscListNBox {
            idc = 210;
            x = PX(0);
            y = PY(48);
            w = PX(GWIDTH);
            h = PY(37.5);

            columns[] = {0};

            onLBSelChanged = "'AAW_UI_RespawnScreen_SquadMemberList_onLBSelChanged' call CLib_fnc_localEvent;";
        };

        class JoinLeaveBtn : AAW_RscButtonMenu {
            idc = 211;
            text = "JOIN";
            x = PX(GWIDTH-6);
            y = PY(43.5);
            w = PX(6);
            h = PY(3);

            onButtonClick = "'AAW_UI_RespawnScreen_JoinLeaveBtn_onButtonClick' call CLib_fnc_localEvent;";
        };

        class KickBtn : AAW_RscButtonMenu {
            idc = 212;
            text = "KICK";
            x = PX(GWIDTH-12.5);
            y = PY(43.5);
            w = PX(6);
            h = PY(3);

            onButtonClick = "'AAW_UI_RespawnScreen_KickBtn_onButtonClick' call CLib_fnc_localEvent;";
        };

        class PromoteBtn : AAW_RscButtonMenu {
            idc = 213;
            text = "PROMOTE";
            x = PX(GWIDTH-22);
            y = PY(43.5);
            w = PX(9);
            h = PY(3);

            onButtonClick = "'AAW_UI_RespawnScreen_PromoteBtn_onButtonClick' call CLib_fnc_localEvent;";
        };
    };
};
