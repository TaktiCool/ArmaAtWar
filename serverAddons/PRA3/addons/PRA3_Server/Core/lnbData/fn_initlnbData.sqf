#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    init for ListBox Data

    Parameter(s):
    None

    Returns:
    None
*/
GVAR(lnbDataStorage) = call FUNC(createNamespace);
GVAR(lnbDataStorage) setVariable [QGVAR(allVariablesCache), []];

// PFH for Flushing Data
[{
    if (!dialog) then {
        private _allVars = GVAR(lnbDataStorage) getVariable QGVAR(allVariablesCache);

        // Flush Data
        {
            GVAR(lnbDataStorage) setVariable [_x, nil];
        } count _allVars;

        GVAR(lnbDataStorage) setVariable [QGVAR(allVariablesCache), []];
    };
}, 5] call CFUNC(addPerFrameHandler);
