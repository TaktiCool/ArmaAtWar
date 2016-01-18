waitUntil {!isNull player};

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

Script_Taru =
{
	if (isClass(configFile >> "CfgPatches" >> "cba_main")) then
	{
		["XENO Taru Pod Mod", "Taru_Arrimer",localize "STR_XENO_Arrimer", {["Arrimage", player] call Script_Choix_Unite;}, {}, [DIK_A, [true,false,false]]] call CBA_fnc_addKeybind;
		["XENO Taru Pod Mod", "Taru_Desarrimer",localize "STR_XENO_Desarrimer", {["Desarrimage", player] call Script_Choix_Unite;}, {}, [DIK_E,[true,false,false]]] call CBA_fnc_addKeybind;
		["XENO Taru Pod Mod", "Taru_Larguer",localize "STR_XENO_Larguer", {["Largage", player] call Script_Choix_Unite;}, {},[DIK_C,[true,false,false]]] call CBA_fnc_addKeybind;
	};

	if (isClass(configFile >> "CfgPatches" >> "ace_common")) then
	{
		_taru_Arrimer = ["Taru_Arrimer",localize "STR_XENO_Arrimer","Script_XENO_Taru_Pod\XENO_Pod.paa",{["Arrimage", player] call Script_Choix_Unite;},{[vehicle player] call Script_Verification_Pod and {!([vehicle player] call Script_Verification_Objet_Attacher)}}] call ace_interact_menu_fnc_createAction;
		["O_Heli_Transport_04_F", 1, ["ACE_SelfActions"], _taru_Arrimer] call ace_interact_menu_fnc_addActionToClass;

		_taru_Desarrimer = ["Taru_Desarrimer",localize "STR_XENO_Desarrimer","Script_XENO_Taru_Pod\XENO_Pod.paa",{["Desarrimage", player] call Script_Choix_Unite;},{[vehicle player] call Script_Verification_Objet_Attacher}] call ace_interact_menu_fnc_createAction;
		["O_Heli_Transport_04_F", 1, ["ACE_SelfActions"], _taru_Desarrimer] call ace_interact_menu_fnc_addActionToClass;

		_taru_Larguer = ["Taru_Larguer",localize "STR_XENO_Larguer","Script_XENO_Taru_Pod\XENO_Pod.paa",{["Largage", player] call Script_Choix_Unite;},{[vehicle player] call Script_Verification_Objet_Attacher}] call ace_interact_menu_fnc_createAction;
		["O_Heli_Transport_04_F", 1, ["ACE_SelfActions"], _taru_Larguer] call ace_interact_menu_fnc_addActionToClass;
	};

	[] spawn Script_Boucle_Ajout_Action_Groupe;
};

Script_Boucle_Ajout_Action_Groupe =
{
	_ace_activer = false;

	waituntil
	{
		{
			if (isClass(configFile >> "CfgPatches" >> "ace_common")) then
			{
				_ace_activer = true;
			};

			if (_x != player or {!_ace_activer}) then
			{
				if (isnil {_x getVariable "Variable_Action_Init"}) then
				{
					_x setVariable ["Variable_Action_Init",false,false];
				};

				if (!(_x getVariable "Variable_Action_Init")) then
				{
					_x setVariable ["Variable_Action_Init",true,false];

					_x addAction [localize "STR_XENO_Arrimer", "[""Arrimage"",_this] call Script_Choix_Unite;", nil, 2, false, true, "",
					"[_this] call Script_Verification_Helico and {[vehicle _this] call Script_Verification_Pod} and {!([vehicle _this] call Script_Verification_Objet_Attacher)}"];

					_x addAction [localize "STR_XENO_Desarrimer", "[""Desarrimage"",_this] call Script_Choix_Unite;", nil, 2, false, true, "",
					"[_this] call Script_Verification_Helico and {[vehicle _this] call Script_Verification_Objet_Attacher}"];

					_x addAction [localize "STR_XENO_Larguer", "[""Largage"",_this] call Script_Choix_Unite;", nil, 2, false, true, "",
					"[_this] call Script_Verification_Helico and {[vehicle _this] call Script_Verification_Objet_Attacher}"];
				};
			};
		} foreach units group player;

		false
	};
};

Script_Verification_Objet_Attacher =
{
	_helico = (_this select 0);
	_objet_Verifier = false;

	if (count (attachedObjects _helico) isEqualTo 0) exitwith {_objet_Verifier};

	{
		_objet_attache = _x;
		_liste_Class_Parent = [(configfile >> "CfgVehicles" >> typeof _objet_attache),true] call BIS_fnc_returnParents;

		{
			if (_x isEqualTo "Pod_Heli_Transport_04_base_F") exitwith {_objet_Verifier = true;};
		} foreach _liste_Class_Parent;
	} foreach attachedObjects _helico;

	_objet_Verifier
};

Script_Verification_Pod =
{
	_unite = _this select 0;
	_pod = getSlingLoad vehicle _unite;
	_pod_Verifier = false;

	if (isnull _pod) exitwith {_pod_Verifier};

	_liste_Class_Parent = [(configfile >> "CfgVehicles" >> typeof _pod),true] call BIS_fnc_returnParents;

	{
		if (_x isEqualTo "Pod_Heli_Transport_04_base_F") exitwith {_pod_Verifier = true;};
	} foreach _liste_Class_Parent;

	_pod_Verifier
};

Script_Verification_Helico =
{
	_helico = vehicle (_this select 0);
	_helico_Verifier = false;
	_liste_Class_Parent = [(configfile >> "CfgVehicles" >> typeof _helico),true] call BIS_fnc_returnParents;

	{
		if (_x isEqualTo "Heli_Transport_04_base_F") exitwith {_helico_Verifier = true;};
	} foreach _liste_Class_Parent;

	_helico_Verifier
};

Script_Choix_Unite =
{
	_arrimer_Desarrimer = _this select 0;
	_helico = "";
	_unite_Lancant_Script = [];


	if (typename (_this select 1) isEqualTo "OBJECT") then {_helico = vehicle (_this select 1);};
	if (typename (_this select 1) isEqualTo "ARRAY") then {_helico = vehicle ((_this select 1) select 0);};

	_cables = ropes _helico;

	if (ropeUnwound (_cables select 0)) then
	{
		[] call
		{
			if (local _helico) exitwith {_unite_Lancant_Script = [player];};

			if (!local _helico) exitwith
			{
				{
					_proprietaire_Vehicule = owner _x;

					if (_proprietaire_Vehicule isEqualTo owner _x) exitwith
					{
						_unite_Lancant_Script = _x;
					};
				} foreach crew _helico;
			};
		};

		[] call
		{
			if (_arrimer_Desarrimer isEqualTo "Desarrimage") exitwith {[[_helico],"Script_Taru_Desarrimer_Pod",_unite_Lancant_Script,false,false] call BIS_fnc_MP;};
			if (_arrimer_Desarrimer isEqualTo "Arrimage") exitwith {[[_helico],"Script_Taru_Arrimer_Pod",_unite_Lancant_Script,false,false] call BIS_fnc_MP;};
			if (_arrimer_Desarrimer isEqualTo "Largage") then {[[_helico],"Script_Taru_Larguer_Pod",_unite_Lancant_Script,false,false] call BIS_fnc_MP;};
		};
	};
};

Script_Taru_Arrimer_Pod =
{
	_helico = _this select 0;
	_sans_Son = if (count _this > 1) then {_this select 1} else {false};
	_objet_Heliporter = getSlingLoad _helico;
	_mass_Objet_Heliporter = getmass getSlingLoad _helico;
	_mass_Helicoptere = getmass _helico;
	_poids_Helico = weightRTD _helico;


	if (!isTouchingGround _helico) then
	{
		// if (!_sans_Son) then {[["Son Arrimage", _helico],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false,false] call BIS_fnc_MP;};
		{ropeUnwind [_x, 1.9, 1];} foreach ropes _helico;

		waituntil {ropeLength (ropes _helico select 0) isEqualTo 1};
	};

	[] call
	{
		_liste_Class_Parent = [(configfile >> "CfgVehicles" >> typeOf _objet_Heliporter),true] call BIS_fnc_returnParents;
		_helico allowdamage false;

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_bench_F") exitwith
			{
				_objet_Heliporter attachTo [_helico,[0,0.1,-1.13]];
				_helico setCustomWeightRTD 680;
				_helico setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};

			if (_x isEqualTo "Land_Pod_Heli_Transport_04_covered_F") exitwith
			{
				_objet_Heliporter attachTo [_helico,[-0.1,-1.05,-0.82]];
				_helico setCustomWeightRTD 1413;
				_helico setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};

			if (_x isEqualTo "Land_Pod_Heli_Transport_04_fuel_F") exitwith
			{
				_objet_Heliporter attachTo [_helico,[0,-0.282,-1.25]];
				_helico setCustomWeightRTD 13311;
				_helico setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};

			if (_x isEqualTo "Land_Pod_Heli_Transport_04_medevac_F") exitwith
			{
				_objet_Heliporter attachTo [_helico,[-0.14,-1.05,-0.92]];
				_helico setCustomWeightRTD 1321;
				_helico setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};

			if (_x in ["Land_Pod_Heli_Transport_04_repair_F","Land_Pod_Heli_Transport_04_box_F","Land_Pod_Heli_Transport_04_ammo_F"]) exitwith
			{
				_objet_Heliporter attachTo [_helico,[-0.09,-1.05,-1.1]];
				_helico setCustomWeightRTD 1270;
				_helico setmass _mass_Objet_Heliporter + _mass_Helicoptere;
			};
		} foreach _liste_Class_Parent;
	};

	_helico allowdamage true;
	{ropeUnwind [_x, 250, 1];} foreach ropes _helico;

	if (!_sans_Son) then
	{
		// [["Son Fixation", _helico],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false,false] call BIS_fnc_MP;
		[["Chat arrimage", _helico],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false,false] call BIS_fnc_MP;
	};

	if (isnil {_helico getVariable "EH_GetOut_Taru"}) then
	{
		_helico addEventHandler ["Getin", "[_this] spawn Script_Taru_GetIn;"];
		_helico setVariable ["EH_GetIn_Taru", true, false];
	};
};

Script_Taru_Desarrimer_Pod =
{
	_helico = _this select 0;
	_sans_Son = if (count _this > 1) then {_this select 1} else {false};
	_objet_Arrimer = [];
	_objet_Arrimer_Egal_Pod = false;
	_mass_Helicoptere = getmass _helico;


	{
		_objet_Arrimer = typeOf _x;
		_liste_Class_Parent = [(configfile >> "CfgVehicles" >> _objet_Arrimer),true] call BIS_fnc_returnParents;

		{
			if (_x isEqualTo "Pod_Heli_Transport_04_base_F") exitwith {_objet_Arrimer_Egal_Pod = true;};
		} foreach _liste_Class_Parent;

		if (_objet_Arrimer_Egal_Pod) exitwith {_objet_Arrimer = _x;};
	} foreach attachedObjects _helico;

	_mass_Objet_Heliporter = getmass _objet_Arrimer;
	_helico allowdamage false;

	if (!isTouchingGround _helico) then
	{
		_liste_Class_Parent = [(configfile >> "CfgVehicles" >> typeOf _objet_Arrimer),true] call BIS_fnc_returnParents;

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_bench_F") exitwith
			{
				_objet_Arrimer attachTo [_helico,[0,0.1,-2.83]];
			};
		} foreach _liste_Class_Parent;

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_covered_F") exitwith
			{
				_objet_Arrimer attachTo [_helico,[-0.1,-1.05,-2.52]];
			};
		} foreach _liste_Class_Parent;

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_fuel_F") exitwith
			{
				_objet_Arrimer attachTo [_helico,[0,-0.282,-3.05]];
			};
		} foreach _liste_Class_Parent;

		{
			if (_x isEqualTo "Land_Pod_Heli_Transport_04_medevac_F") exitwith
			{
				_objet_Arrimer attachTo [_helico,[-0.14,-1.05,-2.62]];
			};
		} foreach _liste_Class_Parent;

		{
			if (_x isEqualTo ["Land_Pod_Heli_Transport_04_repair_F","Land_Pod_Heli_Transport_04_box_F","Land_Pod_Heli_Transport_04_ammo_F"]) then
			{
				_objet_Arrimer attachTo [_helico,[-0.09,-1.05,-2.8]];
			};
		} foreach _liste_Class_Parent;
	};

	if (isTouchingGround _helico) then {{ropeCut [_x, 0];} foreach ropes _helico; _helico setSlingLoad _objet_Arrimer;};
	// if (!isTouchingGround _helico) then {{ropeUnwind [_x, 1.9, 10]; [["Son Desarrimage", _helico],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false,false] call BIS_fnc_MP;} foreach ropes _helico;};

	_helico setCustomWeightRTD 0;
	_helico setmass _mass_Helicoptere - _mass_Objet_Heliporter;

	detach _objet_Arrimer;

	_helico allowdamage true;

	// if (!_sans_Son) then {[["Son Défixation", _helico],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false,false] call BIS_fnc_MP;};

	if (!isTouchingGround _helico) then {waituntil {ropeLength (ropes _helico select 0) isEqualTo 10};};

	if (!_sans_Son) then {[["Chat désarrimage", _helico],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false,false] call BIS_fnc_MP;};
};

Script_Taru_Larguer_Pod =
{
	_helico = _this select 0;
	_objet_Arrimer = [];
	_objet_Arrimer_Egal_Pod = false;


	{
		_objet_Arrimer = typeOf _x;
		_liste_Class_Parent = [(configfile >> "CfgVehicles" >> _objet_Arrimer),true] call BIS_fnc_returnParents;

		{
			if (_x isEqualTo "Pod_Heli_Transport_04_base_F") exitwith {_objet_Arrimer_Egal_Pod = true;};
		} foreach _liste_Class_Parent;

		if (_objet_Arrimer_Egal_Pod) exitwith {_objet_Arrimer = _x;};
	} foreach attachedObjects _helico;

	_helico allowdamage false;
	{ropeCut [_x, 0];} foreach ropes _helico;
	_helico setCustomWeightRTD 0;
	detach _objet_Arrimer;
	_helico allowdamage true;

	// [["Son Largage", _helico],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false,false] call BIS_fnc_MP;

	sleep 0.5;

	if (ASLToATL getposasl _objet_Arrimer select 2 >= 70) exitwith
	{
		[["Chat largage avec parachute", _helico],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false,false] call BIS_fnc_MP;

		waituntil {ASLToATL getposasl _objet_Arrimer select 2 <= 120};

		_parachute = createVehicle ["B_Parachute_02_F",getposatl _objet_Arrimer, [], 0, "CAN COLLIDE"];
		_parachute attachTo [_objet_Arrimer,[0,0,-1]];

		[_objet_Arrimer,_parachute,_helico] spawn
		{
			_objet_Arrimer = _this select 0;
			_parachute = _this select 1;
			_helico = _this select 2;

			waituntil
			{
				if (ASLToATL getposasl _objet_Arrimer select 2 <= 5) exitwith
				{
					detach _objet_Arrimer;
					_vitesse_nacelle = velocity _objet_Arrimer;
					_parachute setVelocity [_vitesse_nacelle select 0 + 1, _vitesse_nacelle select 1 + 1, 0];
					true
				};
				false
			};
		};

		waituntil
		{
			if (getposasl _helico distance getposasl _objet_Arrimer >= 50) exitwith
			{
				detach _parachute;
				_objet_Arrimer attachTo [_parachute,[0,0,-1]];
				true
			};
			false
		};
	};

	[["Chat largage sans parachute", _helico],"Script_Taru_Transmission_Son_Message",[] call Script_BIS_Liste_Joueur,false,false] call BIS_fnc_MP;
};

Script_Taru_Transmission_Son_Message =
{
	_type_Son_Message = _this select 0;
	_helico = vehicle (_this select 1);


	if (_type_Son_Message isEqualTo "Son Arrimage") exitwith
	{
		if (!isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
		{
			_helico say "XENO_Helitreuillage_Arrimage_Exterieur";
		};
		if (isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
		{
			_helico say "XENO_Helitreuillage_Arrimage_Exterieur_JSRS";
		};

		if (player in crew _helico) then
		{
			if (!isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
			{
				playSound ["XENO_Helitreuillage_Arrimage_Interieur",true];
			};
			if (isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
			{
				playSound ["XENO_Helitreuillage_Arrimage_Interieur_JSRS",true];
			};
		};
	};

	if (_type_Son_Message isEqualTo "Son Desarrimage") exitwith
	{
		if (!isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
		{
			_helico say "XENO_Helitreuillage_Desarrimage_Exterieur";
		};
		if (isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
		{
			_helico say "XENO_Helitreuillage_Desarrimage_Exterieur_JSRS";
		};

		if (player in crew _helico) then
		{
			if (!isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
			{
				playSound ["XENO_Helitreuillage_Desarrimage_Interieur",true];
			};
			if (isclass (configFile >> "CfgPatches" >> "DragonFyre_Distance")) then
			{
				playSound ["XENO_Helitreuillage_Desarrimage_Interieur_JSRS",true];
			};
		};
	};

	if (_type_Son_Message isEqualTo "Son Fixation") exitwith
	{
		_helico say "XENO_Helitreuillage_Fixation";
		if (player in crew _helico) then {playSound ["XENO_Helitreuillage_Fixation",true];};
	};

	if (_type_Son_Message isEqualTo "Son Défixation") exitwith
	{
		_helico say "XENO_Helitreuillage_Defixation";
		if (player in crew _helico) then {playSound ["XENO_Helitreuillage_Defixation",true];};
	};

	if (_type_Son_Message isEqualTo "Son Largage") exitwith
	{
		_helico say "XENO_Helitreuillage_Largage";
		if (player in crew _helico) then {playSound ["XENO_Helitreuillage_Largage",true];};
	};

	if (_type_Son_Message isEqualTo "Chat arrimage") exitwith
	{
		if (player in crew _helico) then {_helico vehicleChat localize "STR_XENO_Chat_Arrimer";};
	};

	if (_type_Son_Message isEqualTo "Chat désarrimage") exitwith
	{
		if (player in crew _helico) then {_helico vehicleChat localize "STR_XENO_Chat_Desarrimer";};
	};

	if (_type_Son_Message isEqualTo "Chat largage avec parachute") exitwith
	{
		if (player in crew _helico) then {_helico vehicleChat localize "STR_XENO_Chat_Larguer_Avec_Parachute";};
	};

	if (_type_Son_Message isEqualTo "Chat largage sans parachute") then
	{
		if (player in crew _helico) then {_helico vehicleChat localize "STR_XENO_Chat_Larguer_Sans_Parachute";};
	};
};

Script_BIS_Liste_Joueur =
{
	private ["_players"];
	_players = [];


	{
		if (isplayer _x) then
		{
			if (_x isKindOf "man") then {_players pushback _x;};
		};
	} foreach (allunits + alldead);

	_players
};

Script_Taru_GetIn =
{
	_vehicule = _this select 0 select 0;
	if ([_vehicule] call Script_Verification_Helico) then
	{
		if (count attachedObjects _vehicule > 0) then
		{
			_time = time + 2;
			waituntil
			{
				_vehicule setvelocity [0, 0, 0];
				if (time > _time or {time > _time + 15}) exitwith {true};
			};
		};
	};
};

Script_Joueur_Tuer_ReInit_Variable_Boucle_Action =
{
	waituntil {if (alive player) exitwith {true}; false};
	player setVariable ["Variable_Action_Init",false,false];
};

[] call Script_Taru;

XENO_Taru_EH_Killed = player addEventHandler ["Killed", "[] spawn Script_Joueur_Tuer_ReInit_Variable_Boucle_Action;"];