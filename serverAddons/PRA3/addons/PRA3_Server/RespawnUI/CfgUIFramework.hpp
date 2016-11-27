#define C_BG_L 0.2,0.2,0.2,0.4
#define C_BG_D 0.2,0.2,0.2,0.7
#define C_BGSELECTED_L 0.2,0.2,0.2,1
#define C_BGSELECTED_D 1,1,1,1

#define C_TEXT_L 1,1,1,1

#define C_FRIENDLY 0.18,0.5,0.93,1
#define C_GROUP 0.13,0.54,0.21,1


class RespawnUIHeader {
    class Background : RscPicture {
        x = 0;
        y = 0;
        w = safeZoneW;
        h = PY(10);
        text = "#(argb,8,8,3)color(0.2,0.2,0.2,0.7)";
    };

    class BackgroundFlag : RscPicture {
        x = PX(4);
        y = PY(3);
        w = PX(4);
        h = PY(4);
        text = "#(argb,8,8,3)color(0.18,0.5,0.93,1)";
    };

    class Flag : RscPicture {
        uiNamespaceVariable = UIVAR(CurrentFactionFlag);
        x = PX(4.5);
        y = PY(3.5);
        w = PX(3);
        h = PY(3);
        text = "a3\data_f\cfgfactionclasses_blu_ca.paa";
    };

    class FactionName : RscTitle {
        uiNamespaceVariable = UIVAR(CurrentFactionName);
        x = PX(9);
        y = PY(3.5);
        w = PX(12);
        h = PY(3);
        text = "NATO";
        font = "RobotoCondensedLight";
        sizeEx = PY(2.4)*1.3;
        color[] = {1,1,1,1};
    };

    class MissionName : RscStructuredText {
        uiNamespaceVariable = UIVAR(MissionName);
        x = safeZoneW - PX(64);
        y = PY(2.6);
        w = PX(60);
        h = PY(2.9);
        text = "<t align='left'>OPERATION SPARTAN SHIELD</t>";
        font = "RobotoCondensedLight";
        color[] = {1,1,1,1};
    };

    class MissionType : RscStructuredText {
        uiNamespaceVariable = UIVAR(MissionType);
        x = safeZoneW - PX(64);
        y = PY(5.6);
        w = PX(60);
        h = PY(1.9);
        text = "<t align='left'>Advance & Secure</t>";
        font = "RobotoCondensed";
        color[] = {1,1,1,1};
    };
};

class RespawnUISquadHeader {
    class Background : RscPicture {
        uiNamespaceVariable = UIVAR(SquadHeaderBackground);
        x = 0;
        y = 0;
        w = PX(35);
        h = PY(4);
        text = "#(argb,8,8,3)color(0.13,0.54,0.21,1)";
    };

    class Text : RscStructuredText {
        uiNamespaceVariable = UIVAR(SquadHeaderText);
        x = PX(4);
        y = PY(1);
        w = PX(27);
        h = PY(1.9);
        font = "RobotoCondensedBold";
        color[] = {1,1,1,1};
    };

    class TextSecondary : Text {
        uiNamespaceVariable = UIVAR(SquadHeaderTextSecondary);
        font = "RobotoCondensedBold";
    };
};
