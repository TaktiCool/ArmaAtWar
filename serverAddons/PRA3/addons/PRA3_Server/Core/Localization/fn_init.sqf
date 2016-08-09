#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Client Init for Localisation

    Parameter(s):
    None

    Returns:
    None
*/

if (isServer) then {
    LVAR(Namespace) = false call CFUNC(createNamespace);

    LVAR(supportedLanguages) = getArray(configFile >> "PRA3" >> "cfgLocalization" >> "supportedLanguages");

    {
        {
            private _currentConfig = _x;
            private _allLocalisations = [];
            {
                _allLocalisations set [_forEachIndex, getText (_currentConfig >> ["English", _x] select (isText _currentConfig >> _x))];
            } forEach LVAR(supportedLanguages);
            [LVAR(Namespace), configName _x, _allLocalisations, QLVAR(allLocalisations)] call CFUNC(setVariable);
            nil
        } count configProperties [_x >> "PRA3" >> "cfgLocalization", "isClass _x", true];
        nil
    } count [configFile, campaignConfigFile, missionConfigFile];


    [QLVAR(registerPlayer), {
        (_this select 0) params ["_language", "_player"];
        private _sendVariable = [];
        private _index = LVAR(supportedLanguages) find _language;
        if (_index == -1) then {
            _index = LVAR(supportedLanguages) find "English";
        };

        {
            private _var = (LVAR(Namespace) getVariable _x) select _index;
            _sendVariable pushBack [_x, _var];
        } count [LVAR(Namespace), QLVAR(allLocalisations)] call CFUNC(allVariables);

        [QLVAR(receive), _player, _sendVariable] call CFUNC(targetEvent);
    }] call CFUNC(addEventhandler);
};

if (hasInterface) then {
    LVAR(Namespace) = false call CFUNC(createNamespace);

    [QLVAR(registerPlayer), [language, PRA3_Player]] call CFUNC(serverEvent);

    [QLVAR(receive), {
        {
            [LVAR(Namespace), _x select 0, _x select 1, QLVAR(all)] call CFUNC(setVariable);
        } count (_this select 0);
    }] call CFUNC(addEventhandler);
};
