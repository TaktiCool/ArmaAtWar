#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, BadGuy

    Description:
    Logistic system

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(DraggableClasses) = ["Thing"];
GVAR(CargoClasses) = ["AllVehicles", "Thing"];

GVAR(ppBlur) = ppEffectCreate ["DynamicBlur", 999];
GVAR(ppColor) = ppEffectCreate ["colorCorrections", 1502];

DFUNC(updateResourceItems) = {
    _this params ["_display", "_contentGroup", "_resourcePoints"];

    _teamResourcePoints = (missionNamespace getVariable [format [QEGVAR(Logistic,sideResources_%1), side group CLib_player], 0]);

    _resourcePoints ctrlSetText str _teamResourcePoints;

    private _cfg = QUOTE(PREFIX/CfgLogistics/) + ([format [QUOTE(PREFIX/Sides/%1/logistics), side group CLib_player], ""] call CFUNC(getSetting));
    private _ctrlItems = _contentGroup getVariable [QGVAR(logisticItems), []];
    {
        ctrlDelete _x;
        nil
    } count _ctrlItems;
    _ctrlItems = [];

    {
        private _subcfg = _cfg + "/" + _x;
        private _content = [_subcfg + "/content"] call CFUNC(getSetting);
        private _className = [_subcfg + "/classname"] call CFUNC(getSetting);
        private _clearOnSpawn = ([_subcfg + "/removeDefaultLoadout"] call CFUNC(getSetting)) > 0;
        private _displayName = [_subcfg + "/displayName"] call CFUNC(getSetting);
        private _resources = [_subcfg + "/resources", 0] call CFUNC(getSetting);
        private _picture = [_subcfg + "/picture", "\A3\3den\data\displays\display3den\panelright\modemodules_ca.paa"] call CFUNC(getSetting);


        if (_displayName call CFUNC(isLocalised)) then {
            _displayName = LOC(_displayName);
        };

        private _itemGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1, _contentGroup];
        _itemGroup ctrlSetPosition [(_forEachIndex mod 2)*PX(60), (floor (_forEachIndex/2))*PY(15), PX(59), PY(15)];
        _itemGroup ctrlCommit 0;

        private _itemBg = _display ctrlCreate ["RscText", 100, _itemGroup];
        _itemBg ctrlSetPosition [0, 0, PX(59), PY(14)];
        _itemBg ctrlSetBackgroundColor [0.3,0.3,0.3,0.3];
        _itemBg ctrlCommit 0;

        private _itemPicture = _display ctrlCreate ["RscPictureKeepAspect", -1, _itemGroup];
        _itemPicture ctrlSetPosition [PX(1), PY(3), PX(8), PY(8)];
        _itemPicture ctrlSetText _picture;
        _itemPicture ctrlCommit 0;

        private _itemTitle = _display ctrlCreate ["RscTitle", -1, _itemGroup];
        _itemTitle ctrlSetFontHeight PY(2.6);
        _itemTitle ctrlSetFont "RobotoCondensedBold";
        _itemTitle ctrlSetPosition [PX(10), PY(1), PX(49), PY(2.5)];
        _itemTitle ctrlSetText toUpper _displayName;
        _itemTitle ctrlCommit 0;

        private _itemCosts = _display ctrlCreate ["RscTextNoShadow", -1, _itemGroup];
        _itemCosts ctrlSetFontHeight PY(4);
        _itemCosts ctrlSetFont "RobotoCondensedBold";
        _itemCosts ctrlSetPosition [PX(48), PY(1), PX(10), PY(8)];
        _itemCosts ctrlSetText str _resources;
        _itemCosts ctrlSetBackgroundColor [0.13,0.54,0.21,1];
        _itemCosts ctrlCommit 0;

        /*
        private _itemDescription = _display ctrlCreate ["RscStructuredText", -1, _itemGroup];
        _itemDescription ctrlSetFontHeight PY(2);
        _itemDescription ctrlSetFont "RobotoCondensed";
        _itemDescription ctrlSetPosition [PX(10), PY(3.5), PX(29), PY(4.5)];
        _itemDescription ctrlSetStructuredText parseText "<t shadow='0'>This is a long Description. A lot of Text, nobody really reads this. Hopefully!!!</t>";
        _itemDescription ctrlCommit 0;
        */

        if !(_content isEqualTo []) then {
            private _itemContentListGroup = _display ctrlCreate ["RscControlsGroupNoHScrollbars", -1, _itemGroup];
            _itemContentListGroup ctrlSetPosition [PX(10), PY(4), PX(37), PY(8)];
            _itemContentListGroup ctrlCommit 0;

            private _contentCount = count _content;

            {
                private _picture = "";
                private _displayName = _x select 0;

                private _posx = PX(18) * (_forEachIndex mod 1);
                private _posy = PY(2) * floor (_forEachIndex/1);

                if (isClass (configFile >> "CfgVehicles" >> (_x select 0))) then {
                    _picture = getText (configFile >> "CfgVehicles" >> (_x select 0) >> "picture");
                    _displayName = getText (configFile >> "CfgVehicles" >> (_x select 0) >> "displayName");
                };

                if (isClass (configFile >> "CfgMagazines" >> (_x select 0))) then {
                    _picture = getText (configFile >> "CfgMagazines" >> (_x select 0) >> "picture");
                    _displayName = getText (configFile >> "CfgMagazines" >> (_x select 0) >> "displayName");
                };

                if (isClass (configFile >> "CfgWeapons" >> (_x select 0))) then {
                    _picture = getText (configFile >> "CfgWeapons" >> (_x select 0) >> "picture");
                    _displayName = getText (configFile >> "CfgWeapons" >> (_x select 0) >> "displayName");
                };

                private _itemPicture = _display ctrlCreate ["RscPictureKeepAspect", -1, _itemContentListGroup];
                _itemPicture ctrlSetPosition [_posx, _posy, PX(2), PY(2)];
                _itemPicture ctrlSetText _picture;
                _itemPicture ctrlCommit 0;

                private _itemTitle = _display ctrlCreate ["RscTitle", -1, _itemContentListGroup];
                _itemTitle ctrlSetFontHeight PY(2);
                _itemTitle ctrlSetFont "RobotoCondensed";
                _itemTitle ctrlSetPosition [_posx + PX(2.2), _posy, PX(34), PY(2)];
                _itemTitle ctrlSetText format ["%1x %2", _x select 1, _displayName];
                _itemTitle ctrlCommit 0;


            } forEach _content;
        };

        if (_teamResourcePoints >= _resources) then {
            private _itemRequestButton = _display ctrlCreate ["RscButton", -1, _itemGroup];
            _itemRequestButton ctrlSetPosition [PX(48), PY(10), PX(10), PY(3)];
            _itemRequestButton ctrlSetFont "RobotoCondensed";
            _itemRequestButton ctrlSetFontHeight PY(2);
            _itemRequestButton ctrlSetText "REQUEST";
            _itemRequestButton setVariable [QGVAR(args), [_className, _content, _clearOnSpawn, _displayName, _resources]];
            _itemRequestButton ctrlAddEventHandler ["ButtonClick", {
                _this params ["_ctrl"];
                private _args = _ctrl getVariable [QGVAR(args), []];
                if (_args isEqualTo []) exitWith {};
                ["spawnCrate", [_args, getPos CLib_player, side group CLib_player]] call CFUNC(serverEvent);

            }];
            _itemRequestButton ctrlCommit 0;
        } else {
            private _disableBg = _display ctrlCreate ["RscText", -1, _itemGroup];
            _disableBg ctrlSetPosition [0, 0, PX(59), PY(14)];
            _disableBg ctrlSetBackgroundColor [0.3,0.3,0.3,0.5];
            _disableBg ctrlCommit 0;
            _itemCosts ctrlSetBackgroundColor [0.5,0.5,0.5,1];
            _itemCosts ctrlCommit 0;
        };



        _ctrlItems pushBack _itemGroup;

    } forEach ([_cfg] call CFUNC(getSettingSubClasses));

    _contentGroup setVariable [QGVAR(logisticItems), _ctrlItems];


};

DFUNC(buildResourcesDisplay) = {
        private _display = (findDisplay 46) createDisplay "RscDisplayEmpty";

        CGVAR(Interaction_DisablePrevAction) = true;
        CGVAR(Interaction_DisableNextAction) = true;
        CGVAR(Interaction_DisableAction) = true;

        _display displayAddEventHandler ["KeyDown",  {
            params ["_display", "_dikCode", "_shift", "_ctrl", "_alt"];
            private _handled = false;
            if (_dikCode == 1) then {
                _display closeDisplay 1;
                _handled = true;
            };
            _handled;
        }];

        _display displayAddEventHandler ["Unload",  {
            params ["_display", "_exitCode"];
            GVAR(ppColor) ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [1, 1, 1, 1], [0.7, 0.2, 0.1, 0.0]];
            GVAR(ppColor) ppEffectCommit 0.3;
            GVAR(ppBlur) ppEffectAdjust [0];
            GVAR(ppBlur) ppEffectCommit 0.3;

            CGVAR(Interaction_DisablePrevAction) = false;
            CGVAR(Interaction_DisableNextAction) = false;
            CGVAR(Interaction_DisableAction) = false;

            private _eventId = _display getVariable [QGVAR(resourceChangedEventHandler), -1];
            if (_eventId != -1) then {
                ["resourcesChanged", _eventId] call CFUNC(removeEventHandler);
            };
        }];

        GVAR(ppColor) ppEffectEnable true;
        GVAR(ppColor) ppEffectAdjust [0.7, 0.7, 0.1, [0, 0, 0, 0], [1, 1, 1, 1], [0.7, 0.2, 0.1, 0.0]];
        GVAR(ppColor) ppEffectCommit 0.2;

        GVAR(ppBlur) ppEffectAdjust [8];
        GVAR(ppBlur) ppEffectEnable true;
        GVAR(ppBlur) ppEffectCommit 0.2;

        private _headerBg = _display ctrlCreate ["RscText", -1];
        _headerBg ctrlSetPosition [safeZoneX, safeZoneY, safeZoneW, PY(15.5)];
        _headerBg ctrlSetBackgroundColor [0.5,0.5,0.5,0.3];
        _headerBg ctrlCommit 0;

        private _globalGroup = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
        _globalGroup ctrlSetPosition [0.5-PX(60), safeZoneY, safeZoneW, safeZoneH];
        _globalGroup ctrlCommit 0;


        private _title = _display ctrlCreate ["RscTitle", -1, _globalGroup];
        _title ctrlSetFontHeight PY(3.2);
        _title ctrlSetFont "RobotoCondensedBold";
        _title ctrlSetPosition [0, PY(10.5), PX(60), PY(4)];
        _title ctrlSetText "REQUEST RESOURCES";
        _title ctrlCommit 0;

        private _resourcePicture = _display ctrlCreate ["RscPictureKeepAspect", -1, _globalGroup];
        _resourcePicture ctrlSetPosition [PX(109), PY(10.5), PX(4), PY(4)];
        _resourcePicture ctrlSetText "\A3\3den\data\displays\display3den\panelright\modemodules_ca.paa";
        _resourcePicture ctrlCommit 0;

        private _resourcePoints = _display ctrlCreate ["RscTitle", -1, _globalGroup];
        _resourcePoints ctrlSetFontHeight PY(3.2);
        _resourcePoints ctrlSetFont "RobotoCondensedBold";
        _resourcePoints ctrlSetPosition [PX(114), PY(10.5), PX(6), PY(4)];
        _resourcePoints ctrlSetText "---";
        _resourcePoints ctrlCommit 0;

        private _contentGroup = _display ctrlCreate ["RscControlsGroupNoHScrollbars", -1, _globalGroup];
        _contentGroup ctrlSetPosition [0, PY(20), safeZoneW, safeZoneH - PY(40)];
        _contentGroup ctrlCommit 0;

        private _resourceChangedEventHandler = ["resourcesChanged", {(_this select 1) call FUNC(updateResourceItems);} ,[_display, _contentGroup, _resourcePoints]] call CFUNC(addEventHandler);
        _display setVariable [QGVAR(resourceChangedEventHandler), _resourceChangedEventHandler];

        [_display, _contentGroup, _resourcePoints] call FUNC(updateResourceItems);

};



["missionStarted", {
    {
        private _side = _x;
        private _cfg = QUOTE(PREFIX/CfgLogistics/) + ([format [QUOTE(PREFIX/Sides/%1/logistics), _side], ""] call CFUNC(getSetting));
        //private _cfg = (missionConfigFile >> QPREFIX >> "Sides" >> _side >> "cfgLogistic");
        private _objects = [_cfg + "/objectToSpawn"] call CFUNC(getSetting);

        _objects = _objects apply {
            private _obj = missionNamespace getVariable [_x, objNull];
            // dont allow Loading in the Create Crate Objects
            _obj setVariable ["cargoCapacity", 0];
            _obj
        };


        [
            "Request Resources",
            _objects,
            3,
            compile format ["(str playerside) == ""%1""", _side],
            FUNC(buildResourcesDisplay),
            ["onActionAdded", {
                params ["_id", "_target"];
                _target setUserActionText [_id, "Request Resources", "<img size='3' shadow='0' color='#ffffff' image='\A3\3den\data\displays\display3den\panelright\modemodules_ca.paa'/><br/><br/>Request Resources"];
            },
            "priority", 1000, "showWindow", true]
        ] call CFUNC(addAction);

        nil
    } count ([QUOTE(PREFIX/Sides)] call CFUNC(getSettingSubClasses));
    /*
    {
        private _side = _x;
        private _cfg = QUOTE(PREFIX/CfgLogistics/) + ([format [QUOTE(PREFIX/Sides/%1/logistics), _side], ""] call CFUNC(getSetting));
        //private _cfg = (missionConfigFile >> QPREFIX >> "Sides" >> _side >> "cfgLogistic");
        private _objects = [_cfg + "/objectToSpawn"] call CFUNC(getSetting);

        _objects = _objects apply {
            private _obj = missionNamespace getVariable [_x, objNull];
            // dont allow Loading in the Create Crate Objects
            _obj setVariable ["cargoCapacity", 0];
            _obj
        };

        {
            private _subcfg = _cfg + "/" + _x;
            private _content = [_subcfg + "/content"] call CFUNC(getSetting);
            private _className = [_subcfg + "/classname"] call CFUNC(getSetting);
            private _clearOnSpawn = [_subcfg + "/removeDefaultLoadout"] call CFUNC(getSetting);
            private _displayName = [_subcfg + "/displayName"] call CFUNC(getSetting);
            private _resources = [_subcfg + "/resources", 0] call CFUNC(getSetting);
            if (_displayName call CFUNC(isLocalised)) then {
                _displayName = LOC(_displayName);
            };
            [
                format ["%1 (%2)", _displayName, _resources],
                _objects,
                3,
                compile format ["(str playerside) == ""%1""", _side],
                {
                    params ["_targetPos", "", "", "_args"];
                    _args params ["_crateType", ["_content", []], "_clearOnSpawn", "_displayName", "_resources"];
                    if (missionNamespace getVariable [format [QGVAR(sideResources_%1), side group CLib_player], 0] >= _resources) then {
                        ["spawnCrate", [_args, getPos _targetPos]] call CFUNC(serverEvent);
                    } else {
                        ["RESOURCES INSUFFICIENT", "You need more resources"] call EFUNC(Common,displayHint);
                    };

                },
                ["arguments", [_className, _content, _clearOnSpawn isEqualTo 1, _displayName, _resources]]
            ] call CFUNC(addAction);

            nil
        } count ([_cfg] call CFUNC(getSettingSubClasses));
        nil
    } count ([QUOTE(PREFIX/Sides)] call CFUNC(getSettingSubClasses));
    */
}] call CFUNC(addEventHandler);

["unconsciousnessChanged", {
    if (!isNull (CLib_Player getVariable [QGVAR(Item), objNull])) then {
        CLib_Player call FUNC(dropObject);
    };
}] call CFUNC(addEventhandler);

["isNotDragging", {
    isNull (_caller getVariable [QGVAR(Item), objNull])
     && isNull (_target getVariable [QGVAR(Item), objNull])
}] call CFUNC(addCanInteractWith);

["isNotDragged", {
    isNull (_target getVariable [QGVAR(Dragger), objNull])
}] call CFUNC(addCanInteractWith);
