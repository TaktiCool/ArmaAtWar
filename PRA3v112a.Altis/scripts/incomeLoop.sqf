////// income loop //////

_loopTime = ["INCOME_RATE", 10] call BIS_fnc_getParamValue;

while {true} do {
	
	_bluCredits = blufactory getVariable "R3F_LOG_CF_credits";
	_opfCredits = opfactory getVariable "R3F_LOG_CF_credits";

	_bluCredits = _bluCredits + BLUINCOME;
	_opfCredits = _opfCredits + OPFINCOME;

	blufactory setVariable ["R3F_LOG_CF_credits", _bluCredits, true];
	opfactory setVariable ["R3F_LOG_CF_credits", _opfCredits, true];

	sleep _loopTime;
};