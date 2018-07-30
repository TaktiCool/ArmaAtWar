#define MODULE RespawnUI
#include "\tc\AAW\addons\AAW_Server\macros.hpp"

#define XOR(A, B) (!(A && B) && {A || B})

#define GUI_INIT(DISP) private _gui_lastGroup = controlNull;\
private _gui_lastPositionState = [0, 0, 0, 0]; \
private _gui_lastCtrl = controlNull; \
private _gui_display = DISP; \
private _gui_tempData = []; \
private _gui_grpStack = [controlNull]; \

#define GUI_PUSHGRP(GRP) (_gui_grpStack pushBack GRP)

#define GUI_POPGRP (_gui_grpStack deleteAt (count _gui_grpStack - 1))
#define GUI_LASTGRP (_gui_grpStack select ((count _gui_grpStack - 1)))

#define GUI_LASTX (_gui_lastPositionState select 0)
#define GUI_LASTY (_gui_lastPositionState select 1)
#define GUI_LASTW (_gui_lastPositionState select 2)
#define GUI_LASTH (_gui_lastPositionState select 3)
#define GUI_LASTCTRL _gui_lastCtrl


#define GUI_BELOW (GUI_LASTY + GUI_LASTH)
#define GUI_RIGHT (GUI_LASTX + GUI_LASTW)

#define GUI_COLOR_ARRAY(R,G,B,A) ([R,G,B,A])

#define GUI_COLOR_TEXTURE(R,G,B,A) QUOTE(#(argb,8,8,3)color(R,G,B,A))

#define GUI_CURRENTDISPLAY(VAR) _gui_display = VAR

#define GUI_POSITION(X,Y,W,H) GUI_LASTCTRL ctrlSetPosition [X,Y,W,H]; \
_gui_lastPositionState = [X, Y, W, H]; \

#define GUI_POSITION_CENTERED(X,Y,W,H) GUI_POSITION(X - (W)/2,Y - (H)/2,W,H);

#define GUI_COMMIT(T) GUI_LASTCTRL ctrlCommit (T)

#define GUI_NEWCTRL(TYPE) (call { \
    _gui_lastCtrl = _gui_display ctrlCreate [TYPE, -1, GUI_LASTGRP];\
    _gui_lastCtrl \
}) \

#define GUI_NEWGROUP(X,Y,W,H) (_gui_grpStack select GUI_PUSHGRP(GUI_NEWCTRL("RscControlsGroupNoScrollbars"))); \
GUI_POSITION(X,Y,W,H); \

#define GUI_NEWGROUP_VSCROLL(X,Y,W,H) (_gui_grpStack select GUI_PUSHGRP(GUI_NEWCTRL("RscControlsGroupNoHScrollbars"))); \
GUI_POSITION(X,Y,W,H); \

#define GUI_NEWCTRL_TEXT_LEFT GUI_NEWCTRL("RscTitle")
#define GUI_NEWCTRL_TEXT_CENTERED GUI_NEWCTRL("RscTextNoShadow")

#define GUI_BACKGROUNDCOLOR(C) GUI_LASTCTRL ctrlSetBackgroundColor C;
#define GUI_TEXT(T) GUI_LASTCTRL ctrlSetText T;
#define GUI_TEXTURE(T) GUI_TEXT(T);

#define GUI_TEXTCOLOR(C) GUI_LASTCTRL ctrlSetTextColor C;
#define GUI_TEXTURECOLOR(C) GUI_TEXTCOLOR(C);

#define GUI_FONT(F) GUI_LASTCTRL ctrlSetFont F;
#define GUI_FONTHEIGHT(H) GUI_LASTCTRL ctrlSetFontHeight H;

#define GUI_FIX_MOUSEENTER GUI_LASTCTRL ctrlAddEventHandler ["MouseMoving", { \
    params ["_control", "_x", "_y", "_mouseOver"]; \
    private _lastMouseOver = _control getVariable ["GUI_LastMouseOver", false]; \
    if (XOR(_lastMouseOver, _mouseOver)) then { \
        _control setVariable ["GUI_LastMouseOver", _mouseOver]; \
        { \
            [_control] call _x; \
            nil \
        } count (_control getVariable [["MouseExitEH","MouseEnterEH"] select _mouseOver, []]); \
    }; \
}]; \



#define C_RGB_FRIENDLY 0.184,0.478,0.878
#define C_RGB_ENEMY 0,0,1
#define C_RGB_SQUAD 0.078,0.678,0.192
#define C_RGB_DARK 0.133,0.133,0.133
#define C_RGB_PANEL 0.267,0.267,0.267
#define C_RGB_SPECIAL 0.77,0.5,0.078

#define C_A_DARK [C_RGB_DARK, 0.8]
#define C_A_DARK_SOLID [C_RGB_DARK, 1]
#define C_A_PANEL [C_RGB_PANEL, 0.8]
#define C_A_SPECIAL [C_RGB_SPECIAL, 0.8]


#define C_A_BRIGHT_TEXT GUI_COLOR_ARRAY(1, 1, 1, 1)
#define C_A_DARK_TEXT GUI_COLOR_ARRAY(0, 0, 0, 1)
#define C_A_FRIENDLY [C_RGB_FRIENDLY,1]
#define C_A_ENEMY [C_RGB_ENEMY,1]
#define C_A_SQUAD [C_RGB_SQUAD,1]


#define F_F_DISPLAY_REGULAR "PuristaMedium"
#define F_F_DISPLAY_BOLD "PuristaBold"
#define F_F_NORMAL_REGULAR "RobotoCondensed"
#define F_F_NORMAL_BOLD "RobotoCondensedBold"
#define F_S_LARGE PY(1.3*2.8)
#define F_S_MEDIUM PY(1.3*1.8)
#define F_S_SMALL PY(1.3*1.4)

#define AAWUI_TEXTSTYLE_DISPLAY_BOLD_LARGE GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_FONT(F_F_DISPLAY_BOLD); \
GUI_FONTHEIGHT(F_S_LARGE); \

#define AAWUI_TEXTSTYLE_DISPLAY_REGULAR_LARGE GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_FONT(F_F_DISPLAY_REGULAR); \
GUI_FONTHEIGHT(F_S_LARGE); \

#define AAWUI_TEXTSTYLE_DISPLAY_BOLD_MEDIUM GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_FONT(F_F_DISPLAY_BOLD); \
GUI_FONTHEIGHT(F_S_MEDIUM); \

#define AAWUI_TEXTSTYLE_DISPLAY_REGULAR_MEDIUM GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_FONT(F_F_DISPLAY_REGULAR); \
GUI_FONTHEIGHT(F_S_MEDIUM); \

#define AAWUI_TEXTSTYLE_DISPLAY_BOLD_SMALL GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_FONT(F_F_DISPLAY_BOLD); \
GUI_FONTHEIGHT(F_S_SMALL); \

#define AAWUI_TEXTSTYLE_DISPLAY_REGULAR_SMALL GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_FONT(F_F_DISPLAY_REGULAR); \
GUI_FONTHEIGHT(F_S_SMALL); \

#define AAWUI_TEXTSTYLE_NORMAL_BOLD_LARGE GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_FONT(F_F_NORMAL_BOLD); \
GUI_FONTHEIGHT(F_S_LARGE); \

#define AAWUI_TEXTSTYLE_NORMAL_BOLD_SMALL GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_FONT(F_F_NORMAL_BOLD); \
GUI_FONTHEIGHT(F_S_SMALL); \

#define AAWUI_TEXTSTYLE_NORMAL_REGULAR_SMALL GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_FONT(F_F_NORMAL_REGULAR); \
GUI_FONTHEIGHT(F_S_SMALL); \

#define AAWUI_TEXTSTYLE_BUTTON GUI_FONT(F_F_DISPLAY_BOLD); \
GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \

#define AAWUI_TEXTSTYLE_UIHINT AAWUI_TEXTSTYLE_DISPLAY_BOLD_LARGE;

#define AAWUI_PANELBACKGROUND(X,Y,W,H) GUI_NEWCTRL("RscText"); \
GUI_BACKGROUNDCOLOR(C_A_PANEL); \
GUI_POSITION(X,Y,W,H); \

#define AAWUI_BUTTONBACKGROUND(X,Y,W,H) GUI_NEWCTRL("RscText"); \
GUI_BACKGROUNDCOLOR(C_A_DARK); \
GUI_POSITION(X,Y,W,H); \

#define AAWUI_FRIENDLYBACKGROUND(X,Y,W,H) GUI_NEWCTRL("RscText"); \
GUI_BACKGROUNDCOLOR(C_A_FRIENDLY); \
GUI_POSITION(X,Y,W,H); \

#define AAWUI_ENEMYBACKGROUND(X,Y,W,H) GUI_NEWCTRL("RscText"); \
GUI_BACKGROUNDCOLOR(C_A_ENEMY); \
GUI_POSITION(X,Y,W,H); \

#define AAWUI_SPECIALBACKGROUND(X,Y,W,H) GUI_NEWCTRL("RscText"); \
GUI_BACKGROUNDCOLOR(C_A_SPECIAL); \
GUI_POSITION(X,Y,W,H); \


#define AAWUI_TEXTBUTTON(T, S, X, Y, W, H) GUI_NEWGROUP(X,Y,W,H); \
GUI_FIX_MOUSEENTER; \
GUI_LASTCTRL setVariable ["MouseEnterEH", [{ \
params ["_ctrl"]; \
(_ctrl getVariable ["GUI_BACKGROUND", controlNull]) ctrlSetBackgroundColor C_A_DARK_SOLID; \
(_ctrl getVariable ["GUI_BACKGROUND", controlNull]) ctrlCommit 0.5; \
}]]; \
 \
GUI_LASTCTRL setVariable ["MouseExitEH", [{ \
params ["_ctrl"]; \
(_ctrl getVariable ["GUI_BACKGROUND", controlNull]) ctrlSetBackgroundColor C_A_DARK; \
(_ctrl getVariable ["GUI_BACKGROUND", controlNull]) ctrlCommit 0.5; \
}]]; \
_gui_tempData = AAWUI_BUTTONBACKGROUND(0,0,W,H); \
GUI_COMMIT(0); \
GUI_LASTGRP setVariable ["GUI_BACKGROUND", _gui_tempData]; \
_gui_tempData = GUI_NEWCTRL_TEXT_LEFT; AAWUI_TEXTSTYLE_BUTTON; \
GUI_LASTGRP setVariable ["GUI_TEXT", _gui_tempData]; \
GUI_POSITION(PX(1), 0, W-PX(1), H);\
GUI_FONTHEIGHT(S); \
GUI_TEXT(T); \
GUI_COMMIT(0); \
_gui_tempData = +[]; \
GUI_LASTCTRL = GUI_POPGRP; \


#define AAWUI_TEXTBUTTONLARGE(T, X, Y, W) AAWUI_TEXTBUTTON(T, F_S_LARGE, X, Y, W, PY(5));
#define AAWUI_TEXTBUTTONSMALL(T, X, Y, W) AAWUI_TEXTBUTTON(T, F_S_MEDIUM, X, Y, W, PY(3));

#define AAWUI_ICONBUTTON(I, WI, HI, X, Y, W, H) GUI_NEWGROUP(X,Y,W,H); \
GUI_FIX_MOUSEENTER; \
GUI_LASTCTRL setVariable ["MouseEnterEH", [{ \
params ["_ctrl"]; \
(_ctrl getVariable ["GUI_BACKGROUND", controlNull]) ctrlSetBackgroundColor C_A_DARK_SOLID; \
(_ctrl getVariable ["GUI_BACKGROUND", controlNull]) ctrlCommit 0.5; \
}]]; \
 \
GUI_LASTCTRL setVariable ["MouseExitEH", [{ \
params ["_ctrl"]; \
(_ctrl getVariable ["GUI_BACKGROUND", controlNull]) ctrlSetBackgroundColor C_A_DARK; \
(_ctrl getVariable ["GUI_BACKGROUND", controlNull]) ctrlCommit 0.5; \
}]]; \
_gui_tempData = AAWUI_BUTTONBACKGROUND(0,0,W,H); \
GUI_COMMIT(0); \
GUI_LASTGRP setVariable ["GUI_BACKGROUND", _gui_tempData]; \
_gui_tempData = GUI_NEWCTRL("RscPicture"); \
GUI_LASTGRP setVariable ["GUI_ICON", _gui_tempData]; \
GUI_POSITION_CENTERED((W)/2, (H)/2, WI, HI);\
GUI_TEXTURE(I); \
GUI_TEXTCOLOR(C_A_BRIGHT_TEXT); \
GUI_COMMIT(0); \
_gui_tempData = +[]; \
GUI_LASTCTRL = GUI_POPGRP; \

#define I_P_LEAVE "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\getout_ca.paa"
#define I_P_ENTER "\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\getin_ca.paa"
#define I_P_LOCK "\a3\modules_f\data\iconLock_ca.paa"
#define I_P_UNLOCK "\a3\modules_f\data\iconUnlock_ca.paa"
#define I_P_SETTINGS "\a3\modules_f\data\portraitModule_ca.paa"
#define I_P_PROMOTE "\a3\3den\Data\CfgWaypoints\unload_ca.paa"
#define I_P_CIRCLEFILLED "\a3\ui_f_curator\Data\CfgCurator\entity_selected_ca.paa"

#define AAWUI_ICONBUTTON_LEAVE(X, Y, W, H) AAWUI_ICONBUTTON(I_P_LEAVE, PX(2.4), PY(2.4), X, Y, W, H);
#define AAWUI_ICONBUTTON_ENTER(X, Y, W, H) AAWUI_ICONBUTTON(I_P_ENTER, PX(2.4), PY(2.4), X, Y, W, H);
#define AAWUI_ICONBUTTON_LOCK(X, Y, W, H) AAWUI_ICONBUTTON(I_P_LOCK, PX(2), PY(2), X, Y, W, H);
#define AAWUI_ICONBUTTON_UNLOCK(X, Y, W, H) AAWUI_ICONBUTTON(I_P_UNLOCK, PX(2), PY(1.8), X, Y, W, H);
#define AAWUI_ICONBUTTON_SETTINGS(X, Y, W, H) AAWUI_ICONBUTTON(I_P_SETTINGS, PX(2.4), PY(2.4), X, Y, W, H);
#define AAWUI_ICONBUTTON_PROMOTE(X, Y, W, H) AAWUI_ICONBUTTON(I_P_PROMOTE, PX(2.4), PY(2.4), X, Y, W, H);

#define AAWUI_SQUAD_DESIGNATOR(D, C, X, Y) _gui_tempData; \
_gui_tempData pushBack GUI_NEWCTRL("RscPicture"); \
GUI_POSITION_CENTERED(X+PX(1.5),Y+PY(1.5),PX(2.25),PY(2.25));\
GUI_TEXTURE(I_P_CIRCLEFILLED); \
GUI_TEXTURECOLOR(C); \
GUI_COMMIT(0); \
_gui_tempData pushBack GUI_NEWCTRL_TEXT_CENTERED; \
_gui_tempData = +[]; \
GUI_POSITION(X,Y,PX(3),PY(3));\
AAWUI_TEXTSTYLE_DISPLAY_BOLD_SMALL; \
GUI_TEXT(D); \
GUI_COMMIT(0); \

#define AAWUI_PLAYERNAME(N, R, RS, X, Y) _gui_tempData; \
_gui_tempData pushBack GUI_NEWCTRL("RscPicture"); \
GUI_POSITION_CENTERED(X+PX(2),Y+PY(1.5),PX(3*RS),PY(3*RS));\
GUI_TEXTURE(R); \
GUI_COMMIT(0); \
_gui_tempData pushBack GUI_NEWCTRL_TEXT_LEFT; \
_gui_tempData = +[]; \
GUI_POSITION(X+PX(4),Y,PX(16),PY(3));\
AAWUI_TEXTSTYLE_NORMAL_BOLD_SMALL; \
GUI_TEXT(N); \
GUI_COMMIT(0); \
