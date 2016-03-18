#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: joko // Jonas, NetFusion

    Description:
    Find a location with a name and if in 800m Radius is no Location or Marker from the Sector Module try to build a Name from Location Type and Position

    Remark:
    !!!This Function is Very Heavy Dont call to Often!!!

    Parameter(s):
    None

    Returns:
    None
*/
params ["_position"];
_allLocations = nearestLocations [_position, GVAR(allLocationTypes), 800];

// try to Find a Location with Text
{
    if (text _x != "") then {
        (text _x) breakOut "Main";
    };
} count _allLocations;

// try to Find a Near Marker from Markers

private _allMarkerLocationsDis = [];
{
    private _dis = (_x select 1) distance2D _position;
    if (_dis <= 800) then {
        _allMarkerLocationsDis pushBack [(_x select 1) distance2D _position, _x select 2];
    };
    nil
} count GVAR(markerLocations);

if !(_allMarkerLocationsDis isEqualTo []) then {
    _allMarkerLocationsDis sort true;
    ((_allMarkerLocationsDis select 0) select 1) breakOut "Main";
};

{
    if (toLower(className _x) find "hill" >= 0 || toLower(className _x) find "mount" >= 0) then {
        private _posHight = floor(getTerrainHeightASL (getPos _x));
        private _text = (["Mountain ", "Hill "] select (toLower(className _x) find "hill" >= 0)) + str(_posHight);
         _text breakOut "Main";
    };
} count _allLocations;

"Position " + mapGridPosition _position;
