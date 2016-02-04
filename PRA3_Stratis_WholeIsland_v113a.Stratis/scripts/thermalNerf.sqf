/*---------------------------------------------------------

Author: JohnnyShootos

---------------------------------------------------------*/
while {true} do {
	if (currentVisionMode player == 2) then {setViewDistance 300};

	if (currentVisionMode player != 2) then {setViewDistance -1};
	sleep 0.1;
};