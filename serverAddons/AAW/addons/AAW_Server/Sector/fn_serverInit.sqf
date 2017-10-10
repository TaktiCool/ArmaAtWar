#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Initialize the Sector Module on Server

    Parameter(s):
    None

    Returns:
    None
*/

GVAR(allSectors) = objNull;
GVAR(allSectorsArray) = [];
GVAR(ServerInitDone) = false;

["missionStarted", {
    // hide only sectors so that other marker that are other kind of markers dont get hidden after mission start
    private _sectorPaths = "true" configClasses (missionConfigFile >> QPREFIX >> "CfgSectors" >> "CfgSectorPath");
    {
        {
            (configName _x) setMarkerAlpha 0;
            nil
        } count ("true" configClasses _x);
        nil
    } count _sectorPaths;
    [{
        GVAR(allSectors) = true call CFUNC(createNameSpace);

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
                    [(_x >> "firstCaptureTime"), [5, 15]],
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
                [(_x >> "firstCaptureTime"), [5, 15]],
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

    }, 3, []] call CFUNC(wait);
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

GVAR(AISM) = call CFUNC(createStatemachine);

[GVAR(AISM), "init", {
    private _units = +(allUnits select {!isPlayer _x});
    [["processAI", [_units]], "init"] select (_units isEqualTo []);
}] call CFUNC(addStatemachineState);

[GVAR(AISM), "processAI", {
    params ["_dummy", "_data"];
    _data params ["_units"];
    if (!(_units isEqualTo [])) then {
        private _unit = _units deleteAt 0;

        while {isPlayer _unit && {!(_units isEqualTo [])}} do {
            _unit = _units deleteAt 0;
        };

        if (!(_units isEqualTo [])) then {
            if (isNil QGVAR(allSectorsArray)) exitWith {};
            scopeName "MAIN";
            private _currentSector = _unit getVariable [QGVAR(currentSector), objNull];

            if (alive _unit) then {
                {
                    private _marker = _x getVariable ["marker", ""];
                    if (_marker != "") then {
                        if (_unit inArea _marker) then {
                            if (_currentSector != _x) then {
                                if (!isNull _currentSector) then {
                                    ["sectorLeaved", [_unit, _currentSector]] call CFUNC(localEvent);
                                };
                                _currentSector = _x;
                                _unit setVariable [QGVAR(currentSector), _currentSector];
                                ["sectorEntered", [_unit, _currentSector]] call CFUNC(localEvent);
                            };
                            breakOut "MAIN";
                        };
                    };
                    nil;
                } count GVAR(allSectorsArray);
            };

            if (!isNull _currentSector) then {
                _unit setVariable [QGVAR(currentSector), objNull];
                ["sectorLeaved", [CLib_Player, _currentSector]] call CFUNC(localEvent);
            };

        };

    };


    [["processAI", [_units]], "init"] select (_units isEqualTo []);

}] call CFUNC(addStatemachineState);

[GVAR(AISM), "init"] call CFUNC(startStateMachine);
