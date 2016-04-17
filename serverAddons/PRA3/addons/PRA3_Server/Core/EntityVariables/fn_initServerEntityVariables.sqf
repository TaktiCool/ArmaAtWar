#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Init for EntityVariables

    Parameter(s):
    None

    Returns:
    None
*/

["entityCreated", {
    (_this select 0) params ["_entity"];
    private _entityClass = typeOf _entity;
    private _entityClasses = [_entityClass];
    _entityClasses append ([(configFile >> "CfgVehicles" >> _entityClass), true] call BIS_fnc_returnParents);
    _entityClasses pushBack vehicleVarName _entity;
    {
        {
            private _var = call {
                if (isText _x) exitWith {
                    getText _x;
                };
                if (isNumber _x) exitWith {
                    getNumber _x;
                };
                if (isArray _x) exitWith {
                    getArray _x;
                };
            };
            _entity setVariable [configName _x, _var, true];
            nil
        } count configProperties [(missionConfigFile >> "PRA3" >> "CfgEntities" >> _x), "true"];
        nil
    } count _entityClasses;
}] call FUNC(addEventhandler);
