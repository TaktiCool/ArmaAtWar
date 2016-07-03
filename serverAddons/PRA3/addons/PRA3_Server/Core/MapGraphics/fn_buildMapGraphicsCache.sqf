#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Updates the MapGraphicsCache

    Parameter(s):
    -

    Returns:
    -
*/
params ['_map'];
private _cache = [];

{
    private _graphicsGroupId = _x;
    private _graphicsGroup = GVAR(MapGraphicsGroup) getVariable _graphicsGroupId;
    _cache pushBack _graphicsGroup;
    nil;
} count ([GVAR(MapGraphicsGroupIndex)] call CFUNC(allVariables));

_cache sort true;

GVAR(MapGraphicsCache) = _cache;
