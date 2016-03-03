#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    Init Loadout Module

    Parameter(s):
    0: Argument Name <TYPE>

    Returns:
    0: Return Name <TYPE>
*/
GVAR(LoadoutCache) = call CFUNC(createNamespace);
["saveLoadout", {
    params ["_loadoutVar", "_value"];
    GVAR(LoadoutCache) setVariable [_loadoutVar, _value];
}] call CFUNC(addEventhandler);


if (isServer) then {
    {
        {
            [_x] call FUNC(Loadout_loadConfig);
            nil
        } count ("true" configClasses (_x));
        nil
    } count ("true" configClasses (missionConfigFile >> "PRA3" >>"Loadouts"));
};
