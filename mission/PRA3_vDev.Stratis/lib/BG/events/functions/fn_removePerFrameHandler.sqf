#include "script_macros.hpp"
params ["_handlerIndex"];

diag_log format["PFH removed", _handlerIndex];

if (count GVAR(perFrameHandlers) > _handlerIndex) then {
    GVAR(perFrameHandlers) set [_handlerIndex, -1];
};
