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
    private _var = _this select 0;
    (_var select 0) hideObjectGlobal (_var select 1)
}] call FUNC(addEventhandler);
["enableSimulation", {
    private _var = _this select 0;
    (_var select 0) enableSimulationGlobal (_var select 1)
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
