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
    _x params [["_req", ""], ["_ret", []]];
    private _return = [];
    {
        private _re = [_x, [[_req, false]]] call CFUNC(getLoadoutDetail);
        if !(_re isEqualType false) then {
            _ret append _re;
        };
    } count _loadouts;
    _ret;
};
