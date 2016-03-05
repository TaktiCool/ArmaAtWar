#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Handles "Join/Leave"-Button Events

    Parameter(s):
    0: Button <Control>

    Returns:
    None
*/
(_this select 0) params ["_btn"];
disableSerialization;

private _playerId = lnbData [207,[lnbCurSelRow 209,0]];

[group PRA3_player, objectFromNetId _playerId] remoteExec ["selectLeader", groupOwner PRA3_player];
