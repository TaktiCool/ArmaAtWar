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
        private _sectors = "true" configClasses (missionConfigFile >> "PRA3" >> "CfgSectors");

        {
            if ((configName _x find "base") >= 0) then {
                [configName _x, getArray(_x >> "dependency"), getNumber(_x >> "ticketValue"), getNumber(_x >> "minUnits"), getArray(_x >> "captureTime"), getArray(_x >> "firstCaptureTime"), getText(_x >> "designator")] call FUNC(createSectorLogic);
            };
            nil;
        } count _sectors;

        private _path = selectRandom ("true" configClasses (missionConfigFile >> "PRA3" >> "CfgSectors" >> "CfgSectorPath"));

        {
            [configName _x, getArray (_x >> "dependency"),getNumber (_x >> "ticketValue"),getNumber (_x >> "minUnits"),getArray (_x >> "captureTime"), getArray(_x >> "firstCaptureTime"), getText (_x >> "designator")] call FUNC(createSectorLogic);
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
