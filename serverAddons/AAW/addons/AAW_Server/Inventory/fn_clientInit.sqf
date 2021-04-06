#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Init Inventory system

    Parameter(s):
    None

    Returns:
    None
*/

if (side CLib_player == sideLogic && {player isKindOf "VirtualSpectator_F"}) exitWith {};

[UIVAR(Inventory_onShow), {
    params ["_grpMain"];


    {
        ctrlDelete _x;
        nil;
    } count (_grpMain getVariable [QGVAR(children), []]);

    private _yOffset = 0;
    private _children = [];

    GUI_INIT(ctrlParent _grpMain);
    GUI_PUSHGRP(_grpMain);

    (CLib_player getVariable [QEGVAR(Logistic,SupplyData), [[],[],[]]]) params ["", "_supplyData"];
    _supplyData = +_supplyData;
    private _currentSupplyData = call EFUNC(Logistic,generateSupplyData);
    private _processedMagazines=[];

    {
        if (_x != "") then {
            private _weaponType = _x;
            private _weaponConfig = configFile >> "CfgWeapons" >> _weaponType;
            private _compatibleMagazines = [];
            {
                if (toLower _x != "this") then {
                    _compatibleMagazines append ([_weaponType, _x] call CFUNC(compatibleMagazines));
                } else {
                    _compatibleMagazines append ([_weaponType] call CFUNC(compatibleMagazines));
                };
                nil
            } count (getArray (_weaponConfig >> "muzzles"));
            _compatibleMagazines = _compatibleMagazines arrayIntersect _compatibleMagazines;

            private _magazines = [];

            {
                _x params ["", "_name", "_count"];
                if (_name in _compatibleMagazines) then {
                    _processedMagazines pushBack _name;
                    private _idx = (_currentSupplyData select 0) find _name;
                    private _currentCount = [];
                    if (_idx >= 0) then {
                        ((_currentSupplyData select 1) select _idx) params ["", "", "_count"];
                        _currentCount = _count;
                    };

                    private _currentShots = 0;
                    private _shots = 0;

                    {
                        _currentShots = _currentShots + (_x select 0);
                        nil;
                    } count _currentCount;

                    {
                        _shots = _shots + (_x select 0);
                        nil;
                    } count _count;

                    _magazines pushBack [_name, _currentShots, _shots, {_x select 0 > 0} count _currentCount, {_x select 0 > 0} count _count];
                };
                nil
            } count _supplyData;

            private _nbrMagazineTypes = count _magazines;

            DUMP(_magazines);

            GUI_NEWGROUP(0, _yOffset, PX(13), PY(7));GUI_COMMIT(0);
            AAWUI_PANELBACKGROUND(0, 0, PX(13), PY(7));GUI_COMMIT(0);
            private _magazineHeight = PY(7)/(count _magazines);
            private _magazineOffset = 0;
            {
                private _factor = (_x select 1)/(_x select 2);
                GUI_NEWGROUP(0, _magazineOffset, PX(13), _magazineHeight);GUI_COMMIT(0);
                AAWUI_PANELBACKGROUND(0, 0, PX(13), _magazineHeight);GUI_COMMIT(0);
                AAWUI_WHITEBACKGROUND((1-_factor)*PX(13), 0, _factor*PX(13), _magazineHeight);
                GUI_LASTCTRL ctrlSetFade 0.6;
                GUI_COMMIT(0);
                GUI_NEWCTRL("RscPicture");
                GUI_POSITION(PX(11), _magazineHeight/2 - PY(1), PX(2), PY(2));
                GUI_TEXTURE(getText (configFile >> "CfgMagazines" >> _x select 0 >> "picture"));
                GUI_COMMIT(0);
                GUI_NEWCTRL("RscTextNoShadow");
                GUI_POSITION(PX(10), _magazineHeight/2 - PY(1), PX(3), PY(2));
                AAWUI_TEXTSTYLE_NORMAL_BOLD_SMALL;
                GUI_TEXT(str (_x select 3) + "/" + str (_x select 4));
                GUI_COMMIT(0);
                GUI_POPGRP;
                _magazineOffset = _magazineOffset + _magazineHeight;
                nil;
            } count _magazines;


            GUI_NEWCTRL("RscPicture");
            GUI_POSITION(PX(0.5), PY(1.5), PX(10), PY(5));
            GUI_TEXTURE(getText (_weaponConfig >> "picture"));
            GUI_COMMIT(0);
            GUI_NEWCTRL("RscTitle");
            GUI_POSITION(PX(1), PY(0), PX(11), PY(2));
            AAWUI_TEXTSTYLE_NORMAL_BOLD_SMALL;
            GUI_TEXT(toUpper getText (_weaponConfig >> "displayName"));
            GUI_COMMIT(0);

            _children pushBack GUI_POPGRP;
            _yOffset = _yOffset + PY(7.5);
        };
        nil;
    } count [primaryWeapon CLib_player, secondaryWeapon CLib_player, handgunWeapon CLib_player];



    {
        _x params ["_type", "_name", "_count"];

        if !(_name in _processedMagazines) then {
            private _picture = switch (_type) do {
                case (0):{
                    getText (configFile >> "CfgWeapons" >> _name >> "picture");
                };
                case (1): {
                    getText (configFile >> "CfgMagazines" >> _name >> "picture");
                };
                case (2): {
                    "\a3\ui_f\data\GUI\Cfg\RespawnRoles\assault_ca.paa";
                };
                default {
                    "";
                };
            };
            private _idx = (_currentSupplyData select 0) find _name;
            private _currentCount = [];
            if (_idx >= 0) then {
                ((_currentSupplyData select 1) select _idx) params ["", "", "_count"];
                _currentCount = _count;
            };

            private _currentShots = 0;
            private _shots = 0;

            {
                _currentShots = _currentShots + (_x select 0);
                nil;
            } count _currentCount;

            {
                _shots = _shots + (_x select 0);
                nil;
            } count _count;

            private _factor = _currentShots/_shots;

            GUI_NEWGROUP(PX(8), _yOffset, PX(5), PY(5));GUI_COMMIT(0);
            AAWUI_PANELBACKGROUND(0, 0, PX(5), PY(5));GUI_COMMIT(0);
            AAWUI_WHITEBACKGROUND(0, (1-_factor)*PY(5), PX(5), _factor*PY(5));
            GUI_LASTCTRL ctrlSetFade 0.6;
            GUI_COMMIT(0);
            GUI_NEWCTRL("RscPicture");
            GUI_POSITION(PX(0.5), PY(0.5), PX(4), PY(4));
            GUI_TEXTURE(_picture);
            GUI_COMMIT(0);
            GUI_NEWCTRL("RscTextNoShadow");
            GUI_POSITION(0, PY(3), PX(5), PY(2));
            AAWUI_TEXTSTYLE_NORMAL_BOLD_SMALL;
            GUI_TEXT(str ({_x select 0 > 0} count _currentCount) + "/" + str ({_x select 0 > 0} count _count));
            GUI_COMMIT(0);

            _children pushBack GUI_POPGRP;
            _yOffset = _yOffset + PY(5.5);
        };
        nil;
    } count _supplyData;

    _grpMain setVariable [QGVAR(children), _children];
    _grpMain ctrlSetPosition [safeZoneX + safeZoneW - PX(14), safezoneY + PY(20)];
    _grpMain ctrlSetFade 0;
    _grpMain ctrlCommit 0.5;
}] call CFUNC(addEventHandler);

[UIVAR(Inventory_onHide), {
    params ["_grpMain"];

    _grpMain ctrlSetPosition [safeZoneX + safeZoneW, safezoneY + PY(20)];
    _grpMain ctrlSetFade 1;
    _grpMain ctrlCommit 0.5;

}] call CFUNC(addEventHandler);


["missionStarted", {
    private _display = findDisplay 46;
    if (isNull _display) exitWith {};

    GUI_INIT(_display);

    // Main
    private _grpMain = GUI_NEWGROUP(safeZoneX + safeZoneW, safezoneY + PY(20), PX(13), safeZoneH - PY(40));
    uiNamespace setVariable [QGVAR(GrpMain), _grpMain];
    GUI_COMMIT(0);
}] call CFUNC(addEventHandler);

["InventoryOpened", {
    // Dont show vanilla inventory
    _CLib_EventReturn = true;

    CLib_player playAction "";

    private _grpMain = uiNamespace getVariable [QGVAR(GrpMain), controlNull];
    if (!ctrlCommitted _grpMain) exitWith {};

    if (ctrlFade _grpMain == 1) then {
        [UIVAR(Inventory_onShow), _grpMain] call CFUNC(localEvent);
        [{
            params ["_grpMain"];
            if (ctrlFade _grpMain != 1) then {
                [UIVAR(Inventory_onHide), _grpMain] call CFUNC(localEvent);
            };
        }, 3, _grpMain] call CFUNC(wait);
    } else {
        [UIVAR(Inventory_onHide), _grpMain] call CFUNC(localEvent);
    };



}] call CFUNC(addEventHandler);
