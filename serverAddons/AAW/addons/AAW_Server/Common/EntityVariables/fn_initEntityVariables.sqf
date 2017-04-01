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
    private _entityClasses = +([(configFile >> "CfgVehicles" >> _entityClass), true] call CFUNC(returnParents));
    reverse _entityClasses;
    _entityClasses pushBack _entityClass;
    _entityClasses pushBack (vehicleVarName _entity);
    _entityClasses pushBack (str _entity);
    {
        private _currentEntityClass = QUOTE(PREFIX/CfgEntities/) + _x;
        {
            private _var = [_currentEntityClass + "/" + _x] call CFUNC(getSetting);
            _entity setVariable [_x, _var];
            nil
        } count ([_currentEntityClass] call CFUNC(getSettings));
        nil
    } count _entityClasses;
}] call CFUNC(addEventhandler);
