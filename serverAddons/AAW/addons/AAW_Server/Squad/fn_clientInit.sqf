#include "macros.hpp"
/*
    Project Reality ArmA 3

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

GVAR(restirctSideSwitchRestrictionCount) = getNumber(missionConfigFile >> QPREFIX >> "restirctSideSwitchRestrictionCount");
GVAR(restirctSideSwitchRestrictionTime) = getNumber(missionConfigFile >> QPREFIX >> "restirctSideSwitchRestrictionTime");
GVAR(isTimeUnlocked) = 0;
