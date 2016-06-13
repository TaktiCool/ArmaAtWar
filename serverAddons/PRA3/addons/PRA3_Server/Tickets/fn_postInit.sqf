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


GVAR(deactivateTicketSystem) = false;
["playEndMusic", {
    playMusic (selectRandom (GVAR(availableTracks)));
    addMusicEventHandler ["MusicStop", {
        playMusic (selectRandom (GVAR(availableTracks)));
    }];
}] call CFUNC(addEventHandler);


[{
    GVAR(availableTracks) = getArray(missionConfigFile >> "PRA3" >> "tracks");

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

    GVAR(musicStartTickets) = getNumber(missionConfigFile >> "PRA3" >> "musicStart");

    if (isServer) then {
        GVAR(playerTicketValue) = getNumber(missionConfigFile >> "PRA3" >> "playerTicketValue");
        GVAR(ticketBleed) = getArray(missionConfigFile >> "PRA3" >> "ticketBleed");


        private _startTickets = getNumber(missionConfigFile >> "PRA3" >> "tickets");
        {
            missionNamespace setVariable [format [QGVAR(sideTickets_%1), _x], _startTickets];
            publicVariable (format [QGVAR(sideTickets_%1), _x]);
            nil
        } count EGVAR(Mission,competingSides);

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

            private _looserSide = sideUnknown;
            private _nbrOwnedSectors = {
                private _condition = !((_x getVariable ["side",sideUnknown]) in [_newSide]);
                if (_condition) then {
                    _looserSide = _x getVariable ["side",sideUnknown];
                };
                _condition
            } count EGVAR(Sector,allSectorsArray);



            if (_nbrOwnedSectors == 1) then {
                [{
                    (_this select 0) params ["_side","_opposingSide"];
                    private _id = (_this select 1);

                    private _nbrOwnedSectors = {
                        !((_x getVariable ["side",sideUnknown]) in [_opposingSide]);
                    } count GVAR(allSectorsArray);

                    if (_nbrOwnedSectors > 1) exitWith {
                        [_id] call CFUNC(removePerFrameHandler);
                    };

                    private _tickets = missionNamespace getVariable format [QGVAR(sideTickets_%1), _side];
                    _tickets = _tickets - (GVAR(ticketBleed) select 1);
                    missionNamespace setVariable [format [QGVAR(sideTickets_%1), _side], _tickets];
                    publicVariable (format [QGVAR(sideTickets_%1), _side]);
                    "ticketsChanged" call CFUNC(globalEvent);


                }, GVAR(ticketBleed) select 0, [_looserSide, _newSide]] call CFUNC(addPerFrameHandler);
            };
        }] call CFUNC(addEventhandler);


    };

    if (hasInterface) then {
        ([UIVAR(TicketStatus)] call BIS_fnc_rscLayer) cutRsc [UIVAR(TicketStatus),"PLAIN"];
        private _startTickets = getNumber(missionConfigFile >> "PRA3" >> "tickets");
        disableSerialization;
        private _dialog = uiNamespace getVariable UIVAR(TicketStatus);
        (_dialog displayCtrl 2001) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1),EGVAR(Mission,competingSides) select 0],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
        (_dialog displayCtrl 2002) ctrlSetText str (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Mission,competingSides) select 0],_startTickets]);
        (_dialog displayCtrl 2003) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1),EGVAR(Mission,competingSides) select 1],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
        (_dialog displayCtrl 2004) ctrlSetText str (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Mission,competingSides) select 1],_startTickets]);
        missionNamespace getVariable format [QGVAR(sideTickets_%1), str(_currentSide)];
        ["ticketsChanged", {
            disableSerialization;
            if (GVAR(deactivateTicketSystem)) exitWith {};
            private _dialog = uiNamespace getVariable UIVAR(TicketStatus);
            (_dialog displayCtrl 2001) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1),EGVAR(Mission,competingSides) select 0],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
            (_dialog displayCtrl 2002) ctrlSetText str (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Mission,competingSides) select 0],0]);
            (_dialog displayCtrl 2003) ctrlSetText (missionNamespace getVariable [format [QEGVAR(Mission,Flag_%1),EGVAR(Mission,competingSides) select 1],"#(argb,8,8,3)color(0.5,0.5,0.5,1)"]);
            (_dialog displayCtrl 2004) ctrlSetText str (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Mission,competingSides) select 1],0]);

            if (isNil QGVAR(musicPlay) && {(missionNamespace getVariable [format [QGVAR(sideTickets_%1), EGVAR(Mission,competingSides) select 0], 1000]) <= GVAR(musicStartTickets) ||
               (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Mission,competingSides) select 1], 1000]) <= GVAR(musicStartTickets)}) then {
                "playEndMusic" call CFUNC(localEvent);
                GVAR(musicPlay) = true;
            };

            if ((missionNamespace getVariable [format [QGVAR(sideTickets_%1), EGVAR(Mission,competingSides) select 0], 1000]) <= 0
                || (missionNamespace getVariable [format [QGVAR(sideTickets_%1),EGVAR(Mission,competingSides) select 1], 1000]) <= 0) then {
                if ((missionNamespace getVariable [format [QGVAR(sideTickets_%1), side group PRA3_Player], 1000]) <= 0) then {
                    ["LOOSER", false] spawn BIS_fnc_endMission;
                } else {
                    ["WINNER", true] spawn BIS_fnc_endMission;
                };

                GVAR(deactivateTicketSystem) = true;

            };
        }] call CFUNC(addEventHandler);

    };

},{!isNil QEGVAR(Mission,competingSides) && {!(EGVAR(Mission,competingSides) isEqualTo [])}}] call CFUNC(waitUntil);
