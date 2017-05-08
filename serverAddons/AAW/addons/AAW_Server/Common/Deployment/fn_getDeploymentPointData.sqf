#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    get Deploymentpoint data from the point ID

    Parameter(s):
    0: PointID <String>
    1: Data <Array>
        0: Type Name <String>
        1: Default <Any>

    Remarks:
    Returns what the Entry Type is.
    if _type == "All" than you get a Array with all Data

    Returns:
    Name <STRING>
    Type <String>
    Position <ARRAY>
    Spawn point for <SIDE, GROUP>
    Tickets <NUMBER>
    Icon path <STRING>
    Map icon path <STRING>
    Objects <ARRAY>
*/

#define DEFAULTDATA ["", "", [0,0,0], sideUnknown, -1, "", "", [], [[], [[],[]]]]

params ["_pointID", ["_type", ""]];
// Type is a array and wants multible returns
if (_type isEqualType []) exitWith {
    private _return = [];
    {
        _return pushback ([_pointID, _x] call FUNC(getDeploymentPointData));
        nil
    } count _type;
    _return;
};
_type = toLower (_type);

if (_type isEqualTo "all") exitWith {
    LOG("Warning: All is not Supported anymore!");
    DEFAULTDATA;
};

private _pointNamespace = GVAR(DeploymentPointStorage) getVariable [_pointID, objNull];
if (isNull _pointNamespace) exitWith {
    LOG("Warning: Point does not exist or is allready deleted");
    if (_type isEqualType []) then {
        (_type select 1)
    } else {
        nil
    };
};
_pointNamespace getVariable _type;
