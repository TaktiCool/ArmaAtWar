#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Init for Rally System for Leaders

    Parameter(s):
    None

    Returns:
    None
*/
[QGVAR(Rally), missionConfigFile >> "PRA3" >> "CfgSquadRallyPoint"] call CFUNC(loadSettings);

["groupChanged", {
    // Redraw ALL markers cause the playerSide may differ
    [QGVAR(updateMapIcons)] call CFUNC(localEvent);
}] call CFUNC(addEventHandler);

[QGVAR(updateMapIcons), {
    EGVAR(Deployment,deploymentPoints) params ["_pointIds", "_pointData"];

    {
        private _pointDetails = _pointData select (_pointIds find _x);
        _pointDetails params ["_name", "_icon", "_spawnTickets", "_position", "_spawnCondition", "_args", "_pointObjects"];
        //@todo this should be redesigned (quick version for play test)
        if (_icon == "ui\media\rally_ca.paa" && _args call _spawnCondition) then {
            [_name, [(str missionConfigFile select [0, count str missionConfigFile - 15]) + _icon, [0, 0.87, 0, 1], _position, 60, 2, format ["%1 (%2)", _name, _spawnTickets]]] call CFUNC(addMapIcon);
        } else {
            [_name] call CFUNC(removeMapIcon);
        };
        nil
    } count _pointIds;
}] call CFUNC(addEventHandler);

/*
 * ACTIONS
 */
["Create Rally Point", PRA3_Player, 0, {
    [QGVAR(isRallyPlaceable), FUNC(canPlaceRally), [], 5, QGVAR(ClearRallyPlaceable)] call CFUNC(cachedCall);
}, {
    QGVAR(ClearRallyPlaceable) call CFUNC(localEvent);
    call FUNC(placeRally);
}] call CFUNC(addAction);
