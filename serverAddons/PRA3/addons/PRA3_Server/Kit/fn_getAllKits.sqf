#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    get All Kit for player side

    Parameter(s):
    None

    Returns:
    Array With all Strings <Array>
*/

("getNumber (_x >> 'scope') != 0" configClasses (missionConfigFile >> QPREFIX >> "Sides" >> (str playerSide) >> "Kits")) apply {configName _x}
