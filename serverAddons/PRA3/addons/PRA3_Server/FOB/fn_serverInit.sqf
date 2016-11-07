#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Server Init

    Parameter(s):
    -

    Returns:
    -
*/

GVAR(namespace) = false call CFUNC(createNamespace);

[QGVAR(startDestroyTimer), {
    (_this select 0) params ["_name"];
    private _pfhId = [{
        (_this select 0) params ["_name"];
        private _data = [GVAR(namespace), _name, []] call CFUNC(getVariable);
        _data params ["_pfhId", ["_time", -1]];
        DUMP(_time)
        DUMP(time)
        if (_time < 0) exitWith {
            _pfhId call CFUNC(removePerFrameHandler);
        };
        if (_time > time) exitWith {};

        [_name] call EFUNC(Common,removeDeploymentPoint);


    }, 0.1, [_name]] call CFUNC(addPerFrameHandler);
    GVAR(namespace) setVariable [_name, [_pfhId, time + 30]];
    [{
        params ["_name"];

        private _item = [EGVAR(Common,DeploymentPointStorage), _name, []] call CFUNC(getVariable);

        if (_item isEqualTo []) exitWith {};
        _item set [8, [1]];
        [EGVAR(Common,DeploymentPointStorage), _name, _item, QEGVAR(Common,DeploymentPointStorage), true] call CFUNC(setVariable);
    }, [_name], "respawn"] call CFUNC(mutex);
}] call CFUNC(addEventhandler);

[QGVAR(stopDestroyTimer), {
    (_this select 0) params ["_name"];
    private _data = [GVAR(namespace), _name, []] call CFUNC(getVariable);
    _data params ["_pfhId", ["_time", -1]];
    if (_time > time) then {
        _pfhId call CFUNC(removePerFrameHandler);
        GVAR(namespace) setVariable [_name, [-1, -1]];
    };

    [{
        params ["_name"];

        private _item = [EGVAR(Common,DeploymentPointStorage), _name, []] call CFUNC(getVariable);

        if (_item isEqualTo []) exitWith {};
        _item set [8, [0]];
        [EGVAR(Common,DeploymentPointStorage), _name, _item, QEGVAR(Common,DeploymentPointStorage), true] call CFUNC(setVariable);
    }, [_name], "respawn"] call CFUNC(mutex);
}] call CFUNC(addEventhandler);
