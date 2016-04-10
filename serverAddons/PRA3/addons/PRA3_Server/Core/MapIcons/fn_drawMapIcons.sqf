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
            private _iconPart = _x;
            if (_iconPart select 2 isEqualType [] && {_iconPart select 2 select 1 isEqualType []}) then {
                private _pos = _iconPart select 2 select 0;
                private _offset = _iconPart select 2 select 1;
                if (_pos isEqualType objNull) then {
                    _pos = visiblePosition _pos;
                };
                _pos = _map ctrlMapWorldToScreen _pos;
                _pos = [(_pos select 0) + (_offset select 0)/640, (_pos select 1) + (_offset select 1)/480];
                _pos = _map ctrlMapScreenToWorld _pos;
                _iconPart set [2, _pos];
            };
            _map drawIcon _iconPart;
        } count _icons;
    };
    nil
} count GVAR(MapIconIndex);
