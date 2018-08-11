#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Generates Supply data structure (for player)

    Parameter(s):
    None

    Returns:
    None
*/
private _supplyType = [];
private _supplyNames = [];
private _supplyCount = [];
private _supplyCost = [];

{
    private _idx = _supplyNames pushBackUnique _x;
    private _count = [];
    if (_idx == -1) then {
        _idx = _supplyNames find _x;
        _count = (_supplyCount select _idx);
    };
    _count pushback 1;
    _supplyCount set [_idx, _count];
    _supplyType set [_idx, ST_ITEM];
    nil;
} count items CLib_player;

{
    private _idx = _supplyNames pushBackUnique (_x select 0);
    private _count = [];
    if (_idx == -1) then {
        _idx = _supplyNames find (_x select 0);
        _count = _supplyCount select _idx;
    };
    private _ammoCount = [configFile >> "CfgMagazines" >> (_x select 0) >> "count"] call CFUNC(getConfigDataCached);
    if (_x select 3 > 0) then {
        //_count pushBack _ammoCount;
    } else {
        _count pushBack (_x select 1);
    };

    _supplyCount set [_idx, _count];
    _supplyType set [_idx, ST_MAGAZINE];
    nil;
} count magazinesAmmoFull CLib_player;

private _supplyData = [];

{
    _supplyData pushback [
        _supplyType select _forEachIndex,
        _x,
        _supplyCount select _forEachIndex
    ];
} forEach _supplyNames;

[_supplyNames, _supplyData];
