_markerName = _this select 0;
_unit = _this select 1;
_markerType = _this select 2;

//hint format["name: %1\nunit: %2\nmarkerType: %3", _markerName, _unit, _markerType];

_marker = createMarkerLocal [_markerName, position _unit];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal _markerType;