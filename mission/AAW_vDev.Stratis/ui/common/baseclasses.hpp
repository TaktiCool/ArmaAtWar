///////////////////////////////////////////////////////////////////////////
/// Base Classes
///////////////////////////////////////////////////////////////////////////

/*
 * HELPER
 */
class ScrollBar {
    arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
    arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
    autoScrollDelay = 5;
    autoScrollEnabled = 0;
    autoScrollRewind = 0;
    autoScrollSpeed = -1;
    border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
    color[] = {1,1,1,0.6};
    colorActive[] = COLOR_WHITE;
    colorDisabled[] = {1,1,1,0.3};
    height = 0;
    scrollSpeed = 0.06;
    shadow = 0;
    thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
    width = 0;
};

/*
 * BASE CONTROLS
 */
#define FONTCONTROL font = "PuristaMedium";\
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";\
    text = "";\
    colorText[] = COLOR_WHITE;\
    colorShadow[] = {0,0,0,0.5}

#define TOOLTIPCONTROL tooltipColorText[] = COLOR_WHITE;\
    tooltipColorBox[] = COLOR_WHITE;\
    tooltipColorShade[] = {0,0,0,0.65}

// ControlsGroup
class RscControlsGroup {
    type = CT_CONTROLS_GROUP;
    style = ST_MULTI;
    shadow = 0;

    x = 0;
    y = 0;
    w = 1;
    h = 1;

    class VScrollbar : ScrollBar {
        autoScrollEnabled = 1;
        width = 0.021;
    };
    class HScrollbar : ScrollBar {
        height = 0.028;
    };
    class Controls {};
};
class RscControlsGroupNoScrollbars : RscControlsGroup {
    class VScrollbar : Scrollbar {
        width = 0;
    };
    class HScrollbar : Scrollbar {
        height = 0;
    };
};

// Lists
class RscListBox
{
    type = CT_LISTBOX;
    style = ST_MULTI;
    shadow = 0;
    colorBackground[] = {0,0,0,0.3};

    FONTCONTROL;
    TOOLTIPCONTROL;

    colorDisabled[] = {1,1,1,0.25};
    colorScrollbar[] = {0.95,0.95,0.95,1};
    colorSelect[] = COLOR_BLACK;
    colorSelect2[] = COLOR_BLACK;
    colorSelectBackground[] = {0.95,0.95,0.95,1};
    colorSelectBackground2[] = {1,1,1,0.5};
    period = 1.2;
    maxHistoryDelay = 1.0;
    colorPicture[] = COLOR_WHITE;
    colorPictureSelected[] = COLOR_WHITE;
    colorPictureDisabled[] = COLOR_WHITE;
    soundSelect[] = {"\A3\ui_f\data\sound\RscListbox\soundSelect",0.09,1};
    class ListScrollBar: ScrollBar
    {
        color[] = COLOR_WHITE;
        autoScrollEnabled = 1;
    };
};
class RscListNBox : RscListBox
{
    idcLeft = -1;
    idcRight = -1;
    type = CT_LISTNBOX;
    style = ST_MULTI;

    color[] = {0.95,0.95,0.95,1};
    drawSideArrows = 0;
    class ListScrollBar: ScrollBar {};
    class ScrollBar: ScrollBar {};
};

// Texts
class RscText
{
    type = CT_STATIC;
    style = ST_LEFT;
    shadow = 1;
    colorBackground[] = COLOR_TRANSPARENT;

    x = 0;
    y = 0;
    h = 0.037;
    w = 0.3;

    FONTCONTROL;
    TOOLTIPCONTROL;

    lineSpacing = 1;
};
class RscStructuredText
{
    type = CT_STRUCTURED_TEXT;
    style = ST_LEFT;
    shadow = 1;

    x = 0;
    y = 0;
    h = 0.035;
    w = 0.1;

    colorText[] = COLOR_WHITE;
    class Attributes
    {
        font = "PuristaMedium";
        color = "#ffffff";
        align = "left";
        shadow = 1;
    };

    text = "";
    size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};


class RscPicture
{
    type = CT_STATIC;
    style = ST_PICTURE;
    shadow = 0;
    colorBackground[] = COLOR_TRANSPARENT;

    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;

    FONTCONTROL;
    TOOLTIPCONTROL;
};


class RscEdit
{
    type = CT_EDIT;
    style = ST_FRAME;
    shadow = 2;
    colorBackground[] = COLOR_BLACK;

    x = 0;
    y = 0;
    h = 0.04;
    w = 0.2;

    FONTCONTROL;
    TOOLTIPCONTROL;

    colorDisabled[] = {1,1,1,0.25};
    colorSelection[] = {
        "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
        "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
        1
    };
    autocomplete = "";
    canModify = 1;
};
class RscCombo
{
    type = CT_COMBO;
    style = ST_MULTI + ST_NO_RECT;
    shadow = 0;
    colorBackground[] = {0.4,0.4,0.4,1};

    x = 0;
    y = 0;
    w = 0.12;
    h = 0.035;

    FONTCONTROL;
    TOOLTIPCONTROL;

    colorSelect[] = COLOR_BLACK;
    colorScrollbar[] = {0.95,0.95,0.95,1};
    colorDisabled[] = {1,1,1,0.25};
    colorPicture[] = COLOR_WHITE;
    colorPictureSelected[] = COLOR_WHITE;
    colorPictureDisabled[] = {1,1,1,0.25};
    colorPictureRight[] = COLOR_WHITE;
    colorPictureRightSelected[] = COLOR_WHITE;
    colorPictureRightDisabled[] = {1,1,1,0.25};
    colorTextRight[] = COLOR_WHITE;
    colorSelectRight[] = COLOR_BLACK;
    colorSelect2Right[] = COLOR_BLACK;
    colorSelectBackground[] = {1,1,1,0.7};
    colorActive[] = {1,0,0,1};
    arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
    arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
    soundSelect[] = {"\A3\ui_f\data\sound\RscCombo\soundSelect",0.1,1};
    soundExpand[] = {"\A3\ui_f\data\sound\RscCombo\soundExpand",0.1,1};
    soundCollapse[] = {"\A3\ui_f\data\sound\RscCombo\soundCollapse",0.1,1};
    maxHistoryDelay = 1;
    wholeHeight = 0.45;
    class ComboScrollBar : ScrollBar {
        color[] = COLOR_WHITE;
    };
};

class RscButton
{
    type = CT_BUTTON;
    style = ST_CENTER;
    shadow = 2;
    colorBackground[] = {0,0,0,0.5};

    x = 0;
    y = 0;
    w = 0.095589;
    h = 0.039216;

    FONTCONTROL;

    colorDisabled[] = {1,1,1,0.25};
    colorBackgroundDisabled[] = {0,0,0,0.5};
    colorBackgroundActive[] = COLOR_BLACK;
    colorFocused[] = COLOR_BLACK;
    colorBorder[] = COLOR_BLACK;
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter",0.09,1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush",0.09,1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick",0.09,1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape",0.09,1};
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0;
    offsetPressedY = 0;
    borderSize = 0;
};

class RscMapControl {
    access = 0;
    alphaFadeEndScale = 2;
    alphaFadeStartScale = 2;
    colorBackground[] = {0.929412,0.929412,0.929412,1};
    colorCountlines[] = {0.647059,0.533333,0.286275,1};
    colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
    colorForest[] = {0.6,0.8,0.2,0.25};
    colorForestBorder[] = {0,0,0,0};
    colorGrid[] = {0.05,0.1,0,0.6};
    colorGridMap[] = {0.05,0.1,0,0.4};
    colorInactive[] = {1,1,1,0.5};
    colorLevels[] = {0,0,0,1};
    colorMainCountlines[] = {0.858824,0,0,1};
    colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
    colorMainRoads[] = {0,0,0,1};
    colorMainRoadsFill[] = {0.94,0.69,0.2,1};
    colorNames[] = {0.1,0.1,0.1,0.9};
    colorOutside[] = {0.929412,0.929412,0.929412,1};
    colorPowerLines[] = {0.1,0.1,0.1,1};
    colorRailWay[] = {0.8,0.2,0,1};
    colorRoads[] = {0.2,0.13,0,1};
    colorRoadsFill[] = {1,0.88,0.65,1};
    colorRocks[] = {0.5,0.5,0.5,0.5};
    colorRocksBorder[] = {0,0,0,0};
    colorSea[] = {0.467,0.631,0.851,0.5};
    colorText[] = {0,0,0,1};
    colorTracks[] = {0.2,0.13,0,1};
    colorTracksFill[] = {1,0.88,0.65,0.3};
    deletable = 0;
    fade = 0;
    font = "TahomaB";
    fontGrid = "TahomaB";
    fontInfo = "PuristaMedium";
    fontLabel = "PuristaMedium";
    fontLevel = "TahomaB";
    fontNames = "EtelkaNarrowMediumPro";
    fontUnits = "TahomaB";
    h = "SafeZoneH - 1.5 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    idc = 51;
    maxSatelliteAlpha = 0.5;
    moveOnEdges = 1;
    ptsPerSquareCLn = 10;
    ptsPerSquareCost = 10;
    ptsPerSquareExp = 10;
    ptsPerSquareFor = 9;
    ptsPerSquareForEdge = 9;
    ptsPerSquareObj = 9;
    ptsPerSquareRoad = 6;
    ptsPerSquareSea = 5;
    ptsPerSquareTxt = 20;
    scaleDefault = 0.16;
    scaleMax = 1;
    scaleMin = 0.001;
    shadow = 0;
    showCountourInterval = 1;
    sizeEx = 0.04;
    sizeExGrid = 0.032;
    sizeExInfo = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    sizeExLabel = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    sizeExLevel = 0.03;
    sizeExNames = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
    sizeExUnits = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    stickX[] = {0.2,["Gamma",1,1.5]};
    stickY[] = {0.2,["Gamma",1,1.5]};
    style = 48;
    text = "#(argb,8,8,3)color(1,1,1,1)";
    type = 101;
    w = "SafeZoneWAbs";
    x = "SafeZoneXAbs";
    y = "SafeZoneY + 1.5 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";

    class ActiveMarker {
        color[] = {0.3,0.1,0.9,1};
        size = 50;
    };

    class Bunker {
        coefMax = 4;
        coefMin = 0.25;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        importance = "1.5 * 14 * 0.05";
        size = 14;
    };

    class Bush {
        coefMax = 4;
        coefMin = 0.25;
        color[] = {0.45,0.64,0.33,0.4};
        icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
        importance = "0.2 * 14 * 0.05 * 0.05";
        size = "14/2";
    };

    class BusStop {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
        importance = 1;
        size = 24;
    };

    class Chapel {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
        importance = 1;
        size = 24;
    };

    class Church {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
        importance = 1;
        size = 24;
    };

    class Command {
        coefMax = 1;
        coefMin = 1;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
        importance = 1;
        size = 18;
    };

    class Cross {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
        importance = 1;
        size = 24;
    };

    class CustomMark {
        coefMax = 1;
        coefMin = 1;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
        importance = 1;
        size = 24;
    };

    class Fortress {
        coefMax = 4;
        coefMin = 0.25;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        importance = "2 * 16 * 0.05";
        size = 16;
    };

    class Fountain {
        coefMax = 4;
        coefMin = 0.25;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
        importance = "1 * 12 * 0.05";
        size = 11;
    };

    class Fuelstation {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
        importance = 1;
        size = 24;
    };

    class Hospital {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
        importance = 1;
        size = 24;
    };

    class Legend {
        color[] = {0,0,0,1};
        colorBackground[] = {1,1,1,0.5};
        font = "PuristaMedium";
        h = "3.5 *((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        w = "10 *(((safezoneW / safezoneH) min 1.2) / 40)";
        x = "SafeZoneX + (((safezoneW / safezoneH) min 1.2) / 40)";
        y = "SafeZoneY + safezoneH - 4.5 * ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
    };

    class Lighthouse {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
        importance = 1;
        size = 24;
    };

    class LineMarker {
        lineDistanceMin = 3e-005;
        lineLengthMin = 5;
        lineWidthThick = 0.014;
        lineWidthThin = 0.008;
        textureComboBoxColor = "#(argb, 8,8,3)color(1,1,1,1)";
    };

    class Power {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
        importance = 1;
        size = 24;
    };

    class PowerSolar {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
        importance = 1;
        size = 24;
    };

    class PowerWave {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
        importance = 1;
        size = 24;
    };

    class PowerWind {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
        importance = 1;
        size = 24;
    };

    class Quay {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
        importance = 1;
        size = 24;
    };

    class Rock {
        coefMax = 4;
        coefMin = 0.25;
        color[] = {0.1,0.1,0.1,0.8};
        icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
        importance = "0.5 * 12 * 0.05";
        size = 12;
    };

    class Ruin {
        coefMax = 4;
        coefMin = 1;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
        importance = "1.2 * 16 * 0.05";
        size = 16;
    };

    class Shipwreck {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
        importance = 1;
        size = 24;
    };

    class SmallTree {
        coefMax = 4;
        coefMin = 0.25;
        color[] = {0.45,0.64,0.33,0.4};
        icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
        importance = "0.6 * 12 * 0.05";
        size = 12;
    };

    class Stack {
        coefMax = 4;
        coefMin = 0.9;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
        importance = "2 * 16 * 0.05";
        size = 20;
    };

    class Task {
        coefMax = 1;
        coefMin = 1;
        color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
        colorCanceled[] = {0.7,0.7,0.7,1};
        colorCreated[] = {1,1,1,1};
        colorDone[] = {0.7,1,0.3,1};
        colorFailed[] = {1,0.3,0.2,1};
        icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
        iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
        iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
        iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
        iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
        importance = 1;
        size = 27;
    };

    class Tourism {
        coefMax = 4;
        coefMin = 0.7;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
        importance = "1 * 16 * 0.05";
        size = 16;
    };

    class Transmitter {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
        importance = 1;
        size = 24;
    };

    class Tree {
        coefMax = 4;
        coefMin = 0.25;
        color[] = {0.45,0.64,0.33,0.4};
        icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
        importance = "0.9 * 16 * 0.05";
        size = 12;
    };

    class ViewTower {
        coefMax = 4;
        coefMin = 0.5;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
        importance = "2.5 * 16 * 0.05";
        size = 16;
    };

    class WaterTower {
        coefMax = 1;
        coefMin = 0.85;
        color[] = {1,1,1,1};
        icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
        importance = 1;
        size = 24;
    };

    class Waypoint {
        coefMax = 1;
        coefMin = 1;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
        importance = 1;
        size = 24;
    };

    class WaypointCompleted {
        coefMax = 1;
        coefMin = 1;
        color[] = {0,0,0,1};
        icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
        importance = 1;
        size = 24;
    };
};

class RscProgress
{
    access = 0;
    colorBar[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
    colorFrame[] = {0,0,0,0};
    deletable = 0;
    fade = 0;
    h = 0.0261438;
    shadow = 2;
    style = 0;
    texture = "#(argb,8,8,3)color(1,1,1,1)";
    type = 8;
    w = 0.313726;
    x = 0.344;
    y = 0.619;
};

class RscToolbox {
    type = CT_TOOLBOX;
    style = ST_CENTER;

    color[] = {0, 0, 0, 1};    // seems nothing to change, but define it to avoid error!
    colorText[] = {0.8, 0.8, 0.8, 1};
    colorBackground[] = {0.4, 0.4, 0.4, 0.75};
    colorTextSelect[] = {1, 1, 1, 1};
    colorSelectedBg[] = {0.2, 0.2, 0.2, 1};
    colorSelect[] = {1, 1, 1, 1};
    colorTextDisable[] = {0.4, 0.4, 0.4, 1};
    colorDisable[] = {0.4, 0.4, 0.4, 1};

    font = "PuristaMedium";
    sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
};
