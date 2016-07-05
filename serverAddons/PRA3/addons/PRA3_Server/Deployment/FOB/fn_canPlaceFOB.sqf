#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Checks if FOB is placeable

    Parameter(s):
    None

    Returns:
    is Rally Placeable <Bool>
*/
// Check leader
if (leader PRA3_Player != PRA3_Player) exitWith {false};

// Check vehicle
if (vehicle PRA3_Player != PRA3_Player) exitWith {false};

// Check near DPs
private _minDistance = [QGVAR(Rally_minDistance), 100] call CFUNC(getSetting); //@todo use FOB specific setting
private _rallyNearPlayer = false;
{
    private _pointDetails = GVAR(pointStorage) getVariable _x;
    if (!(isNil "_pointDetails")) then {
        private _pointPosition = _pointDetails select 1;
        if ((PRA3_Player distance _pointPosition) < _minDistance) exitWith {
            _rallyNearPlayer = true;
        };
    };
    nil
} count ([GVAR(pointStorage), QGVAR(pointStorage)] call CFUNC(allVariables));
if (_rallyNearPlayer) exitWith {false};

true
