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
private _currentSide = side group PRA3_Player;

//@todo check scope

("true" configClasses (missionConfigFile >> "PRA3" >> "Sides" >> (str _currentSide) >> "Kits")) apply {configName _x}
