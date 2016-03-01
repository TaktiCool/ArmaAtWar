#include "common\ui\defines.hpp"
#include "common\ui\baseclasses.hpp"


class BG_RscButtonMenu : RscButton {
	text = "";
	font = "PuristaMedium";
	style = ST_LEFT;
	sizeEx = PY(2);
	shadow = 0;
	colorBackground[] = {1,0.4,0,1};
	colorText[] = {1,1,1,1};
	x = PX(0);
	y = PY(0);
	w = PX(9);
	h = PY(3);
};

class BG_RscEdit : RscEdit {
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

class BG_H1Text : RscText {
    text = "";
    font = "PuristaSemiBold";
    sizeEx = PY(3);
    shadow = 0;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    x = PX(0);
    y = PY(0);
    w = PX(30);
    h = PY(4);
};

class BG_H2Text : BG_H1Text {
    font = "PuristaSemiBold";
    sizeEx = PY(2.5);
    h = PY(3);
};

class BG_RscText : RscText {
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

class BG_RscTextSmall : BG_RscText {
    sizeEx = PY(2);
};

#include "groups\RscDialogs.hpp"
#include "respawn\RscDialogs.hpp"
