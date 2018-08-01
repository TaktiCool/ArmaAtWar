#include "macros.hpp"
/*
    Arma At War - AAW

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
    private _entityClasses = [(str _entity), (vehicleVarName _entity), _entityClass];
    _entityClasses append ([(configFile >> "CfgVehicles" >> _entityClass), true] call CFUNC(returnParents));
    reverse _entityClasses;
    {
        private _currentEntityClass = QUOTE(PREFIX/CfgEntities) + "/" + _x;
        {
            private _var = [_currentEntityClass + "/" + _x] call CFUNC(getSetting);
            _entity setVariable [_x, _var];
            nil
        } count ([_currentEntityClass] call CFUNC(getSettings));
        nil
    } count _entityClasses;
}] call CFUNC(addEventhandler);
