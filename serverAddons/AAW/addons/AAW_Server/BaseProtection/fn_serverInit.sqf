#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Server init point of base protection system

    Parameter(s):
    None

    Returns:
    None
*/

["missionStarted", {
    [{
        private _bases = EGVAR(Sector,allSectorsArray) select {
            (_x getVariable ["dependency", []]) isEqualTo []
        } apply {
            [_x getVariable ["marker", ""], _x getVariable ["side", sideUnknown]]
        };

        GVAR(protectVehiclesSM) = call CFUNC(createStatemachine);

        [GVAR(protectVehiclesSM), "fillVehicles", {
            GVAR(vehicles) = vehicles;
            "checkVehicle"
        }] call CFUNC(addStatemachineState);

        [GVAR(protectVehiclesSM), "checkVehicle", {
            params ["_bases"];

            if (GVAR(vehicles) isEqualTo []) exitWith {"fillVehicles"};

            private _vehicle = GVAR(vehicles) deleteAt 0;
            if (isNull _vehicle) exitWith {"checkVehicle"};

            private _protected = false;
            {
                _x params ["_marker", "_side"];
                if (_vehicle inArea _marker && (_vehicle getVariable ["side", sideUnknown]) isEqualTo _side) exitWith {
                    _protected = true;
                };
                nil
            } count _bases;

            if !((_vehicle getVariable [QGVAR(protected), false]) isEqualTo _protected) then {
                _vehicle allowDamage !_protected;
                _vehicle setVariable [QGVAR(protected), _protected, true];
            };

            "checkVehicle"
        }, _bases] call CFUNC(addStatemachineState);

        [GVAR(protectVehiclesSM), "fillVehicles"] call CFUNC(startStatemachine);
    }, {
        !isNil QEGVAR(Sector,ServerInitDone) && {EGVAR(Sector,ServerInitDone)}
    }] call CFUNC(waitUntil);
}] call CFUNC(addEventHandler);

