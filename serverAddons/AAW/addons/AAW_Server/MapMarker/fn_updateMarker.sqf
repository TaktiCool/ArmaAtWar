#include "macros.hpp"
/*
    Arma At War - AAW

    Author: BadGuy

    Description:
    Updates all Map Marker (client side function)

    Parameter(s):
    None

    Returns:
    None
*/

private _markerNamespaceName = QGVAR(allMarker_) + str side group CLib_player;
private _markerNamespace = missionNamespace getVariable [_markerNamespaceName, objNull];

if (isNull _markerNamespace) exitWith {};

{
    private _markerName = _x;
    private _markerData = _markerNamespace getVariable [_markerName, []];
    if (_markerData isEqualTo []) then {
        [_markerName] call CFUNC(removeMapGraphicsGroup);
    } else {
        _markerData params ["_type", "_position"];
        private _icons = +([_type + "/icons", []] call CFUNC(getSetting));
        private _mapGraphicsIcons = _icons apply {
            ["ICON", _x select 0, _x select 2, _position, 25, 25, 0, "", 0, 0.08, "RobotoCondensed", "right", {
                private _markerNamespaceName = QGVAR(allMarker_) + str side group CLib_player;
                private _markerNamespace = missionNamespace getVariable [_markerNamespaceName, objNull];
                if (isNull _markerNamespace) exitWith {};
                private _markerData = _markerNamespace getVariable [_groupId, []];
                DUMP(_markerData);
                if (_markerData isEqualTo []) exitWith {
                    [{
                        LOG("Remove MapMarker (No MapMarker data):" + _groupId);
                        [_this] call CFUNC(removeMapGraphicsGroup);
                    }, _groupId] call CFUNC(execNextFrame);
                    _color = [0, 0, 0, 0];
                };
                _markerData params ["_type", "_position", "_time"];
                if ((serverTime - _time) > 30) then {
                    private _alpha = 0 max ((serverTime - _time) - 30)/60;
                    _color set [3, _alpha];
                    if (_alpha == 0) then {
                        [{
                            LOG("Remove MapMarker (timeout): " + _groupId);
                            [_this] call CFUNC(removeMapGraphicsGroup);
                        }, _groupId] call CFUNC(execNextFrame);
                    };
                };
            }];
        };
        DUMP(_markerName);
        DUMP(_mapGraphicsIcons);
        [_markerName, _mapGraphicsIcons] call CFUNC(addMapGraphicsGroup);
    };
} count (allVariables _markerNamespace);
