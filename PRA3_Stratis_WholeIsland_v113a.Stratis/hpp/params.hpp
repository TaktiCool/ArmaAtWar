class Params
{
	class SPACER0
	{
		title = "-----------------GENERAL OPTIONS---------------";
		texts[] = {""};
		values[] = {0};
	};
	class START_TIME
	{
		title = "Time";
		texts[] = {"Morning","Day","Evening","Night"};
		values[] = {6,12,18,0};
		default = 12;
		function = "BIS_fnc_paramDaytime";
 		isGlobal = 0;
	};
	class TIME_ACCEL
	{
		title = "Time Acceleration";
		texts[] = {"1x","4x","12x","24x","60x"};
		values[] = {1, 4, 12, 24, 60};
		default = 12;
	};
	class PLAYER_MARKERS
	{
		title = "Map Markers for Team";
		texts[] = {"No","Yes"};
		values[] = {0, 1};
		default = 1;
	};
	class SPACER1
	{
		title = "-----------------INCOME OPTIONS----------------";
		texts[] = {""};
		values[] = {0};
	};
	class INCOME_START 
	{
		title = "Starting Construction Points";
		values[] = {16000,24000,32000,40000};
		default = 16000;
	};
	class INCOME_SECTOR 
	{
		title = "Income per Sector";
		values[] = {2000,4000,6000,8000,10000};
		default = 4000;
	};
	class INCOME_RATE
	{
		title = "Income - Tick Rate";
		texts[] = {"1 Min","5 min","10 min","30 min","debug (10sec)"};
		values[] = {60,300,600,1800,10};
		default = 300;
	};
	class SPACER2
	{
		title = "-----------------FARP OPTIONS------------------";
		texts[] = {""};
		values[] = {0};
	};
	class FARP_TIME
	{
		title = "FARP Construction Time";
		texts[] = {"10sec","30sec","1min","2min","5min"};
		values[] = {10,30,60,120,300};
		default = 10;
	};
	class FARP_REFUEL_ON_UNDEPLOY
	{
		title = "FARP Refueled on Undeploy";
		texts[] = {"No","100%","75%","50%","25%"};
		values[] = {0, 1, 0.75, 0.5, 0.25};
		default = 0;
	};
	class FARP_ARSENAL
	{
		title = "FARP Deploys Equipment Box";
		texts[] = {"No","Yes"};
		values[] = {0, 1};
		default = 1;
	};
	class SPACER3
	{
		title = "-----------------BASE CLEANUP OPTIONS------------------";
		texts[] = {""};
		values[] = {0};
	};
	class CLEANUP_TIME
	{
		title = "Time between Base Cleanups";
		texts[] = {"10 sec","30 sec","1 min","5 min","10 min"};
		values[] = {10, 30, 60, 300, 600};
		default = 10;
	};
	class CLEANUP_RADIUS
	{
		title = "Radius of Base Cleanups";
		texts[] = {"25m","50m","100m","200m","300m"};
		values[] = {25, 50, 100, 200, 300};
		default = 200;
	};
	class SPACER4
	{
		title = "-----------------ROLE RESTRICTIONS------------------";
		texts[] = {""};
		values[] = {0};
	};
	class NUM_SL
	{
		title = "Squad Leader";
		values[] = {0, 4, 6, 8, 10};
		default = 6;
	};
	class NUM_AT
	{
		title = "AT Rifleman";
		values[] = {2, 4, 6, 8, 10};
		default = 6;
	};
	class NUM_MEDIC
	{
		title = "Combat Life Saver";
		values[] = {2, 4, 6, 8, 10};
		default = 6;
	};
	class NUM_AR
	{
		title = "Autorifleman";
		values[] = {2, 4, 6, 8, 10};
		default = 6;
	};
	class NUM_MARKSMAN
	{
		title = "Marksman";
		values[] = {2, 4, 6, 8, 10};
		default = 6;
	};
	class NUM_REPAIR
	{
		title = "Repair Specialist";
		values[] = {2, 4, 6, 8, 10};
		default = 6;
	};
	class NUM_CREW
	{
		title = "Armored Vehicle Crewman";
		values[] = {2, 4, 6, 8, 10};
		default = 10;
	};
	class NUM_DIVER
	{
		title = "Assault Diver";
		values[] = {2, 4, 6, 8, 10};
		default = 4;
	};
	class NUM_PILOT
	{
		title = "Pilot";
		values[] = {2, 4, 6, 8, 10};
		default = 4;
	};
	class NUM_SPOTTER
	{
		title = "Spotter";
		values[] = {1, 2, 6, 8, 10};
		default = 2;
	};
	class NUM_SNIPER
	{
		title = "Sniper";
		values[] = {1, 2, 6, 8, 10};
		default = 2;
	};
};