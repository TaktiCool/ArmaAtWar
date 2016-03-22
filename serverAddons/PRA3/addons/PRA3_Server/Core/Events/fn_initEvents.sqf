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
    (_this select 0) params ["_object", "_value"];
    _object forceWalk _value;
}] call FUNC(addEventHandler);
["blockSprint", {
    (_this select 0) params ["_object", "_value"];
    _object allowSprint !_value;
}] call FUNC(addEventHandler);
["fixFloating", {
    (_this select 0) params ["_object"];
    [_object] call FUNC(fixFloating);
}] call FUNC(addEventHandler);
["setCaptive", {
    (_this select 0) params ["_object", "_value"];
    _object setCaptive _value;
}] call FUNC(addEventHandler);
["blockDamage", {
    (_this select 0) params ["_object", "_value"];
    _object allowDamage !_value;
}] call FUNC(addEventHandler);
["deleteGroup", {
    (_this select 0) params ["_group"];

    if (isServer && !(isNull _group) && !(local _group)) exitWith {
        ["deleteGroup", groupOwner _group, _group] call FUNC(targetEvent);
    };

    deleteGroup _group;
}] call FUNC(addEventHandler);
["selectLeader", {
    (_this select 0) params ["_group", "_unit"];

    if (isServer && !(isNull _group) && !(local _group)) exitWith {
        ["selectLeader", groupOwner _group, [_group, _unit]] call FUNC(targetEvent);
    };
    _group selectLeader _unit;
}] call FUNC(addEventHandler);
["switchMove", {
    (_this select 0) params ["_unit", "_move"];
    _unit switchmove _move;
}] call FUNC(addEventHandler);
