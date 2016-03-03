#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    get All Loadouts from a Side

    Parameter(s):
    0: Side <Side>

    Returns:
    Array With all Strings <Array>
*/
params ["_side"];
private _ret = [];

{
    if (toLower(_x) find toLower(str(_side))) then {
        _ret pushBack _x;
    };
    nil
} count allVariables GVAR(LoadoutCache);
