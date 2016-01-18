

_unit = param [0, objNull, [objnull]];
_menuText = param [1, "", [""]];
_code = _this select 2;
_array = param [3, [], [[]],[]];
_condition = param [4, "", [""]];


_unit addAction[_menuText,_code, _array, -999, false, true, "", _condition];