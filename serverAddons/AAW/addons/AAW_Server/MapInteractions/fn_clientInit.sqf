#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Map Interactions

    Parameter(s):
    None

    Returns:
    None
*/
#define ITEM_HEIGHT PY(3)
#define CTXMENU_WIDTH PX(16)

GVAR(MapControls) = [];
GVAR(ContextMenuEntries) = false call CFUNC(createNamespace);

[{
    ((findDisplay 12) displayCtrl 51) call FUNC(registerMapControl);
}, {!(isNull ((findDisplay 12) displayCtrl 51))}] call CFUNC(waitUntil);

DFUNC(buildLabelElement) = {
    params ["_grp", "_args"];
    _args params ["_text"];

    private _display = ctrlParent _grp;

    private _currentPosition = _grp getVariable ["currentPosition", [0, 0]];
    private _currentSize = _grp getVariable ["currentSize", [0, 0]];
    private _yOffset = _currentPosition select 1;
    private _grpPos = ctrlPosition _grp;
    private _ctxMenuWidth = _grpPos select 2;

    private _itemText = _display ctrlCreate ["RscTitle", -1, _grp];
    _itemText ctrlSetText toUpper _text;
    _itemText ctrlSetFontHeight PY(2);
    _itemText ctrlSetFont "RobotoCondensed";
    _itemText ctrlSetPosition [0, _currentPosition select 1, _ctxMenuWidth, ITEM_HEIGHT];
    _itemText ctrlCommit 0;

    _grp setVariable ["currentPosition", [0, _yOffset + ITEM_HEIGHT]];
    _grp setVariable ["currentSize", [_currentSize select 0, (_yOffset + ITEM_HEIGHT) max (_currentSize select 1)]];
};

DFUNC(buildImageStackButton) = {
    params ["_grp", "_args"];
    _args params ["_images", "_action"];

    private _display = ctrlParent _grp;

    private _currentPosition = _grp getVariable ["currentPosition", [0, 0]];
    private _currentSize = _grp getVariable ["currentSize", [0, 0]];
    private _grpPos = ctrlPosition _grp;
    private _ctxMenuWidth = _grpPos select 2;

    private _itemGrp = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _grp];
    _itemGrp ctrlSetPosition [_currentPosition select 0, _currentPosition select 1, PX(4), PY(4)];

    private _itemBackground = _display ctrlCreate ["RscPicture", -1,_itemGrp];
    _itemBackground ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.5)";
    _itemBackground ctrlSetFade 1;

    {
        _x params ["_imagePath", ["_relSize", 1], ["_color", [1,1,1,1]]];
        private _sizeX = _relSize*PX(4);
        private _sizeY = _relSize*PY(4);
        private _offsetX = (PX(4)-_sizeX)/2;
        private _offsetY = (PY(4)-_sizeY)/2;
        private _itemBackText = _display ctrlCreate ["RscPicture", -1, _itemGrp];
        _itemBackText ctrlSetText _imagePath;
        _itemBackText ctrlSetTextColor _color;
        _itemBackText ctrlSetPosition [_offsetX, _offsetY, _sizeX, _sizeY];
        _itemBackText ctrlCommit 0;
    } count _images;


    private _itemActiveArea = _display ctrlCreate ["RscButton", -1, _itemGrp];
    _itemActiveArea ctrlSetActiveColor [0,0,0,0];
    _itemActiveArea ctrlSetBackgroundColor [0,0,0,0];
    _itemActiveArea ctrlSetFade 1;
    _itemActiveArea ctrlAddEventHandler ["MouseEnter", {
        params ["_ctrl"];
        _ctrl = _ctrl getVariable ["background", controlNull];
        if (!isNull _ctrl) then {
            _ctrl ctrlSetFade 0;
            _ctrl ctrlCommit 0.2;
        };
    }];
    _itemActiveArea ctrlAddEventHandler ["MouseExit", {
        params ["_ctrl"];
        _ctrl = _ctrl getVariable ["background", controlNull];
        if (!isNull _ctrl) then {
            _ctrl ctrlSetFade 1;
            _ctrl ctrlCommit 0.2;
        };
    }];

    _itemActiveArea ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];
        (_ctrl getVariable ["action", []]) params [["_code", {}], ["_attributes", []]];
        private _contextMenu = ctrlParentControlsGroup ctrlParentControlsGroup _ctrl;
        private _return = [_contextMenu, _attributes, _this] call _code;
        if (isNil "_return" || {_return}) then {
            ctrlDelete ctrlParentControlsGroup _contextMenu;
        };
    }];
    _itemActiveArea setVariable ["background", _itemBackground];
    _itemActiveArea setVariable ["action", _action];


    {
        _x ctrlSetPosition [0, 0, PX(4), PY(4)];
        _x ctrlCommit 0;
        false;
    } count [_itemBackground, _itemActiveArea];
    _itemGrp ctrlCommit 0;

    if ((_currentPosition select 0) + PX(4) > (_grpPos select 2)) then {
        _currentPosition set [0, 0];
        _currentPosition set [1, (_currentPosition select 1) + PY(4)];
    } else {
        _currentPosition set [0, (_currentPosition select 0) + PX(4)];
    };

    _grp setVariable ["currentPosition", _currentPosition];
    _grp setVariable ["currentSize", [_currentSize select 0, ((_currentPosition select 1) + PY(4)) max (_currentSize select 1)]];
};

DFUNC(buildHeaderElement) = {
    params ["_grp", "_args"];
    _args params ["_text"];

    private _display = ctrlParent _grp;

    private _currentPosition = _grp getVariable ["currentPosition", [0, 0]];
    private _currentSize = _grp getVariable ["currentSize", [0, 0]];
    private _yOffset = _currentPosition select 1;
    private _grpPos = ctrlPosition _grp;
    private _ctxMenuWidth = _grpPos select 2;

    private _itemGrp = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _grp];
    _itemGrp ctrlSetPosition [0, _yOffset, _ctxMenuWidth, ITEM_HEIGHT];

    private _itemBackground = _display ctrlCreate ["RscPicture", -1,_itemGrp];
    _itemBackground ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.5)";
    _itemBackground ctrlSetFade 1;

    private _itemText = _display ctrlCreate ["RscTitle", -1, _itemGrp];
    _itemText ctrlSetText toUpper _text;
    _itemText ctrlSetFontHeight PY(2.2);
    _itemText ctrlSetFont "RobotoCondensed";
    _itemText ctrlSetPosition [PX(3), 0, (_ctxMenuWidth-PX(3)), ITEM_HEIGHT];
    _itemText ctrlCommit 0;

    private _itemBackText = _display ctrlCreate ["RscPicture", -1, _itemGrp];
    _itemBackText ctrlSetText "A3\ui_f\data\gui\rsc\rscdisplayarcademap\icon_sidebar_show.paa";
    _itemBackText ctrlSetPosition [PX(0.5), PY(0.5), PX(2), PY(2)];
    _itemBackText ctrlCommit 0;

    private _itemActiveArea = _display ctrlCreate ["RscButton", -1, _itemGrp];
    _itemActiveArea ctrlSetActiveColor [0,0,0,0];
    _itemActiveArea ctrlSetBackgroundColor [0,0,0,0];
    _itemActiveArea ctrlSetFade 1;
    _itemActiveArea ctrlAddEventHandler ["MouseEnter", {
        params ["_ctrl"];
        _ctrl = _ctrl getVariable ["background", controlNull];
        if (!isNull _ctrl) then {
            _ctrl ctrlSetFade 0;
            _ctrl ctrlCommit 0.2;
        };
    }];
    _itemActiveArea ctrlAddEventHandler ["MouseExit", {
        params ["_ctrl"];
        _ctrl = _ctrl getVariable ["background", controlNull];
        if (!isNull _ctrl) then {
            _ctrl ctrlSetFade 1;
            _ctrl ctrlCommit 0.2;
        };
    }];

    _itemActiveArea ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];
        (_ctrl getVariable ["action", []]) params [["_code", {}], ["_attributes", []]];
        private _contextMenu = ctrlParentControlsGroup ctrlParentControlsGroup _ctrl;
        private _history = _contextMenu getVariable ["history", [""]];
        private _mapControl = _contextMenu getVariable ["mapControl", controlNull];
        private _menuId = if (count _history >= 1) then {
            _history select ((count _history) - 1);
        } else {
            "";
        };

        [{
            _this call EFUNC(MapInteractions,openContextMenu);
        }, [_mapControl, _menuId]] call CFUNC(execNextFrame);

    }];


    _itemActiveArea setVariable ["background", _itemBackground];
    _itemActiveArea setVariable ["contextMenu", _grp];

    {
        _x ctrlSetPosition [0, 0, PX(3), PY(3)];
        _x ctrlCommit 0;
        false;
    } count [_itemBackground, _itemActiveArea];
    _itemGrp ctrlCommit 0;

    _grp setVariable ["currentPosition", [0, _yOffset + ITEM_HEIGHT]];
    _grp setVariable ["currentSize", [_currentSize select 0, (_yOffset + ITEM_HEIGHT) max (_currentSize select 1)]];
};

DFUNC(buildListElement) = {
    params ["_grp", "_args"];
    _args params ["_text", "_action"];

    private _display = ctrlParent _grp;

    private _currentPosition = _grp getVariable ["currentPosition", [0, 0]];
    private _currentSize = _grp getVariable ["currentSize", [0, 0]];
    private _yOffset = _currentPosition select 1;
    private _grpPos = ctrlPosition _grp;
    private _ctxMenuWidth = _grpPos select 2;

    private _itemGrp = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _grp];
    _itemGrp ctrlSetPosition [0, _yOffset, _ctxMenuWidth, ITEM_HEIGHT];

    private _itemBackground = _display ctrlCreate ["RscPicture", -1,_itemGrp];
    _itemBackground ctrlSetText "#(argb,8,8,3)color(0.5,0.5,0.5,0.5)";
    _itemBackground ctrlSetFade 1;

    private _itemText = _display ctrlCreate ["RscTitle", -1, _itemGrp];
    _itemText ctrlSetText toUpper _text;
    _itemText ctrlSetFontHeight PY(2.2);
    _itemText ctrlSetFont "RobotoCondensed";

    private _itemActiveArea = _display ctrlCreate ["RscButton", -1, _itemGrp];
    _itemActiveArea ctrlSetActiveColor [0,0,0,0];
    _itemActiveArea ctrlSetBackgroundColor [0,0,0,0];
    _itemActiveArea ctrlSetFade 1;
    _itemActiveArea ctrlAddEventHandler ["MouseEnter", {
        params ["_ctrl"];
        _ctrl = _ctrl getVariable ["background", controlNull];
        if (!isNull _ctrl) then {
            _ctrl ctrlSetFade 0;
            _ctrl ctrlCommit 0.2;
        };
    }];
    _itemActiveArea ctrlAddEventHandler ["MouseExit", {
        params ["_ctrl"];
        _ctrl = _ctrl getVariable ["background", controlNull];
        if (!isNull _ctrl) then {
            _ctrl ctrlSetFade 1;
            _ctrl ctrlCommit 0.2;
        };
    }];
    _itemActiveArea ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrl"];
        (_ctrl getVariable ["action", []]) params [["_code", {}], ["_attributes", []]];
        private _contextMenu = ctrlParentControlsGroup ctrlParentControlsGroup _ctrl;
        private _return = [_contextMenu, _attributes, _this] call _code;
        if (isNil "_return" || {_return}) then {
            ctrlDelete ctrlParentControlsGroup _contextMenu;
        };
    }];
    _itemActiveArea setVariable ["background", _itemBackground];
    _itemActiveArea setVariable ["action", _action];

    {
        _x ctrlSetPosition [0, 0, _ctxMenuWidth, ITEM_HEIGHT];
        _x ctrlCommit 0;
        false;
    } count [_itemBackground, _itemText, _itemActiveArea];
    _itemGrp ctrlCommit 0;

    _grp setVariable ["currentPosition", [0, _yOffset + ITEM_HEIGHT]];
    _grp setVariable ["currentSize", [_currentSize select 0, (_yOffset + ITEM_HEIGHT) max (_currentSize select 1)]];
};

DFUNC(openContextMenu) = {
    params ["_mapControl", ["_menuId", ""], ["_xPos", -1], ["_yPos", -1]];
    private _display = ctrlParent _mapControl;
    private _contextMenuGrp = _mapControl getVariable [QGVAR(ContextMenuGroup), controlNull];
    private _contextMenuBackground = controlNull;
    private _animDirection = 1;
    if (isNull _contextMenuGrp) then {
        _contextMenuGrp = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
        _contextMenuGrp ctrlAddEventHandler ["Unload", {
            [
                QGVAR(CursorMarker)
            ] call CFUNC(removeMapGraphicsGroup);
        }];
        _contextMenuBackground = _display ctrlCreate ["RscPicture", -1, _contextMenuGrp];
        _xPos = _xPos+PX(2);
        _contextMenuGrp ctrlSetPosition [_xPos, _yPos, CTXMENU_WIDTH, 0];
        _contextMenuGrp ctrlCommit 0;
        _contextMenuGrp setVariable ["mapControl", _mapControl];
        _contextMenuGrp setVariable ["history", []];
    } else {
        _contextMenuBackground = _contextMenuGrp getVariable ["background", _contextMenuBackground];
        // Calculate Position
        private _pos = ctrlPosition _contextMenuGrp;
        _xPos = _pos select 0;
        _yPos = (_pos select 1) + (_pos select 3)/2;
        private _history = _contextMenuGrp getVariable ["history", []];
        private _contextMenuItemsGrp = _contextMenuGrp getVariable ["contextMenuItemsGroup", controlNull];
        private _currentMenuId = _contextMenuItemsGrp getVariable ["menuId", ""];
        private _c = _history find _menuId;
        if (_c >= 0) then { // Go back
            _history resize _c;
            _animDirection = -1;
            hint ("remove from history: " + str _history);
        } else { // Go forward
            _history pushBack _currentMenuId;
            hint ("add to history: " + str _history);
        };

        _contextMenuItemsGrp ctrlSetPosition [-_animDirection*CTXMENU_WIDTH, 0];
        _contextMenuItemsGrp ctrlCommit 0.2;
        [{
            ctrlDelete _this;
        }, 0.2, _contextMenuItemsGrp] call CFUNC(wait);

        _contextMenuGrp setVariable ["history", _history];
    };


    private _contextMenuItemsGrp = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _contextMenuGrp];
    _contextMenuItemsGrp ctrlCommit 0;
    _contextMenuItemsGrp setVariable ["currentPosition", [0, 0]];
    _contextMenuItemsGrp setVariable ["currentSize", [CTXMENU_WIDTH, 0]];
    _contextMenuItemsGrp setVariable ["menuId", _menuId];
    _contextMenuItemsGrp setVariable ["mapControl", _mapControl];

    _contextMenuGrp setVariable ["contextMenuItemsGroup", _contextMenuItemsGrp];

    private _nbrElements = {
        _x params ["_type", "_arguments"];
        if (_type == "header") then {
            [_contextMenuItemsGrp, _arguments] call FUNC(buildHeaderElement);
        };
        if (_type == "list") then {
            [_contextMenuItemsGrp, _arguments] call FUNC(buildListElement);
        };
        if (_type == "label") then {
            [_contextMenuItemsGrp, _arguments] call FUNC(buildLabelElement);
        };
        if (_type == "imageStackButton") then {
            [_contextMenuItemsGrp, _arguments] call FUNC(buildImageStackButton);
        };

        true;
    } count (GVAR(ContextMenuEntries) getVariable ["ContextMenu_" + _menuId, []]);

    private _currentSize = _contextMenuItemsGrp getVariable ["currentSize", [0, 0]];

    _contextMenuBackground ctrlSetText "#(argb,8,8,3)color(0.2,0.2,0.2,0.6)";
    _contextMenuBackground ctrlSetPosition [0, 0, _currentSize select 0, _currentSize select 1];
    _contextMenuBackground ctrlCommit 0;

    _contextMenuGrp ctrlSetPosition [_xPos, _yPos-(_currentSize select 1)/2, _currentSize select 0, _currentSize select 1];
    _contextMenuGrp ctrlCommit 0.2;

    _contextMenuItemsGrp ctrlSetPosition [_animDirection*(_currentSize select 0), 0, _currentSize select 0, _currentSize select 1];
    _contextMenuItemsGrp ctrlCommit 0;
    _contextMenuItemsGrp ctrlSetPosition [0, 0];
    _contextMenuItemsGrp ctrlCommit 0.2;

    _mapControl setVariable [QGVAR(ContextMenuGroup), _contextMenuGrp];
    _contextMenuGrp setVariable ["background", _contextMenuBackground];

};
