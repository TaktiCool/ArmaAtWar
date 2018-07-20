#include "macros.hpp"
/*
    Arma At War - AAW

    Author: NetFusion

    Description:
    Client init of supply module

    Parameter(s):
    None

    Returns:
    None
*/
if (side CLib_player == sideLogic && {player isKindOf "VirtualSpectator_F"}) exitWith {};

["entityCreated", {
    params ["_object"];

    private _rearmAmount = _object getVariable ["rearmAmountInfantery", -1];
    if (_rearmAmount == -1) exitWith {};

    private _title = MLOC(Resupply);
    private _iconIdle = "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unloadDevice_ca.paa";
    private _iconProgress = "\a3\ui_f\data\IGUI\Cfg\HoldActions\holdAction_unloadDevice_ca.paa";
    private _condition = {
         (_target distance CLib_Player < 3)
         && (_target getVariable ["rearmAmountInfantery", -1]) > 0
    };

    private _onStart = {
        params ["_target", "_caller"];

        private _kitName = _caller getVariable [QEGVAR(Kit,kit), ""];

        if (_kitName == "") exitWith {};

        private _kitDetails = [_kitName, side group _caller, [
                ["primaryMagazine", ""], ["primaryMagazineCount", 0], ["primaryMagazineTracer", ""], ["primaryMagazineTracerCount", 0],
                ["secondaryMagazine", ""], ["secondaryMagazineCount", 0],
                ["handgunMagazine", ""], ["handgunMagazineCount", 0],
                ["items", []]
        ], true] call EFUNC(Kit,getKitDetails);

        _kitDetails params [
            "_primaryMagazine", "_primaryMagazineCount", "_primaryMagazineTracer", "_primaryMagazineTracerCount",
            "_secondaryMagazine", "_secondaryMagazineCount",
            "_handgunMagazine", "_handgunMagazineCount",
            "_items"
        ];

        private _kitMagazineData = [
            [_primaryMagazine, _primaryMagazineCount],
            [_primaryMagazineTracer, _primaryMagazineTracerCount],
            [_secondaryMagazine, _secondaryMagazineCount],
            [_handgunMagazine, _handgunMagazineCount]
        ];

        private _currentMagazines = magazinesAmmoFull CLib_player;

        {
            private _item = _x;
            if (_item isEqualType "") then {
                _item = [_item, 1];
            };

            _item params ["_type", "_count"];

            if (isClass (configFile >> "CfgMagazines" >> _type)) then {
                private _found = false;
                _kitMagazineData = _kitMagazineData apply {
                    if (toLower (_x select 0) == toLower _type) then {
                        _found = true;
                        [_type, (_x select 1) + _count];
                    } else {
                        _x;
                    };
                };
                if (!_found) then {
                    _kitMagazineData pushBack _item;
                };
            };
            nil
        } count _items;

        private _magazineData = [];
        private _totalCost = 0;

        {
            _x params ["_selectedMagazine", "_selectedMagazineDesiredCount"];

            if !(_selectedMagazine isEqualTo "") then {
                private _selectedMagazineAmmoCount = [configFile >> "CfgMagazines" >> _selectedMagazine >> "count"] call CFUNC(getConfigDataCached);
                private _selectedAmmoType = [configFile >> "CfgMagazines" >> _selectedMagazine >> "ammo"] call CFUNC(getConfigDataCached);
                private _selectedMagazineAmmoCost = [configFile >> "CfgAmmo" >> _selectedAmmoType >> "cost"] call CFUNC(getConfigDataCached);
                private _nbrOwnedMagazines = {
                    if (toLower (_x select 0) isEqualTo toLower _selectedMagazine) then {
                        private _currentAmmo = _x select 1;
                        if (!((_x select 3) > 0) && _currentAmmo > 0) then {
                            private _cost = ceil sqrt ((_selectedMagazineAmmoCount - _currentAmmo) * _selectedMagazineAmmoCost);
                            _totalCost = _totalCost + _cost;
                            _magazineData pushBack [_cost, _selectedMagazine, _currentAmmo, _selectedMagazineAmmoCount];
                        };

                        true;
                    } else {
                        false;
                    };
                } count _currentMagazines;

                private _cost = ceil sqrt (_selectedMagazineAmmoCount * _selectedMagazineAmmoCost);
                for "_k" from 1 to (_selectedMagazineDesiredCount - _nbrOwnedMagazines) do {
                    _totalCost = _totalCost + _cost;
                    _magazineData pushBack [_cost, _selectedMagazine, 0, _selectedMagazineAmmoCount];
                };
            };
            nil
        } count _kitMagazineData;
        DUMP(_magazineData);
        CLib_player setVariable [QGVAR(MagazineData), _magazineData];
        CLib_player setVariable [QGVAR(ResupplyTime), time];
        CLib_player setVariable [QGVAR(TotalCosts), _totalCost];
        CLib_player setVariable [QGVAR(SpentCosts), 0];
    };

    private _onProgress = {
        params ["_target", "_caller"];

        private _magazineData = CLib_player getVariable [QGVAR(MagazineData), []];
        private _time = CLib_player getVariable [QGVAR(ResupplyTime), time];
        private _totalCosts = CLib_player getVariable [QGVAR(TotalCosts), 0];
        private _spentCosts = CLib_player getVariable [QGVAR(SpentCosts), 0];
        private _accumulatedCosts = floor ((time - _time)*6);

        private _rearmAmountAvailable = _target getVariable ["rearmAmountInfantery", 0];

        if (_rearmAmountAvailable == 0) exitWith {1};
        if (_totalCosts == 0) exitWith {1};

        {
            _x params ["_cost", "_magazineType", "_currentAmmo", "_desiredAmmo"];

            if (_cost > 0 && _cost <= (_accumulatedCosts - _spentCosts)
                && _rearmAmountAvailable >= _cost
                && _currentAmmo < _desiredAmmo) then {
                _x set [0, 0];
                _spentCosts = _spentCosts + _cost;
                [{
                    params ["_target", "_cost", "_magazineDataIndex"];
                    private _rearmAmountAvailable = _target getVariable ["rearmAmountInfantery", 0];
                    private _magazineData = CLib_player getVariable [QGVAR(MagazineData), []];

                    if (_rearmAmountAvailable >= _cost) then {
                        private _magazineDataElement = _magazineData select _magazineDataIndex;
                        _magazineDataElement set [2, _magazineDataElement select 3];
                        CLib_player setVariable [QGVAR(MagazineData), _magazineData];
                        _target setVariable ["rearmAmountInfantery", _rearmAmountAvailable - _cost, true];
                        CLib_player playAction "PutDown";
                    };
                }, [_target, _cost,_forEachIndex], QGVAR(InfanterySupply) + netId _target] call CFUNC(mutex);
            };
            nil
        } forEach _magazineData;

        CLib_player setVariable [QGVAR(SpentCosts), _spentCosts];

        if ((_accumulatedCosts - _spentCosts) > _rearmAmountAvailable) exitWith {1};

        _accumulatedCosts / _totalCosts;
    };

    private _onComplete = {
        params ["_target", "_caller"];

        [{
            params ["_target", "_caller"];
            private _magazineData = CLib_player getVariable [QGVAR(MagazineData), []];

            private _temp = [];

            {
                _x params ["_cost", "_magazineType", "_currentAmmo", "_desiredAmmo"];
                if (_temp pushBackUnique _magazineType >= 0) then {
                    CLib_player removeMagazines _magazineType;
                };
                if (_currentAmmo > 0) then {
                    CLib_player addMagazine [_magazineType, _currentAmmo];
                };
                nil;
            } count _magazineData;
        }, _this, QGVAR(InfanterySupply) + netId _target] call CFUNC(mutex);

    };

    private _onInterruption = _onComplete;

    [_object, _title, _iconIdle, _iconProgress, _condition, _condition, _onStart, _onProgress, _onComplete, _onInterruption, [], 5000, true, false, ["isNotUnconscious"]] call CFUNC(addHoldAction);

}] call CFUNC(addEventHandler);
