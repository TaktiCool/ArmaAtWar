#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    init for Events

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(EventNamespace) = call EFUNC(Core,createNamespace);

["hideObject", {
    (_this select 0) params ["_object", "_value"];
    _object hideObjectGlobal _value;
}] call FUNC(addEventhandler);
["enableSimulation", {
    (_this select 0) params ["_object", "_value"];
    _object enableSimulationGlobal _value;
}] call FUNC(addEventhandler);
["forceWalk", {
    (_this select 0) params ["_object", "_set"];
    _object forceWalk (_set > 0);
}] call FUNC(addEventHandler);
["blockSprint", {
    (_this select 0) params ["_object", "_set"];
    _object allowSprint (_set == 0);
}] call FUNC(addEventHandler);
["setCaptive", {
    (_this select 0) params ["_object", "_set"];
    _object setCaptive (_set > 0);
}] call FUNC(addEventHandler);
["blockDamage", {
    (_this select 0) params ["_object", "_set"];
    _object allowDamage (_set == 0);
}] call FUNC(addEventHandler);
