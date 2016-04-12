
class PRA3_RscButtonMenu : RscButton {
    text = "";
    font = "PuristaMedium";
    style = ST_LEFT;
    sizeEx = PY(2);
    shadow = 0;
    colorBackground[] = {0.4,0.4,0.4,1};
    colorBackgroundActive[] = {0.4,0.4,0.4,1};
    colorFocused[] = {0.4,0.4,0.4,1};
    colorText[] = {1,1,1,1};
    x = PX(0);
    y = PY(0);
    w = PX(9);
    h = PY(3);
};

class PRA3_RscButtonMenu_Colored : RscButton {
    text = "";
    font = "PuristaMedium";
    style = ST_LEFT;
    sizeEx = PY(2);
    shadow = 0;
    colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
    colorBackgroundActive[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
    colorFocused[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
    colorText[] = {1,1,1,1};
    x = PX(0);
    y = PY(0);
    w = PX(9);
    h = PY(3);
    period = 0;
};

class PRA3_RscEdit : RscEdit {
    idc = 201;
    text = "";
    font = "PuristaMedium";
    style = ST_LEFT+ST_NO_RECT;
    sizeEx = PY(2);
    shadow = 0;
    colorBackground[] = {0.4,0.4,0.4,1};
    colorText[] = {1,1,1,1};
    x = PX(0);
    y = PY(0);
    w = PX(23);
    h = PY(3);
};

class PRA3_H1Text : RscText {
    text = "";
    font = "PuristaSemiBold";
    sizeEx = PY(2.9);
    shadow = 0;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    x = PX(0);
    y = PY(0);
    w = PX(30);
    h = PY(4);
};

class PRA3_H2Text : PRA3_H1Text {
    font = "PuristaSemiBold";
    sizeEx = PY(2.5);
    h = PY(3);
};

class PRA3_RscText : RscText {
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

class PRA3_RscTextSmall : PRA3_RscText {
    sizeEx = PY(2);
};

class PRA3_RscListNBox : RscListNBox {
    sizeEx = PY(2);
    rowHeight = PY(3);
    columns[] = {0};
    itemSpacing = PY(0.25);

    colorText[] = {0.8,0.8,0.8,1}; // Selected item color

    pictureColor[] = {0.8,0.8,0.8,1}; // Picture color
	pictureColorSelect[] = {1,1,1,1}; // Selected picture color


    colorSelectBackground[] = {0.4,0.4,0.4,1}; // Selected item fill color
	colorSelectBackground2[] = {0.4,0.4,0.4,1}; // Selected item fill color (oscillates between this and colorSelectBackground)

    colorSelect[] = {1,1,1,1}; // Selected item color
	colorSelect2[] = {1,1,1,1}; // Selected item color (oscillates between this and colorSelectBackground)

};

class PRA3_RscCombo : RscCombo {
    colorBackground[] = {0.4,0.4,0.4,1};
    sizeEx = PY(2);
};
/*
class PRA3_UI_DisableMouse_Dialog {
    idd = -1;
    movingEnable = false;
    onLoad = "uiNamespace setVariable ['PRA3_UI_dlgDisableMouse',_this select 0];";
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
