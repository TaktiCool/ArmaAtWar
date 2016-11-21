#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, BadGuy

    Description:
    init for TicketBleed System

    Parameter(s):
    None

    Returns:
    None
*/

DFUNC(checkTicketBleed) = {
    // Check for Ticket Bleed
    private _sectorOwner = EGVAR(Sector,allSectorsArray) apply {
        _x getVariable ["side",sideUnknown]
    };

    if (sideUnknown in _sectorOwner) exitWith {sideUnknown};

    private _nbrOwnedSectors = EGVAR(Common,competingSides) apply {
        private _side = _x;
        [{_x == _side} count _sectorOwner, _side];
    };

    _nbrOwnedSectors sort true;

    private _looser = _nbrOwnedSectors select 0;
    if ((_looser select 0) > 1) exitWith {sideUnknown};

    _looser select 1;
};


GVAR(deactivateTicketSystem) = false;
["playEndMusic", {
    playMusic (selectRandom (GVAR(availableTracks)));
    addMusicEventHandler ["MusicStop", {
        playMusic (selectRandom (GVAR(availableTracks)));
    }];
}] call CFUNC(addEventHandler);


[{
    GVAR(availableTracks) = getArray(missionConfigFile >> QPREFIX >> "tracks");

    if (GVAR(availableTracks) isEqualTo []) then {
        {
            GVAR(availableTracks) pushBackUnique (configName _x);
            nil
        } count ("true" configClasses (configFile >> "CfgMusic"));

        if (isClass (missionConfigFile >> "CfgMusic")) then {
            {
                GVAR(availableTracks) pushBackUnique (configName _x);
                nil
            } count ("true" configClasses (missionConfigFile >> "CfgMusic"));
        };
    };

    GVAR(musicStartTickets) = getNumber(missionConfigFile >> QPREFIX >> "musicStart");

    if (isServer) then {
        GVAR(playerTicketValue) = getNumber(missionConfigFile >> QPREFIX >> "playerTicketValue");
        GVAR(ticketBleed) = getArray(missionConfigFile >> QPREFIX >> "ticketBleed");


        private _startTickets = getNumber(missionConfigFile >> QPREFIX >> "tickets");
        {
            missionNamespace setVariable [format [QGVAR(sideTickets_%1), _x], _startTickets];
            publicVariable (format [QGVAR(sideTickets_%1), _x]);
            nil
        } count EGVAR(Common,competingSides);

        addMissionEventHandler ["EntityKilled", {
            params ["_killedEntity", "_killer"];
            if (_killedEntity getVariable ["ticketValue",0] > 0) exitWith {
                private _ticketValue = _killedEntity getVariable ["ticketValue",0];
                private _currentSide = _killedEntity getVariable ["side","unknown"];
                private _tickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), _currentSide];
                if !(isNil "_tickets") then {
                    _tickets = _tickets - _ticketValue;
                    missionNamespace setVariable [format [QGVAR(sideTickets_%1), _currentSide], _tickets];
                    publicVariable (format [QGVAR(sideTickets_%1), _currentSide]);
                    "ticketsChanged" call CFUNC(globalEvent);
                };
            };

            if (_killedEntity in allPlayers) exitWith {
                private _currentSide = side group _killedEntity;
                private _tickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), _currentSide];
                if !(isNil "_tickets") then {
                    _tickets = _tickets - GVAR(playerTicketValue);
                    missionNamespace setVariable [format [QGVAR(sideTickets_%1), _currentSide], _tickets];
                    publicVariable (format [QGVAR(sideTickets_%1), _currentSide]);
                    "ticketsChanged" call CFUNC(globalEvent);
                };
            };
        }];

        ["sectorSideChanged", {
            (_this select 0) params ["_sector", "_oldSide", "_newSide"];
            if (_oldSide != sideUnknown) then {
                private _tickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), _oldSide];
                if !(isNil "_tickets") then {
                    _tickets = _tickets - (_sector getVariable "ticketValue");
                    missionNamespace setVariable [format [QGVAR(sideTickets_%1), _oldSide], _tickets];
                    publicVariable (format [QGVAR(sideTickets_%1), _oldSide]);
                    "ticketsChanged" call CFUNC(globalEvent);
                };
            };

            // Check for Ticket Bleed
            private _looser = call FUNC(checkTicketBleed);

            if (_looser != sideUnknown) then {
                [{
                    (_this select 0) params ["_side"];
                    private _id = (_this select 1);

                    private _looser = call FUNC(checkTicketBleed);

                    if (_looser != _side) exitWith {
                        [_id] call CFUNC(removePerFrameHandler);
                    };

                    private _tickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), _side];
                    _tickets = _tickets - (GVAR(ticketBleed) select 1);
                    missionNamespace setVariable [format [QGVAR(sideTickets_%1), _side], _tickets];
                    publicVariable (format [QGVAR(sideTickets_%1), _side]);
                    "ticketsChanged" call CFUNC(globalEvent);
                }, GVAR(ticketBleed) select 0, [_looser]] call CFUNC(addPerFrameHandler);

            };

        }] call CFUNC(addEventhandler);

    };

    if (hasInterface) then {
        ([UIVAR(TicketStatus)] call BIS_fnc_rscLayer) cutRsc [UIVAR(TicketStatus),"PLAIN"];
        private _startTickets = getNumber(missionConfigFile >> QPREFIX >> "tickets");
        private _dialog = uiNamespace getVariable UIVAR(TicketStatus);

        (_dialog displayCtrl 2011) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1),EGVAR(Common,competingSides) select 0],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
        (_dialog displayCtrl 2012) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,sideName_%1),EGVAR(Common,competingSides) select 0],""]);
        (_dialog displayCtrl 2013) ctrlSetText str (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Common,competingSides) select 0],_startTickets]);
        (_dialog displayCtrl 2021) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1),EGVAR(Common,competingSides) select 1],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
        (_dialog displayCtrl 2022) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,sideName_%1),EGVAR(Common,competingSides) select 1],""]);
        (_dialog displayCtrl 2023) ctrlSetText str (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Common,competingSides) select 1],_startTickets]);
        missionNamespace getVariable format [QGVAR(sideTickets_%1), str(_currentSide)];
        ["ticketsChanged", {
            if (GVAR(deactivateTicketSystem)) exitWith {};
                private _dialog = uiNamespace getVariable [UIVAR(TicketStatus), displayNull];
            if !(isNull _dialog) then {
                (_dialog displayCtrl 2011) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1),EGVAR(Common,competingSides) select 0],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
                (_dialog displayCtrl 2012) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,sideName_%1),EGVAR(Common,competingSides) select 0],""]);
                (_dialog displayCtrl 2013) ctrlSetText str (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Common,competingSides) select 0],0]);
                (_dialog displayCtrl 2021) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,Flag_%1),EGVAR(Common,competingSides) select 1],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
                (_dialog displayCtrl 2022) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Common,sideName_%1),EGVAR(Common,competingSides) select 1],""]);
                (_dialog displayCtrl 2023) ctrlSetText str (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Common,competingSides) select 1],0]);
            };

            if (isNil QGVAR(musicPlay) && {(missionNamespace getVariable [format [QGVAR(sideTickets_%1), EGVAR(Common,competingSides) select 0], 1000]) <= GVAR(musicStartTickets) ||
               (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Common,competingSides) select 1], 1000]) <= GVAR(musicStartTickets)}) then {
                "playEndMusic" call CFUNC(localEvent);
                GVAR(musicPlay) = true;
            };

            if ((missionNamespace getVariable [format [QGVAR(sideTickets_%1), EGVAR(Common,competingSides) select 0], 1000]) <= 0
                || (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Common,competingSides) select 1], 1000]) <= 0) then {
                if ((missionNamespace getVariable [format [QGVAR(sideTickets_%1), side group CLib_Player], 1000]) <= 0) then {
                    ["LOOSER", false] spawn BIS_fnc_endMission;
                } else {
                    ["WINNER", true] spawn BIS_fnc_endMission;
                };

                if (isDedicated) then {
                    endMission "END1";
                };

                GVAR(deactivateTicketSystem) = true;

            };
        }] call CFUNC(addEventHandler);

        ["sectorEntered", {
            private _dialog = uiNamespace getVariable UIVAR(TicketStatus);
            if (isNull _dialog) exitWith {};
            (_dialog displayCtrl 2010) ctrlSetPosition [0.5-PX(40+21), safeZoneY];
            (_dialog displayCtrl 2020) ctrlSetPosition [0.5+PX(21), safeZoneY];
            (_dialog displayCtrl 2010) ctrlCommit 0.2;
            (_dialog displayCtrl 2020) ctrlCommit 0.2;

        }] call CFUNC(addEventHandler);

        ["sectorLeaved", {
            private _dialog = uiNamespace getVariable UIVAR(TicketStatus);
            if (isNull _dialog) exitWith {};
            (_dialog displayCtrl 2010) ctrlSetPosition [0.5-PX(40), safeZoneY];
            (_dialog displayCtrl 2020) ctrlSetPosition [0.5, safeZoneY];
            (_dialog displayCtrl 2010) ctrlCommit 0.2;
            (_dialog displayCtrl 2020) ctrlCommit 0.2;
        }] call CFUNC(addEventHandler);

    };

},{!isNil QEGVAR(Common,competingSides) && {!(EGVAR(Common,competingSides) isEqualTo [])}}] call CFUNC(waitUntil);
