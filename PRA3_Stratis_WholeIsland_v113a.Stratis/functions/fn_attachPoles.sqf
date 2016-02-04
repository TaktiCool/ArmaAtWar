/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
//Setup Sectors by moving them to sectors and setup some sandbags round the flag.

for "_i" from 1 to 7 do {

	call compile format ["sg%1 attachTo [ob%2,[0,0,0]]", _i, _i];
	_bagN = "Land_BagFence_Long_F" createVehicle [0,0,0];
	_bagN setVariable ["R3F_LOG_disabled", true];
	call compile format ["_bagN attachTo [ob%1, [0,1,-3.6]]", _i];
	
	
	_bagS = "Land_BagFence_Long_F" createVehicle [0,0,0];
	_bagS setVariable ["R3F_LOG_disabled", true];
	call compile format ["_bagS attachTo [ob%1, [0,-1.5,-3.6]]", _i];
	
	
	_bagE = "Land_BagFence_Long_F" createVehicle [0,0,0];
	_bagE setVariable ["R3F_LOG_disabled", true];
	call compile format ["_bagE attachTo [ob%1, [1.75,-.3,-3.6]]", _i];
	_bagE setDir 90;
	

	_bagW = "Land_BagFence_Long_F" createVehicle [0,0,0];
	_bagW setVariable ["R3F_LOG_disabled", true];
	call compile format ["_bagW attachTo [ob%1, [-1.75,-.3,-3.6]]", _i];
	_bagW setDir 90;
	

	call compile format ["ob%1 setFlagTexture ""media\prlogoBLACK.jpg"";", _i];

};

ob1 setFlagTexture 'media\prlogoBLUFOR.jpg'; ob1 setVariable ["R3F_LOG_disabled", true]; ob1 allowDamage false;
ob7 setFlagTexture 'media\prlogoOPFOR.jpg'; ob7 setVariable ["R3F_LOG_disabled", true]; ob7 allowDamage false;

bluSafe setPos getPos ob1;
"bluSafeZone" setMarkerPos getPos ob1;

opSafe setPos getPos ob7;
"opSafeZone" setMarkerPos getPos ob7;