
_secOwner = _this select 0;

_sectorCash = ["INCOME_SECTOR", 0] call BIS_fnc_getParamValue;

if (_secOwner == east) then {

		OPFINCOME = OPFINCOME + _sectorCash;
		
		if (BLUINCOME - _sectorCash < 0) then {BLUINCOME = 0} else {BLUINCOME = BLUINCOME - _sectorCash};
		//hint format["BLUFOR income: %1\nOPFOR INCOME: %2", BLUINCOME, OPFINCOME];
		
		

	};

if (_secOwner == west) then {

		if (OPFINCOME - _sectorCash < 0) then {OPFINCOME = 0} else {OPFINCOME = OPFINCOME - _sectorCash};
		BLUINCOME = BLUINCOME + _sectorCash;
		//hint format["BLUFOR income: %1\nOPFOR INCOME: %2", BLUINCOME, OPFINCOME];

		
	};
