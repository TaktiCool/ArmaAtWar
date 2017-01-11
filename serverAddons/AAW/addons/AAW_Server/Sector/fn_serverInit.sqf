#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Initialize the Sector Module on Server

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(allSectors)  = objNull;
GVAR(allSectorsArray) = [];
GVAR(ServerInitDone) = false;

["missionStarted", {
    [{
        GVAR(allSectors) = (call CFUNC(getLogicGroup)) createUnit ["Logic", [0,0,0], [], 0, "NONE"];

        GVAR(allSectorsArray) = [];
        private _sectors = "true" configClasses (missionConfigFile >> QPREFIX >> "CfgSectors");

        {
            if ((configName _x find "base") >= 0) then {
                private _settings = [];
                {
                    switch (true) do {
                        case (isText (_x select 0)): {
                            _settings pushBack (getText (_x select 0));
                        };
                        case (isArray (_x select 0)): {
                            _settings pushBack (getArray (_x select 0));
                        };
                        case (isNumber (_x select 0)): {
                            _settings pushBack (getNumber (_x select 0));
                        };
                        case (isClass (_x select 0)): {
                            _settings pushBack (configName (_x select 0));
                        };
                        default {
                            _settings pushBack (_x select 1);
                        };
                    };
                } forEach [
                    [_x, ""],
                    [(_x >> "dependency"), []],
                    [(_x >> "ticketValue"), 30],
                    [(_x >> "minUnits"), 1],
                    [(_x >> "maxUnits"), 9],
                    [(_x >> "captureTime"), [30, 60]],
                    [(_x >> "firstCaptureTime"), [5,15]],
                    [(_x >> "designator"), ""]
                ];
                _settings call FUNC(createSectorLogic);
            };
            nil;
        } count _sectors;

        private _path = selectRandom ("true" configClasses (missionConfigFile >> QPREFIX >> "CfgSectors" >> "CfgSectorPath"));

        {
            // we need to set the array via hand else the defaults get never Triggerd.
            private _settings = [];
            {
                switch (true) do {
                    case (isText (_x select 0)): {
                        _settings pushBack (getText (_x select 0));
                    };
                    case (isArray (_x select 0)): {
                        _settings pushBack (getArray (_x select 0));
                    };
                    case (isNumber (_x select 0)): {
                        _settings pushBack (getNumber (_x select 0));
                    };
                    case (isClass (_x select 0)): {
                        _settings pushBack (configName (_x select 0));
                    };
                    default {
                        _settings pushBack (_x select 1);
                    };
                };
            } forEach [
                [_x, ""],
                [(_x >> "dependency"), []],
                [(_x >> "ticketValue"), 30],
                [(_x >> "minUnits"), 1],
                [(_x >> "maxUnits"), 9],
                [(_x >> "captureTime"), [30, 60]],
                [(_x >> "firstCaptureTime"), [5,15]],
                [(_x >> "designator"), ""]
            ];
            _settings call FUNC(createSectorLogic);
            nil;
        } count ("true" configClasses _path);

        call FUNC(updateDependencies);

        GVAR(ServerInitDone) = true;
        publicVariable QGVAR(allSectors);
        publicVariable QGVAR(allSectorsArray);
        publicVariable QGVAR(ServerInitDone);

    }, 3,[]] call CFUNC(wait);
}] call CFUNC(addEventhandler);



["sectorEntered", {
    (_this select 0) params ["_unit", "_sector"];

    private _varStr = format ["units%1", side _unit];

    private _unitArray = _sector getVariable [_varStr, []];
    _unitArray pushBackUnique _unit;
    _sector setVariable [_varStr, _unitArray];

    //[_sector] call FUNC(updateSectorStatus);
}] call CFUNC(addEventhandler);

["sectorLeaved", {
    (_this select 0) params ["_unit", "_sector"];

    private _varStr = format ["units%1", side _unit];

    private _unitArray = _sector getVariable [_varStr, []];

    private _ind = _unitArray find _unit;
    if (_ind >= 0) then {
        _unitArray deleteAt _ind;
        _sector setVariable [_varStr, _unitArray];

        //[_sector] call FUNC(updateSectorStatus);
    };
}] call CFUNC(addEventhandler);

["sectorSideChanged", FUNC(updateDependencies)] call CFUNC(addEventhandler);
