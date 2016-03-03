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
    {
        _x params ["_varName", "_value"];
        GVAR(LoadoutCache) setVariable [_varName, _value];
        nil
    } count (_this select 0);
}] call CFUNC(addEventhandler);


if (isServer) then {
    {
        {
            [_x] call FUNC(Loadout_loadConfig);
        } count ("true" configClasses (_x));
    } count ("true" configClasses (missionConfigFile >> "PRA3" >>"Loadouts"));
};
