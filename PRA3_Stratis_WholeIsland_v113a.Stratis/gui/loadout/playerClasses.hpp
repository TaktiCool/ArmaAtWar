class CfgProjectRealityArma3Classes
{
	class basic 
	{
		class teamleader 
		{
			isLeader = 1;
			isFARPAuthorised = 1;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = Squad Leader;
			displayNameShort = SL;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
			kitE = O_Soldier_SL_F;
			kitW = B_Soldier_SL_F;
			mustBeLeader = 1;
			minTeamSize = 0;
			minGroupSize = 3;
			maxPerSquad = 1;
			maxPerTeam = 16;
			requiredLeaderRole = "";
		};
		class rifleman 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = Rifleman;
			displayNameShort = R;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
			kitE = O_Soldier_F;
			kitW = B_Soldier_F;
			mustBeLeader = 0;
			minTeamSize = 0;
			minGroupSize = 0;
			maxPerSquad = 999;
			maxPerTeam = 999;
			requiredLeaderRole = "";
		};
		class autorifleman 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = Autorifleman;
			displayNameShort = AR;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
			kitE = O_Soldier_AR_F;
			kitW = B_soldier_AR_F;
			mustBeLeader = 0;
			minTeamSize = 0;
			minGroupSize = 3;
			maxPerSquad = 1;
			maxPerTeam = 999;
			requiredLeaderRole = "";
		};
		class riflemanAT 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = Rifleman (AT);
			displayNameShort = LAT;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
			kitE = O_Soldier_LAT_F;
			kitW = B_soldier_LAT_F;
			mustBeLeader = 0;
			minTeamSize = 0;
			minGroupSize = 3;
			maxPerSquad = 1;
			maxPerTeam = 999;
			requiredLeaderRole = "";
		};
		class marksman 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = Designated Marksman;
			displayNameShort = DM;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\private_gs.paa";
			kitE = O_soldier_M_F;
			kitW = B_soldier_M_F;
			mustBeLeader = 0;
			minTeamSize = 0;
			minGroupSize = 5;
			maxPerSquad = 1;
			maxPerTeam = 999;
			requiredLeaderRole = "";
		};
		class medic 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = Combat Medic;
			displayNameShort = MEDIC;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
			kitE = O_medic_F;
			kitW = B_medic_F;
			mustBeLeader = 0;
			minTeamSize = 0;
			minGroupSize = 3;
			maxPerSquad = 1;
			maxPerTeam = 999;
			requiredLeaderRole = "";
		};
	};
	class crew 
	{
		class combatpilot 
		{
			isLeader = 1;
			isFARPAuthorised = 0;
			isCombatPilot = 1;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = CAS Pilot;
			displayNameShort = CAS;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa";
			kitE = O_Pilot_F;
			kitW = B_Pilot_F;
			mustBeLeader = 0;
			minTeamSize = 25;
			minGroupSize = 0;
			maxPerSquad = 1;
			maxPerTeam = 1;
			requiredLeaderRole = "";
		};
		class logisticspilot 
		{
			isLeader = 1;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 1;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = Logistic Pilot;
			displayNameShort = LOGI - P;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\lieutenant_gs.paa";
			kitE = O_helipilot_F;
			kitW = B_helipilot_F;
			mustBeLeader = 0;
			minTeamSize = 0;
			minGroupSize = 0;
			maxPerSquad = 5;
			maxPerTeam = 5;
			requiredLeaderRole = "";
		};
		class logisticscrew 
		{
			isLeader = 0;
			isFARPAuthorised = 1;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 1;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = Logistic Crew;
			displayNameShort = LOGI - C;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
			kitE = O_helicrew_F;
			kitW = B_helicrew_F;
			mustBeLeader = 0;
			minTeamSize = 0;
			minGroupSize = 0;
			maxPerSquad = 10;
			maxPerTeam = 10;
			requiredLeaderRole = "";
		};
		class vehiclecommander 
		{
			isLeader = 1;
			isFARPAuthorised = 1;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 1;
			isVehicleCrew = 0;
			isRecon = 0;
			displayName = Vehicle Commander;
			displayNameShort = VCOMM;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\major_gs.paa";
			kitE = O_officer_F;
			kitW = B_officer_F;
			mustBeLeader = 1;
			minTeamSize = 0;
			minGroupSize = 2;
			maxPerSquad = 1;
			maxPerTeam = 999;
			requiredLeaderRole = "";
		};
		class vehiclecrew 
		{
			isLeader = 0;
			isFARPAuthorised = 1;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 1;
			isRecon = 0;
			displayName = Vehicle Crewman;
			displayNameShort = VCREW;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
			kitE = O_crew_F;
			kitW = B_crew_F;
			mustBeLeader = 0;
			minTeamSize = 0;
			minGroupSize = 0;
			maxPerSquad = 2;
			maxPerTeam = 999;
			requiredLeaderRole = "vehiclecommander";
		};
	};
	class spec 
	{
		class reconteamleader 
		{
			isLeader = 1;
			isFARPAuthorised = 1;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 1;
			displayName = Recon Leader;
			displayNameShort = R-SL;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\captain_gs.paa";
			kitE = O_recon_TL_F;
			kitW = B_recon_TL_F;
			mustBeLeader = 1;
			minTeamSize = 25;
			minGroupSize = 2;
			maxPerSquad = 1;
			maxPerTeam = 1;
			requiredLeaderRole = "";
		};
		class reconmarksman 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 1;
			displayName = Recon Marksman;
			displayNameShort = R-M;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
			kitE = O_recon_M_F;
			kitW = B_recon_M_F;
			mustBeLeader = 0;
			minTeamSize = 25;
			minGroupSize = 2;
			maxPerSquad = 1;
			maxPerTeam = 1;
			requiredLeaderRole = "reconteamleader";
		};
		class reconAT 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 1;
			displayName = Recon AT;
			displayNameShort = R-AT;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
			kitE = O_recon_LAT_F;
			kitW = B_recon_LAT_F;
			mustBeLeader = 0;
			minTeamSize = 25;
			minGroupSize = 2;
			maxPerSquad = 1;
			maxPerTeam = 1;
			requiredLeaderRole = "reconteamleader";
		};
		class reconmedic 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 1;
			displayName = Recon Medic;
			displayNameShort = R-MEDIC;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
			kitE = O_recon_medic_F;
			kitW = B_recon_medic_F;
			mustBeLeader = 0;
			minTeamSize = 25;
			minGroupSize = 2;
			maxPerSquad = 1;
			maxPerTeam = 1;
			requiredLeaderRole = "reconteamleader";
		};
		class reconspotter 
		{
			isLeader = 1;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 1;
			displayName = Recon Spotter;
			displayNameShort = SPOTTER;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\sergeant_gs.paa";
			kitE = O_spotter_F;
			kitW = B_spotter_F;
			mustBeLeader = 1;
			minTeamSize = 25;
			minGroupSize = 0;
			maxPerSquad = 1;
			maxPerTeam = 1;
			requiredLeaderRole = "";
		};
		class reconsniper 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 1;
			displayName = Recon Sniper;
			displayNameShort = SNIPER;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
			kitE = O_ghillie_sard_F;
			kitW = B_ghillie_sard_F;
			mustBeLeader = 0;
			minTeamSize = 25;
			minGroupSize = 2;
			maxPerSquad = 1;
			maxPerTeam = 1;
			requiredLeaderRole = "reconspotter";
		};
		class recondiver 
		{
			isLeader = 0;
			isFARPAuthorised = 0;
			isCombatPilot = 0;
			isLogisticPilot = 0;
			isLogisticCrew = 0;
			isVehicleCommander = 0;
			isVehicleCrew = 0;
			isRecon = 1;
			displayName = Recon Diver;
			displayNameShort = DIVER;
			texture = "\A3\Ui_f\data\GUI\Cfg\Ranks\corporal_gs.paa";
			kitE = O_diver_F;
			kitW = B_diver_F;
			mustBeLeader = 0;
			minTeamSize = 0;
			minGroupSize = 0;
			maxPerSquad = 4;
			maxPerTeam = 4;
			requiredLeaderRole = "";
		};
	};
};