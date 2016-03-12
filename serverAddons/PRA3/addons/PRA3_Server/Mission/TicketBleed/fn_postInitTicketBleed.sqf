#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas

    Description:
    init for TicketBleed System

    Parameter(s):
    None

    Returns:
    None
*/

[{
    GVAR(MissionTicketBleed) = [];
    GVAR(MissionTicketBleedMan) = getNumber(missionConfigFile >> "PRA3" >> "playerTicketValue");
    GVAR(lastSectorTicketBleedPFH) = -1;
    GVAR(TicketLostLastFlag) = getArray(missionConfigFile >> "PRA3" >> "CfgTicketBleed" >> "TicketLostLastFlag");

    private _startTickets = getNumber(missionConfigFile >> "PRA3" >> "tickets");
    {
        missionNamespace setVariable [format [QGVAR(sideTickets_%1), _x], _startTickets];
        publicVariable (format [QGVAR(sideTickets_%1), _x]);
        nil
    } count GVAR(competingSides);

    addMissionEventHandler ["EntityKilled", {
        params ["_killedEntity", "_killer"];
        if ((typeOf _killedEntity) isKindOf "CAManBase") then {
            private _currentSide = side group _killedEntity;
            private _tickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), str(_currentSide)];
            if !(isNil "_tickets") then {
                _tickets = _tickets - GVAR(MissionTicketBleedMan);
                missionNamespace setVariable [format [QGVAR(sideTickets_%1), str(_currentSide)], _tickets];
                publicVariable (format [QGVAR(sideTickets_%1), str(_currentSide)]);
                ["ticketsChanged"] call CFUNC(globalEvent);
            };
        } else {
            private _tickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), str(_currentSide)];
            if !(isNil "_tickets") then {
                scopeName "loop";
                {
                    _x params ["_class", "_ticket", "_side"];
                    if ((typeOf _killedEntity) isKindOf _class) then {
                        _tickets = _tickets - _ticket;
                        missionNamespace setVariable [format [QGVAR(sideTickets_%1), str(_currentSide)], _tickets];
                        publicVariable (format [QGVAR(sideTickets_%1), _side]);
                        breakOut "loop";
                    };
                    nil
                } count GVAR(MissionTicketBleed);
            };
        };
    }];

    ["sector_side_changed", {
        (_this select 0) params ["_sector", "_oldSide", "_newSide"];
        private _tickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), str(_oldSide)];
        if !(isNil "_tickets") then {
            _tickets = _tickets - (_sector getVariable "ticketBleed");
            missionNamespace setVariable [format [QGVAR(sideTickets_%1), str(_currentSide)], _tickets];
            publicVariable (format [QGVAR(sideTickets_%1), str(_currentSide)]);
            ["ticketsChanged"] call CFUNC(globalEvent);
        };

        if (GVAR(lastSectorTicketBleedPFH) != -1) then {
            [GVAR(lastSectorTicketBleedPFH)] call CFUNC(removePerFrameHandler);
        };

        if (!(_sector getVariable ["isLastSector", ""] isEqualTo "") && {_sector getVariable ["isLastSector", ""] == str(_newSide)}) then {
            GVAR(lastSectorTicketBleedPFH) = [{
                (_this select 0) params ["_side"];
                private _tickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), _side];
                _tickets = _tickets - GVAR(TicketLostLastFlag) select 1;
                missionNamespace setVariable [format [QGVAR(sideTickets_%1), str(_currentSide)], _tickets];
                publicVariable (format [QGVAR(sideTickets_%1), str(_currentSide)]);
                ["ticketsChanged"] call CFUNC(globalEvent);
            }, _sector getVariable ["isLastSector", ""], GVAR(TicketLostLastFlag) select 0] call CFUNC(addPerFrameHandler);
        };
    }] call CFUNC(addEventhandler);

},{!isNil QGVAR(competingSides) && {!(GVAR(competingSides) isEqualTo [])}}] call CFUNC(waitUntil);

["ticketsChanged", {
    hint str ["Tickets Changed",_this];
}] call CFUNC(addEventhandler);
