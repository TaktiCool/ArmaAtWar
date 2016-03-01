class BG_SquadList_Entry : RscControlsGroup {
    idc = 1100;
    x = PX(1);
    y = PY(0);
    w = PX(33);
    h = PY(3);

    class HScrollbar {
        width = 0;
        height = 0;
    };

    class VScrollbar {
        width = 0;
        height = 0;
    };

    class Controls {
        class Background : RscPicture {
            text = "#(argb,8,8,3)color(0.275,0.275,0.275,0.8)";
            x = PX(0);
            y = PY(0);
            w = PX(33);
            h = PY(3);
        };

        class SquadSymbol : RscPicture {
            idc = 1101;
            text = "#(argb,8,8,3)color(0.5,0.5,0.5,1)";
            x = PX(1);
            y = PY(1);
            w = PX(1.5);
            h = PY(1);
        };

        class SquadName : BG_RscText {
            idc = 1102;
            text = "Squad";
            x = PX(3);
            y = PY(0);
            w = PX(6);
            h = PY(3);
        };

        class SquadDescription : BG_RscTextSmall {
            idc = 1103;
            text = "Description";
            colorText[] = {0.8,0.8,0.8,1};
            x = PX(10);
            y = PY(0);
            w = PX(18);
            h = PY(3);
        };

        class Quantity : BG_RscText {
            idc = 1104;
            text = "9/9";
            colorText[] = {0.8,0.8,0.8,1};
            x = PX(28);
            y = PY(0);
            w = PX(5);
            h = PY(3);
        };
    };
};

class BG_SquadList : RscControlsGroup {
    idc = 1000;
    x = 0;
    y = safeZoneY + PY(14);
    w = PX(35);
    h = PY(28);

    class Controls {

        #define ENTRY_SPACING 3.5
        class entry_1 : BG_SquadList_Entry {
            idc = 1100;
            y = PY(0);
        };

        class entry_2 : BG_SquadList_Entry {
            idc = 1200;
            y = PY(ENTRY_SPACING*1);
        };

        class entry_3 : BG_SquadList_Entry {
            idc = 1300;
            y = PY(ENTRY_SPACING*2);
        };

        class entry_4 : BG_SquadList_Entry {
            idc = 1400;
            y = PY(ENTRY_SPACING*3);
        };

        class entry_5 : BG_SquadList_Entry {
            idc = 1500;
            y = PY(ENTRY_SPACING*4);
        };

        class entry_6 : BG_SquadList_Entry {
            idc = 1600;
            y = PY(ENTRY_SPACING*5);
        };

        class entry_7 : BG_SquadList_Entry {
            idc = 1700;
            y = PY(ENTRY_SPACING*6);
        };

        class entry_8 : BG_SquadList_Entry {
            idc = 1800;
            y = PY(ENTRY_SPACING*7);
        };
    };
};

#include "ui\dialog\RespawnScreen.hpp"
