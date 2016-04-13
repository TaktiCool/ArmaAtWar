#include "macros.hpp"

private _cfg = configFile >> "PRA3" >> "CfgEntities";
{
    private _obj = _x;
    {
        private _var = call {
            if (isText _x) exitWith {
                getText _x;
            };
            if (isNumber _x) exitWith {
                getNumber _x;
            };
            if (isArray _x) exitWith {
                getArray _x;
            };
        };
        _obj setVariable [configName _x, _var, true];
        nil
    } count configProperties [_cfg, "true"];
    nil
} count vehicles;
#include "PREP.hpp"
