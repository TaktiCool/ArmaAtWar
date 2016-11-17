#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: NetFusion

    Description:
    Place rally

    Parameter(s):
    None

    Returns:
    None
*/
[{
    if (!(call FUNC(canPlace))) exitWith {};

    private _position = CLib_Player modelToWorld [0,1.5,0]; // [CLib_Player modelToWorld [0,1,0], 2] call CFUNC(findSavePosition);

    [group CLib_Player] call FUNC(destroy);

    private _className = getText (missionConfigFile >> QPREFIX >> "Sides" >> (str playerSide) >> "squadRallyComposition");
    private _pointObjects = [_className, _position, vectorDirVisual CLib_Player, CLib_Player] call CFUNC(createSimpleObjectComp);

    (group CLib_Player) setVariable [QGVAR(lastRallyPlaced), serverTime, true];
    //private _text = [_position] call EFUNC(Common,getNearestLocationName);
    private _text = format ["RP %1", groupId group CLib_Player];
    private _spawnCount = [QGVAR(Rally_spawnCount), 1] call CFUNC(getSetting);
    private _pointId = [_text, "RALLY", _position, group CLib_Player, _spawnCount, "ui\media\rally_ca.paa", "ui\media\rally_ca.paa", _pointObjects] call EFUNC(Common,addDeploymentPoint);
    (group CLib_Player) setVariable [QGVAR(rallyId), _pointId, true];

    [QGVAR(placed), _pointId] call CFUNC(globalEvent);

    ["displayNotification", group CLib_Player, [format[MLOC(RallyPlaced), [_position] call EFUNC(Common,getNearestLocationName)]]] call CFUNC(targetEvent);
}, [getPos CLib_Player], "respawn"] call CFUNC(mutex);
