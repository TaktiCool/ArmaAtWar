#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    get All Kit for player side

    Parameter(s):
    None

    Returns:
    Array With all Strings <Array>
*/
params ["_side"];

//("getNumber (_x >> 'scope') != 0" configClasses (missionConfigFile >> QPREFIX >> "Sides" >> (str playerSide) >> "Kits")) apply {configName _x}
private _cfg = QUOTE(PREFIX/CfgKits/) + ([format [QUOTE(PREFIX/Sides/%1/kits), str _side], ""] call CFUNC(getSetting));
([_cfg] call CFUNC(getSettingSubClasses)) select {([format ["%1/%2/scope", _cfg, _x], 0] call CFUNC(getSetting)) == 1};
