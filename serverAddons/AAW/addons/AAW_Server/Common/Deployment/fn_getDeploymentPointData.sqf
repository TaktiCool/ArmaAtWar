#include "macros.hpp"
/*
    Arma At War

    Author: joko // Jonas

    Description:
    Get Deploymentpoint data from the point ID

    Parameter(s):
    0: PointID <String> (Default: "")
    1: DataName <String> (Default: "all")

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

params [
    ["_pointID", "", [""]],
    ["_type", "all", [""]]
];

#define DEFAULTDATA ["", "", [0, 0, 0], sideUnknown, -1, "", "", [], [[], [[], []]]]

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
    GVAR(DeploymentPointStorage) getVariable [_pointID, DEFAULTDATA];
};
private _index = GVAR(DeploymentVarTypes) find _type;
if (_index != -1) then {
    private _data = GVAR(DeploymentPointStorage) getVariable [_pointID, DEFAULTDATA];
    _data select _index;
};
