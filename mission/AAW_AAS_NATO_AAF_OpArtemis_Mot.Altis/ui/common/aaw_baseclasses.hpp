
class AAW_RscButtonMenu : RscButton {
    text = "";
    font = "PuristaMedium";
    style = ST_LEFT;
    sizeEx = PY(1.8);
    shadow = 0;
    colorBackground[] = {0.3,0.3,0.3,0.8};
    colorBackgroundActive[] = {0.3,0.3,0.3,1};
    colorFocused[] = {0.3,0.3,0.3,1};
    colorText[] = {1,1,1,1};
    x = PX(0);
    y = PY(0);
    w = PX(9);
    h = PY(3);
    period = 0;
};

class AAW_RscButtonMenu_Colored : AAW_RscButtonMenu {
    colorBackground[] = {0.77, 0.51, 0.08, 0.8};
    colorBackgroundActive[] = {0.77, 0.51, 0.08, 1};
    colorFocused[] = {0.77, 0.51, 0.08, 0.8};
    colorText[] = {0,0,0,1};
};

class AAW_RscEdit : RscEdit {
    idc = 201;
    text = "";
    font = "PuristaMedium";
    style = ST_LEFT+ST_NO_RECT;
    sizeEx = PY(2);
    shadow = 0;
    colorBackground[] = {0.3,0.3,0.3,1};
    colorText[] = {1,1,1,1};
    x = PX(0);
    y = PY(0);
    w = PX(23);
    h = PY(3);
};

class AAW_H1Text : RscText {
    text = "";
    font = "PuristaMedium";
    sizeEx = PY(2.9);
    shadow = 0;
    colorBackground[] = {0,0,0,0};
    colorText[] = {0.77, 0.51, 0.08, 1};
    x = PX(0);
    y = PY(0);
    w = PX(30);
    h = PY(4);
};

class AAW_H2Text : AAW_H1Text {
    font = "PuristaBold";
    sizeEx = PY(2.5);
    h = PY(3);
};

class AAW_RscText : RscText {
    text = "";
    font = "PuristaMedium";
    sizeEx = PY(2);
    shadow = 0;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    x = PX(0);
    y = PY(0);
    w = PX(30);
    h = PY(3);
};

class AAW_RscTextSmall : AAW_RscText {
    sizeEx = PY(1.6);
};

class AAW_RscListNBox : RscListNBox {
    sizeEx = PY(2);
    rowHeight = PY(3);
    columns[] = {0};
    itemSpacing = PY(0.25);

    colorText[] = {0.8,0.8,0.8,1}; // Selected item color

    pictureColor[] = {0.8,0.8,0.8,1}; // Picture color
	pictureColorSelect[] = {1,1,1,1}; // Selected picture color


    colorSelectBackground[] = {0.3,0.3,0.3,1}; // Selected item fill color
	colorSelectBackground2[] = {0.3,0.3,0.3,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

    colorSelect[] = {1,1,1,1}; // Selected item color
	colorSelect2[] = {1,1,1,1}; // Selected item color (oscillates between this and colorSelectBackground)

};

class AAW_RscCombo : RscCombo {
    colorBackground[] = {0.3,0.3,0.3,1};
    sizeEx = PY(2);
};

class AAW_RscHeaderBackground : RscPicture {
    text = "#(argb,8,8,3)color(0,0,0,1)";
    x = PX(0);
    y = PY(0);
    w = PX(40);
    h = PY(3);
};
/*
class AAW_UI_DisableMouse_Dialog {
    idd = -1;
    movingEnable = false;
    onLoad = "uiNamespace setVariable ['AAW_UI_dlgDisableMouse',_this select 0];";
    objects[] = {};
    class controlsBackground {
        class Background {
            idc = -1;
            moving = 0;
            font = "TahomaB";
            text = "";
            sizeEx = 0;
            lineSpacing = 0;
            access = 0;
            type = 0;
            style = 0;
            size = 1;
            colorBackground[] = {0, 0, 0, 0};//0.5
            colorText[] = {0, 0, 0, 0};
            x = "safezoneX";
            y = "safezoneY";
            w = "safezoneW";
            h = "safezoneH";
        };
    };
};
*/
