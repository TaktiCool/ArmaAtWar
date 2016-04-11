#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy

    Description:
    Draws the Map Icons

    Parameter(s):
    0: Map <Control>

    Remarks:
    None

    Returns:
    None
*/
params ["_map"];

{
    private _icon = GVAR(IconNamespace) getVariable _x;

    if !(isNil "_icon") then {
        private _icons = _icon select (1 + (_icon select 0));
        if (_icons isEqualTo []) then {
            _icons = _icon select 1;
        };
        {
            private _iconPart = +_x;
            if ((_iconPart select 5) isEqualType "" && {toUpper (_iconPart select 5) == "AUTO"}) then {
                private _object = _iconPart select 2;
                if (_object isEqualType [] && {(_object select 1) isEqualType []}) then {
                    _object = _iconPart select 2 select 0;
                };
                if (_object isEqualType objNull) then {
                    DUMP(getDirVisual _object)
                    _iconPart set [5, getDirVisual _object];
                } else {
                    _iconPart set [5, 0];
                };
            };
            if ((_iconPart select 2) isEqualType [] && {(_iconPart select 2 select 1) isEqualType []}) then {
                private _pos = _iconPart select 2 select 0;
                private _offset = _iconPart select 2 select 1;
                if (_pos isEqualType objNull) then {
                    _pos = getPosVisual _pos;
                };
                _pos = _map ctrlMapWorldToScreen _pos;
                _pos = [(_pos select 0) + (_offset select 0)/640, (_pos select 1) + (_offset select 1)/480];
                _pos = _map ctrlMapScreenToWorld _pos;
                _iconPart set [2, _pos];
            };
            private _pos = _iconPart select 2;
            if (_pos isEqualType objNull) then {
                if (!isNull _pos) then {
                    _map drawIcon _iconPart;
                };
            } else {
                if (!isNil "_pos") then {
                    _map drawIcon _iconPart;
                };
            };
            nil
        } count _icons;
    };
    nil
} count GVAR(MapIconIndex);
