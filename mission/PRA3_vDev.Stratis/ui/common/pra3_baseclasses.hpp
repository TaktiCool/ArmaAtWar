
class PRA3_RscButtonMenu : RscButton {
    text = "";
    font = "PuristaMedium";
    style = ST_LEFT;
    sizeEx = PY(2);
    shadow = 0;
    colorBackground[] = {0.4,0.4,0.4,1};
    colorFocused[] = {1,0.4,0,1};
    colorText[] = {1,1,1,1};
    x = PX(0);
    y = PY(0);
    w = PX(9);
    h = PY(3);
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
