#include "macros.hpp"
/*
    Project Reality ArmA 3

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

GVAR(pointMarkerIds) = [];
[QGVAR(updateMapIcons), {
    private _availablePoints = call FUNC(getAvailableDeploymentPoints);
    private _existingMapIconPoints = GVAR(pointMarkerIds) arrayIntersect _availablePoints;

    {
        [_x] call CFUNC(removeMapGraphicsGroup);
        nil
    } count (GVAR(pointMarkerIds) - _existingMapIconPoints);

    {
        (GVAR(DeploymentPointStorage) getVariable _x) params ["_name", "_type", "_position", "_availableFor", "_spawnTickets", "_icon", "_mapIcon"];

        if (_mapIcon != "") then {
            private _icon = ["ICON",(str missionConfigFile select [0, count str missionConfigFile - 15]) + _mapIcon, [0, 0.87, 0, 1], _position, 25, 25, 0, "", 1];
            private _normalText = ["ICON", "a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1,1,1,1], _position, 25, 25, 0, format ["%1", _name], 2, 0.09];
            [_x, [_icon, _normalText], "normal"] call CFUNC(addMapGraphicsGroup);

            if (_spawnTickets > 0) then {
                private _onHoverText = ["ICON","a3\ui_f\data\Map\Markers\System\dummy_ca.paa", [1,1,1,1], _position, 25,25, 0, format [MLOC(SpawnsRemaining), _name, _spawnTickets], 2, 0.089];
                [_x, [_icon, _onHoverText], "hover"] call CFUNC(addMapGraphicsGroup);
            };
        };

        nil
    } count _availablePoints;

    GVAR(pointMarkerIds) = _availablePoints;
}] call CFUNC(addEventHandler);
