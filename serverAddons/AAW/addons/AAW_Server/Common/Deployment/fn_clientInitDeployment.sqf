#include "macros.hpp"
/*
    Arma At War - AAW

    Author: joko // Jonas, NetFusion

    Description:
    Init for deployment system

    Parameter(s):
    None

    Returns:
    None
*/
["groupChanged", {
    [QGVAR(updateMapIcons)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(deploymentPointAdded), {
    [QGVAR(updateMapIcons)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(deploymentPointRemoved), {
    [QGVAR(updateMapIcons)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(ticketsChanged), {
    [QGVAR(updateMapIcons)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

["DeploymentPointDataChanged", {
    [QGVAR(updateMapIcons)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

GVAR(pointMarkerIds) = [];
GVAR(updateTriggerd) = false;
DFUNC(updateMapIcons) = {
    GVAR(updateTriggerd) = false;
    private _availablePoints = [side group CLib_Player] call FUNC(getDeploymentPointsPerSide);

    private _sideColor = +(missionNamespace getVariable format [QEGVAR(Common,SideColor_%1), playerSide]);

    {
        [_x] call CFUNC(removeMapGraphicsGroup);
        [_x] call CFUNC(removeMapGraphicsEventHandler);
        nil
    } count GVAR(pointMarkerIds);

    {
        private _pointData = [_x, ["name", "type", "position", "availableFor", "spawnTickets", "icon", "mapIcon"]] call FUNC(getDeploymentPointData);
        _pointData params ["_name", "_type", "_position", "_availableFor", "_spawnTickets", "_icon", "_mapIcon"];

        switch (typeName _mapIcon) do {
            case ("ARRAY"): {
                if !(_mapIcon isEqualTo []) then {
                    private _pointId = _x;
                    {
                        if (!isNil "_x" || {!(_x isEqualTo [])}) then {
                            switch (_forEachIndex) {
                                case (0): {
                                    [_pointId, _x, "normal", 2000] call CFUNC(addMapGraphicsGroup);
                                };
                                case (1): {
                                    [_pointId, _x, "selected", 2000] call CFUNC(addMapGraphicsGroup);
                                };
                                case (2): {
                                    [_pointId, _x, "hover", 2000] call CFUNC(addMapGraphicsGroup);
                                };
                            };
                        };
                    } forEach _mapIcon;
                };
            };
            case ("STRING"): {
                if (_mapIcon != "") then {
                    if (_position isEqualType {}) then {
                        _position = (_id call _position);
                    };
                    private _color = _sideColor;
                    private _bgIcon = ["ICON", "A3\ui_f\data\igui\cfg\holdactions\progress\progress_0_ca.paa", [1, 1, 1, 1], _position, 30, 30];
                    private _bgIconHover = ["ICON", "A3\ui_f\data\igui\cfg\holdactions\progress\progress_0_ca.paa", [1, 1, 1, 1], _position, 30, 30];
                    if ((_availableFor isEqualType playerSide && {playerSide == _availableFor}) || (_availableFor isEqualType grpNull && {group CLib_Player == _availableFor})) then {
                        _color = [[0.13, 0.54, 0.21, 1], [0, 0.4, 0.8, 1]] select (_availableFor isEqualType playerSide && {playerSide == _availableFor});

                        if ([_x, "spawnPointLocked", 0] call FUNC(getDeploymentPointData) == 1) then {
                            _color = [0.5, 0.5, 0.5, 1];
                        };

                        if ([_x, "spawnPointBlocked", 0] call FUNC(getDeploymentPointData) == 1) then {
                            _color = [0.6, 0, 0, 1];
                        };

                        if ([_x, "counterActive", 0] call FUNC(getDeploymentPointData) == 1) then {
                            _color = [0.6, 0, 0, 1];
                        };

                        _bgIcon = ["ICON", "A3\ui_f\data\map\respawn\respawn_background_ca.paa", _color, _position, 35, 35];
                        _bgIconHover = ["ICON", "A3\ui_f\data\map\respawn\respawn_backgroundhover_ca.paa", _color, _position, 35, 35];
                    };
                    private _selectedIcon = ["ICON", "A3\ui_f\data\map\groupicons\selector_selectedmission_ca.paa", [1,1,1,0], _position, 40, 40, 0, "", 0, 0.08, "RobotoCondensedBold", "center", {
                        if (_groupId isEqualTo EGVAR(RespawnUI,selectedDeploymentPoint)) then {
                            _color = [1,1,1,1];
                        };
                    }];
                    private _icon = ["ICON", _mapIcon, [1,1,1,1], _position, 25, 25];
                    private _normalText = ["ICON", "a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1, 1, 1, 1], [_position,[0,27]], 25, 25, 0, format ["%1", _name], 2, 0.08, "RobotoCondensedBold", "center"];
                    [_x, [_bgIcon, _icon, _normalText, _selectedIcon], "normal", 2000] call CFUNC(addMapGraphicsGroup);
                    if (_spawnTickets > 0) then {
                        private _onHoverText = ["ICON", "a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1, 1, 1, 1], [_position, [0,27]], 25, 25, 0, format [MLOC(SpawnsRemaining), _name, _spawnTickets], 2, 0.08, "RobotoCondensedBold", "center"];;
                        [_x, [_bgIconHover, _icon, _onHoverText, _selectedIcon], "hover", 2000] call CFUNC(addMapGraphicsGroup);
                    };
                };
            };
            default {
                LOG("ERROR: Unknown Type for MapIcon");
            };
        };

        [
            _x,
            "clicked",
            {
                (_this select 0) params ["_map", "_xPos", "_yPos"];
                (_this select 1) params ["_deploymentPointId"];

                [QGVAR(DeploymentPointSelected), _deploymentPointId] call CFUNC(localEvent);

            },
            _x
        ] call CFUNC(addMapGraphicsEventHandler);

        nil
    } count _availablePoints;

    GVAR(pointMarkerIds) = _availablePoints;
};
[QGVAR(updateMapIcons), {
    if (GVAR(updateTriggerd)) exitWith {};
    GVAR(updateTriggerd) = true;
    [{
        call FUNC(updateMapIcons);
    }, 0.3] call CFUNC(wait);
}] call CFUNC(addEventHandler);
