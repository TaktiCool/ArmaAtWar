#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Map Marker

    Parameter(s):
    None

    Returns:
    None
*/

["", "list", ["Marker", [{
    params ["_contextMenuGrp"];
    private _mapControl = _contextMenuGrp getVariable ["mapControl", controlNull];
    [_mapControl, QUOTE(MODULE)] call EFUNC(MapInteractions,openContextMenu);
    false;
},[]]]] call EFUNC(MapInteractions,addMenuEntry);

[QUOTE(MODULE), "header", ["Marker"]] call EFUNC(MapInteractions,addMenuEntry);

[QUOTE(MODULE), "imageStackButton", [[["A3\ui_f\data\map\markers\nato\o_inf.paa", 0.6, [0.6, 0, 0, 1]]], [{
},[]]]] call EFUNC(MapInteractions,addMenuEntry);

[QUOTE(MODULE), "imageStackButton", [[["A3\ui_f\data\map\markers\nato\b_mech_inf.paa", 0.6, [0.6, 0, 0, 1]]], [{
},[]]]] call EFUNC(MapInteractions,addMenuEntry);

[QUOTE(MODULE), "imageStackButton", [[["A3\ui_f\data\map\markers\nato\b_mech_inf.paa", 0.6, [0.6, 0, 0, 1]]], [{
},[]]]] call EFUNC(MapInteractions,addMenuEntry);

[QUOTE(MODULE), "imageStackButton", [[["A3\ui_f\data\map\markers\nato\b_armor.paa", 0.6, [0.6, 0, 0, 1]]], [{
},[]]]] call EFUNC(MapInteractions,addMenuEntry);
