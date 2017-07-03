#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    get Loadout details

    Parameter(s):
    0: Kit name
    1: Requested details <Array>

    Returns:
    Array With all Strings <Array>
*/
params ["_kitName", "_request"];

private "_loadouts";
if (_kitName isEqualType []) then {
    _loadouts = _kitName;
} else {
    private _kitDetails = [_kitName, [["loadouts", ["basic"]]]] call FUNC(getKitDetails);
    _loadouts = _kitDetails select 0;
};

_request apply {
    _x params [["_req", ""], ["_default", []]];
    private _return = [];
    {
        private _re = [_x, [[_req, _default]]] call CFUNC(getLoadoutDetails);
        if (_re isEqualType []) then {
            if ((_re select 0) isEqualType []) then {
                _return append (_re select 0);
            } else {
                _return pushBack (_re select 0);
            }
        };
        nil
    } count _loadouts;
    _return;
};
