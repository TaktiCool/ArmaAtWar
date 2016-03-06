#include "macros.hpp"

// Rating system
["sideChanged", {
    (_this select 0) params ["_currentSide", "_oldSide"];

    if (_currentSide == sideEnemy) then {
        _rating = rating PRA3_player;
        PRA3_player addRating (0 - _rating);
    };
}] call CFUNC(addEventhandler);
