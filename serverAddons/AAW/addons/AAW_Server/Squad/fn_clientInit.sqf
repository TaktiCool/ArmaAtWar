#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    -

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(GroupTypes), missionConfigFile >> QPREFIX >> "GroupTypes"] call CFUNC(loadSettings);

//GVAR(squadIds) = ("true" configClasses (configFile >> "CfgWorlds" >> "GroupCompany")) apply {getText (_x >> "name")};
GVAR(squadIds) = [
    "Alpha",
    "Bravo",
    "Charlie",
    "Delta",
    "Echo",
    "Foxtrot",
    "Golf",
    "Hotel",
    "India",
    "Juliet",
    "Kilo",
    "Lima",
    "Mike",
    "November",
    "Oscar",
    "Papa",
    "Quebec",
    "Romeo",
    "Sierra",
    "Tango",
    "Uniform",
    "Victor",
    "Whiskey",
    "Xray",
    "Yankee",
    "Zulu"
];

GVAR(maxPlayerCountDifference) = getNumber (missionConfigFile >> QPREFIX >> "maxPlayerCountDifference");
GVAR(minSideSwitchTime) = getNumber (missionConfigFile >> QPREFIX >> "minSideSwitchTime");
GVAR(isTimeUnlocked) = 0;
