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

GVAR(defaultValues) = createHashMapFromArray [
    ["dependency", []],
    ["ticketValue", 30],
    ["minUnits", 1],
    ["maxUnits", 9],
    ["captureTime", [30, 60]],
    ["firstCaptureTime", [5, 15]],
    ["designator", ""]
];

DFUNC(compileSettingsHashMap) = {
    params ["_config"];
    private _hash = +GVAR(defaultValues);

    {
        private _key = configName _x;
        switch (true) do {
            case (isText _x): {
                _hash set [_key, getText _x];
            };
            case (isArray _x): {
                _hash set [_key, getArray _x];
            };
            case (isNumber _x): {
                _hash set [_key, getNumber _x];
            };
        };
    } forEach configProperties [_config, "!isClass _x", true];
    _hash
};

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
                private _settings = _x call FUNC(compileSettingsHashMap);
                [configName _x, _settings] call FUNC(createSectorLogic);
            };
        } forEach _sectors;

        private _path = selectRandom ("true" configClasses (missionConfigFile >> QPREFIX >> "CfgSectors" >> "CfgSectorPath"));

        {
            // we need to set the array via hand else the defaults get never Triggerd.
            private _settings = _x call FUNC(compileSettingsHashMap);
            [configName _x, _settings] call FUNC(createSectorLogic);
        } forEach ("true" configClasses _path);

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
