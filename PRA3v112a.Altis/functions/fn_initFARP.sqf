_unit = _this select 0;
_number = _this select 1;


if (isServer) then {

	_unit setVariable ["deploy_state", ["mobile", _number], true];

}; 


