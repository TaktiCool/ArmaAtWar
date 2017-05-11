#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas

    Description:
    get Deploymentpoint data from the point ID

    Parameter(s):
    0: PointID <String>
    1: DataName <String>
    2: Data <Any>

    Returns:
    None
*/

params ["_pointID", "_dataName", "_data"];

_dataName = toLower _dataName;
if (_dataName isEqualTo "all") exitWith {LOG("Warning: All is not Supported anymore!")};

private _namespace = GVAR(DeploymentPointStorage) getVariable [_pointID, objNull];

private _oldData = _namespace getVariable _dataName;

// we dont need to resend if the data is equal
if (_oldData isEqualTo _data) exitWith {};

_namespace setVariable [_dataName, _data, true];
["DeploymentPointDataChanged", [_pointID, _dataName]] call CFUNC(globalEvent);
