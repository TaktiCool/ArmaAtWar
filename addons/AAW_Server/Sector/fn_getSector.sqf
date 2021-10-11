#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy, joko // Jonas

    Description:
    Get current Sector from DataBase

    Parameter(s):
    0: Sector Name <String>

    Returns:
    Sector Object <Object>
*/

params ["_sector"];

GVAR(allSectors) getVariable [_sector, objNull];
