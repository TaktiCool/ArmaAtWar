#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Adds the Infantery Resupply Action

    Parameter(s):
    None

    Returns:
    None
*/


private _title = MLOC(Resupply);
private _iconIdle = "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unloadDevice_ca.paa";
private _iconProgress = "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unloadDevice_ca.paa";
private _condition = {
    [_target, 3] call CFUNC(inRange)
    && {!((_target getVariable ["supplyType", []]) arrayIntersect ["Ammo", "AmmoInfantery", "Medical"] isEqualTo [])
    && {(_target getVariable ["supplyPoints", 0]) > 0}}
};

private _onStart = {
    params ["_target", "_caller"];

    private _jobData = [];

    (CLib_player getVariable [QGVAR(supplyData), [[], []]]) params ["_supplyDataNames", "_supplyData", "_supplyCost"];

    private _currentSupplyData = call FUNC(generateSupplyData);

    private _jobData = [];
    {
        _x params ["_type", "_name", "_count"];
        private _idx = (_currentSupplyData select 0) find _name;
        private _currentCount = [];

        if (_idx >= 0) then {
            ((_currentSupplyData select 1) select _idx) params ["_type", "_name", "_count"];
            _currentCount = _count;
        };
        _idx = 0;
        private _jobDataElement = _count apply {
            private _n = if (count _currentCount > _idx) then {
                (_currentCount select _idx);
            } else {
                0
            };
            _idx = _idx + 1;
            [(_supplyCost select _forEachIndex)*(_x - _n), _n, _x];
        };
        _jobDataElement sort true;
        private _totalSupplyCost = 0;
        {
            _totalSupplyCost = _totalSupplyCost + (_supplyCost select _forEachIndex)*_x
        } count _count;

        _jobData pushBack [_type, _name, _jobDataElement, _totalSupplyCost];
    } forEach _supplyData;

    if !((_target getVariable ["supplyType", []]) arrayIntersect ["AmmoInfantery", "Ammo"] isEqualTo []) then {


    };

    if ("Medical" in (_target getVariable ["supplyType", []])) then {

    };

    private _totalSupplyCost = 0;
    {
        _x params ["_type", "_name", "_elements"];
        private _cost = 0;
        {
            _cost = _cost + (_x select 0);
            nil;
        } count _elements;
        _totalSupplyCost = _totalSupplyCost + _cost;
        nil;
    } count _jobData;

    CLib_player setVariable [QGVAR(JobData), _jobData];
    CLib_player setVariable [QGVAR(ResupplyTime), time];



};

[QGVAR(CollectSupplies), {
    (_this select 0) params ["_source", "_target", ["_points", 0]];

    private _jobData = CLib_player getVariable [QGVAR(JobData), []];
    private _collectedSupplies = CLib_player getVariable [QGVAR(CollectedSupplies), []];

    private _amount = _jobData apply {
        _x params ["_type", "_name", "_elements", "_tsc"];
        private _cost = 0;
        {
            _cost = _cost + (_x select 0);
        } count _elements;
        _cost / _tsc;
    };
    private _sumAmount = 0;
    {
        _sumAmount = _sumAmount + _x;
        nil
    } count _amount;

    DUMP(_sumAmount);

    {
        _collectedSupplies set [_forEachIndex, _x + (_amount select _forEachIndex)/_sumAmount*_points];
    } forEach _collectedSupplies;

    DUMP(_collectedSupplies);

    {
        _x params ["_type", "_name", "_elements", "_tsc"];
        private _availableSupplies = _collectedSupplies select _forEachIndex;
        {
            _x params ["_cost", "_currentCount", "_desiredCount"];
            if (_cost <= _availableSupplies && _cost > 0) then {
                _availableSupplies = _availableSupplies - _cost;
                _x set [0, 0];
                _x set [1, _x select 2];
            };
            nil;
        } count _elements;
        _collectedSupplies set [_forEachIndex, _availableSupplies];
    } forEach _jobData;

    {
        _x params ["_type", "_name", "_elements", "_tsc"];
        if (_type == ST_MAGAZINE) then {
            CLib_player removeMagazines _name;
            {
                if (_x select 0 == 0 && _x select 1 > 0) then {
                    CLib_player addMagazine [_name, _x select 1];
                };
            } forEach _elements;
        };

        if (_type == ST_ITEM) then {
            CLib_player removeItems _name;
            {
                if (_x select 0 == 0 && _x select 1 > 0) then {
                    CLib_player addItem _name;
                };
            } forEach _elements;
        };
    } forEach _jobData;



}] call CFUNC(addEventHandler);

private _onProgress = {
    params ["_target", "_caller"];

    private _startTime = CLib_player getVariable [QGVAR(ResupplyTime), time];

    private _jobData = CLib_player getVariable [QGVAR(JobData), []];
    private _collectedSupplies = CLib_player getVariable [QGVAR(CollectedSupplies), []];

    private _currentSupplyCost = 0;
    private _totalSupplyCost = 0;
    {
        _x params ["_type", "_name", "_elements", "_tsc"];
        private _cost = 0;
        {
            _cost = _cost + (_x select 0);
        } count _elements;
        _currentSupplyCost = _currentSupplyCost + _cost;
        _totalSupplyCost = _totalSupplyCost + _tsc;
    } forEach _jobData;

    if (time - _startTime >= 1) then {
        [QGVAR(RequestSupplies), [_target, CLib_player, 5 min _currentSupplyCost]] call CFUNC(serverEvent);
        CLib_player setVariable [QGVAR(ResupplyTime), time];
    };

    (_totalSupplyCost -_currentSupplyCost) / _totalSupplyCost;

};

private _onComplete = {

    params ["_target", "_caller"];


};

private _onInterruption = _onComplete;

["All", _title, _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress, _onComplete, _onInterruption, [], 5000, true, false, ["isNotUnconscious"]] call CFUNC(addHoldAction);
