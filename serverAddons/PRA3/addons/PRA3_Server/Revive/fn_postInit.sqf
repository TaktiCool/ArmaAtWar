#include "macros.hpp"
/*
    Project Reality ArmA 3

    Author: BadGuy, joko // Jonas

    Description:
    Initialize the Medical Actions

    Parameter(s):
    -

    Returns:
    -
*/
if (hasInterface) then {
	GVAR(colorEffectCC) = ["colorCorrections", 1632, [1, 1, 0.15, [0.3, 0.3, 0.3, 0], [0.3, 0.3, 0.3, 0.3], [1, 1, 1, 1]]] call CFUNC(createPPEffect);
	GVAR(vigEffectCC) = ["colorCorrections", 1633, [1, 1, 0, [0.15, 0, 0, 1], [1.0, 0.5, 0.5, 1], [0.587, 0.199, 0.114, 0], [1, 1, 0, 0, 0, 0.2, 1]]] call CFUNC(createPPEffect);
	GVAR(blurEffectCC) = ["dynamicBlur", 525, [0]] call CFUNC(createPPEffect);
	GVAR(PPEffects) = [GVAR(colorEffectCC),GVAR(vigEffectCC),GVAR(blurEffectCC)];



	// Animation Event
	["UnconsciousnessChanged", FUNC(UnconsciousnessChanged)] call CFUNC(addEventhandler);

	GVAR(MedicItemSelected) = "";
	GVAR(MedicItemActivated) = -1;
	GVAR(MedicItemHolder) = objNull;
	GVAR(MedicItemProgress) = 0;
	GVAR(CancelAction) = -1;
	GVAR(beginTickTime) = -1;
	GVAR(reviveKeyPressed) = false;

	private _itemAction = {
		(_this select 3) params ["_item"];
		hint format ["%1",_this];

		if (GVAR(MedicItemSelected) == "") then {
			PRA3_Player action ["SwitchWeapon", PRA3_Player, PRA3_Player, 99];
		};

		GVAR(MedicItemSelected) = _item;


		// Create a weapon holder and fill it with the dummy item.
		private _weaponHolder = createVehicle ["GroundWeaponHolder", [0, 0, 0], [], 0, "NONE"];
		_weaponHolder addItemCargoGlobal [_item, 1];

		// Attach it to the right hand.
		_weaponHolder attachTo [PRA3_Player, [-0.1, 0.6, -0.15], "rwrist"];
		_weaponHolder setVectorDirAndUp [[0, 0, -1], [0, 1, 0]];
		//[[_weaponHolder, [[0, 0, -1], [0, 1, 0]]], "setVectorDirAndUp"] call CFNC(execRemoteFnc);

		// And prevent it from being accessed.
		_weaponHolder enableSimulationGlobal false;

		_config = configFile >> "CfgActions" >> "SwitchWeapon";
		if ((primaryWeapon PRA3_Player != "") && getNumber (_config >> "show") == 1) then {
	        // Add the action and store the id to remove it on grenade mode exit.
	        GVAR(CancelAction) = PRA3_Player addAction [format [getText (_config >> "text"), getText (configFile >> "CfgWeapons" >> primaryWeapon PRA3_Player >> "displayName")], {
	            // Switch back to the primary weapon.
	            PRA3_Player action ["SwitchWeapon", PRA3_Player, PRA3_Player, 0];
	        }, nil, getNumber (_config >> "priority"), getNumber (_config >> "showWindow") == 1, getNumber (_config >> "hideOnUse") == 1, getText (_config >> "shortcut")];
	    };

		private _helpText = "";

		if (_item == "FirstAidKit") then {
			_helpText = "<img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\lmb_ca.paa'/> to bandage a comrade<br /><img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\rmb_ca.paa'/> to bandage yourself";
		} else {
			_helpText = "<img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\lmb_ca.paa'/> to heal a comrade<br /><img size='1.5' image='\a3\3DEN\Data\Displays\Display3DEN\Hint\rmb_ca.paa'/> to heal yourself";
		};

		disableSerialization;

		([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutRsc [UIVAR(MedicalProgress),"PLAIN",0.2];
		private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];

		{
			(_display displayCtrl _x) ctrlSetFade 1;
			(_display displayCtrl _x) ctrlCommit 0;
			false;
		} count [3001, 3002, 3003];

		(_display displayCtrl 3004) ctrlSetStructuredText parseText _helpText;
		(_display displayCtrl 3004) ctrlSetFade 0;
		(_display displayCtrl 3004) ctrlCommit 0;


		// Store the weapon holder to remove it on grenade mode exit.
		GVAR(MedicItemHolder) = _weaponHolder;
	};

	// ToDo write it with HodKeyEH @BadGuy
	// Todo write it Function based
	[
		"First Aid Kit", PRA3_Player,	0, {
			"FirstAidKit" in (items PRA3_Player) && {GVAR(MedicItemSelected) != "FirstAidKit"} && !(PRA3_Player getVariable [QGVAR(isUnconscious), false])
		},
		_itemAction, ["FirstAidKit"]
	] call CFUNC(addAction);

	[
		"Medikit", PRA3_Player,	0, {
			"Medikit" in (items PRA3_Player) && {GVAR(MedicItemSelected) != "Medikit"} && !(PRA3_Player getVariable [QGVAR(isUnconscious), false])
		},
		_itemAction, ["Medikit"]
	] call CFUNC(addAction);

	// To exit the grenade mode if the weapon is changed use currentWeaponChanged EH.
	["currentWeaponChanged", {
		(_this select 0) params ["_currentWeapon", "_oldWeapon"];

		if (_currentWeapon != "" && GVAR(MedicItemSelected) != "") then {
			disableSerialization;
			([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0.2;
			GVAR(MedicItemSelected) = "";
			deleteVehicle GVAR(MedicItemHolder);
			PRA3_Player removeAction GVAR(CancelAction);
			GVAR(MedicItemActivated) = -1;
			GVAR(MedicItemProgress) = 0;
		};

	}] call CFUNC(addEventhandler);

	[{
		// MOUSE EVENTS (FAK & Medikit)
		(findDisplay 46) displayAddEventHandler ["MouseButtonDown", {
			if (GVAR(MedicItemSelected) == "") exitWith {false};
			params ["_display", "_button"];
			if (_button > 1) exitWith {false};
			scopeName "MAIN";
			if (GVAR(MedicItemActivated) < 0) then {
				GVAR(MedicItemActivated) = _button;

				private _target = objNull;
				if (_button == 0) then {
					_target = cursorObject;
					if (!(typeOf _target isKindOf "CAManBase") || (PRA3_Player distance _target) > 3) then {breakTo "MAIN"};
				} else {
					_target = PRA3_Player;
				};
				GVAR(beginTickTime) = diag_tickTime;

				disableSerialization;

				private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];

				private _progressText = "Bandaging %1 ...";
				if (GVAR(MedicItemSelected) == "Medikit") then {
					private _progressText = "Healing %1 ...";
				};

				(_display displayCtrl 3003) ctrlSetStructuredText parseText format [_progressText, name _target];
				(_display displayCtrl 3002) progressSetPosition 0;

				{
					(_display displayCtrl _x) ctrlSetFade 0;
					(_display displayCtrl _x) ctrlCommit 0;
					false;
				} count [3001, 3002, 3003];


				[{
					(_this select 0) params ["_target"];
					private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];
					if (!(_target in [cursorObject, PRA3_Player]) || GVAR(MedicItemActivated) < 0 || GVAR(MedicItemSelected) == "" || PRA3_Player getVariable [QGVAR(isUnconscious), false]) exitWith {
						GVAR(MedicItemProgress) = 0;
						{
							(_display displayCtrl _x) ctrlSetFade 1;
							(_display displayCtrl _x) ctrlCommit 0.5;
							false;
						} count [3001, 3002, 3003];
						[_this select 1] call CFUNC(removePerFrameHandler);
					};


					if (GVAR(MedicItemSelected) == "Medikit") then {
						private _maxHeal = 0.75;
						private _healSpeed = 60;
						if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
							private _maxHeal = 1;
							private _healSpeed = 10;
						};

						GVAR(MedicItemProgress) = (diag_tickTime - GVAR(beginTickTime)) / _healSpeed;

						if (GVAR(MedicItemProgress)>= 1) then {
							_target setDamage _maxHeal;
							_target forceWalk false;
							GVAR(MedicItemActivated) = -1;
						};

					} else {
						private _healSpeed = 60;
						if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
							private _healSpeed = 10;
						};

						GVAR(MedicItemProgress) = (diag_tickTime - GVAR(beginTickTime)) / _healSpeed;

						if (GVAR(MedicItemProgress)>= 1) then {
							_target setVariable [QGVAR(bloodLoss), 0, true];
							PRA3_Player removeItem GVAR(MedicItemSelected);
							GVAR(MedicItemActivated) = -1;
						};
					};


					(_display displayCtrl 3002) progressSetPosition GVAR(MedicItemProgress);


				}, 0, [_target]] call CFUNC(addPerFrameHandler);

				true;
			};
			false;
		}];

		(findDisplay 46) displayAddEventHandler ["MouseButtonUp", {
			if (GVAR(MedicItemSelected) == "") exitWith {};
			params ["_display", "_button"];
			if (_button == GVAR(MedicItemActivated)) exitWith {
				GVAR(MedicItemActivated) = -1;
			};
			false;
		}];

		//SPACE REVIVE
		(findDisplay 46) displayAddEventHandler ["KeyDown", {
			params ["_ctrl","_key"];
			if (_key != 57 || GVAR(reviveKeyPressed)) exitWith {false};

			private _target = cursorObject;

			if (!(typeOf _target isKindOf "CAManBase") || {(PRA3_Player distance _target) > 3}) exitWith {false};

			if !(_target getVariable [QGVAR(isUnconscious), false]) exitWith {false};

			GVAR(reviveKeyPressed) = true;

			GVAR(beginTickTime) = diag_tickTime;

			disableSerialization;

			([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutRsc [UIVAR(MedicalProgress),"PLAIN",0.2];
			private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];

			(_display displayCtrl 3002) ctrlSetStructuredText parseText format ["Reviving %1 ...", name _target];


			{
				(_display displayCtrl _x) ctrlSetFade 0;
				(_display displayCtrl _x) ctrlCommit 0;
				false;
			} count [3001, 3002, 3003];

			(_display displayCtrl 3004) ctrlSetFade 1;
			(_display displayCtrl 3004) ctrlCommit 0;




			[{
				(_this select 0) params ["_target"];

				if (cursorObject != _target || !GVAR(reviveKeyPressed) || PRA3_Player getVariable [QGVAR(isUnconscious), false]) exitWith {
					([UIVAR(MedicalProgress)] call BIS_fnc_rscLayer) cutFadeOut 0.2;
					[_this select 1] call CFUNC(removePerFrameHandler);
				};

				private _reviveSpeed = 60;
				if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
					_reviveSpeed = 20;
				};

				GVAR(MedicItemProgress) = (diag_tickTime - GVAR(beginTickTime)) / _reviveSpeed;

				if (GVAR(MedicItemProgress)>= 1) then {
					_target setVariable [QGVAR(isUnconscious), false, true];
					["UnconsciousnessChanged", _target, [false, _target]] call CFUNC(targetEvent);
					GVAR(reviveKeyPressed) = false;
				};
				disableSerialization;
				private _display = uiNamespace getVariable [UIVAR(MedicalProgress),displayNull];

				(_display displayCtrl 3002) progressSetPosition GVAR(MedicItemProgress);

			}, 0, [_target]] call CFUNC(addPerFrameHandler);

			true;
		}];

		(findDisplay 46) displayAddEventHandler ["KeyUp", {
			params ["_ctrl","_key"];

			if (_key == 57) then {
				GVAR(reviveKeyPressed) = false;
			};
			false;
		}];
	}, {!isNull (findDisplay 46)}, _this] call CFUNC(waitUntil);


	/*

	// ToDo write it with HodKeyEH @BadGuy
	// Todo write it Function based
	[
		"Stop Bleeding",
		"CAManBase",
		5,
		{
			_target getVariable [QGVAR(bloodLoss), 0] != 0 &&
			{!(_target getVariable [QGVAR(medicalActionIsInProgress), false])} &&
			{"FirstAidKit" in (items PRA3_Player) || {"FirstAidKit" in (items _target)}}
		}, {
			private _healSpeed = 60;
			if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
				private _healSpeed = 10;
			};
			[{(_this select 0) setVariable [QGVAR(bloodLoss), 0, true];}, _healSpeed, cursorObject] call CFUNC(wait);
		}
	] call CFUNC(addAction);

	[
		"Heal Unit",
		"CAManBase",
		5,
		{
			_target getVariable [QGVAR(bloodLoss), 0] == 0 &&
			{!(_target getVariable [QGVAR(isUnconscious), false])} &&
			{!(_target getVariable [QGVAR(medicalActionIsInProgress), false])} &&
			{"Medikit" in (items PRA3_Player) || {"Medikit" in (items _target)}}
		}, {
			private _maxHeal = 0.75;
			private _healSpeed = 60;
			if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
				private _maxHeal = 1;
				private _healSpeed = 10;
			};
			[{(_this select 0) setDamage (_this select 1); (_this select 0) forceWalk false;}, _healSpeed, [cursorObject, 1 - _maxHeal]] call CFUNC(wait);
		}
	] call CFUNC(addAction);

	[
		"Revive Unit",
		"CAManBase",
		5,
		{
			_target getVariable [QGVAR(bloodLoss), 0] == 0 &&
			_target getVariable [QGVAR(isUnconscious), false] &&
			{!(_target getVariable [QGVAR(medicalActionIsInProgress), false])}
		}, {
			private _reviveSpeed = 60;
			if (PRA3_Player getVariable [QGVAR(isMedic), false]) then {
				_reviveSpeed = 20;
			};
			[{
				_this setVariable [QGVAR(isUnconscious), false, true];
				["UnconsciousnessChanged", _this, [false, _this]] call CFUNC(targetEvent);
			}, _reviveSpeed, cursorObject] call CFUNC(wait);
		}
	] call CFUNC(addAction);

    ["FirstAidKit", PRA3_Player, 0, {
        "FirstAidKit" in (items PRA3_Player)
    }, {
        PRA3_Player action ["SwitchWeapon", PRA3_Player, PRA3_Player, 99];
    }] call CFUNC(addAction);




	GVAR(actionKeyPressed) = false;
	[{
		(findDisplay 46) displayAddEventHandler ["KeyDown", {
			params ["_ctrl","_key"];

			if (_key == 57 && !GVAR(actionKeyPressed) && {typeOf cursorObject isKindOf "CAManBase" && (PRA3_Player distance cursorObject) < 3}) then {
				GVAR(actionKeyPressed) = true;
				[{
					(_this select 0) params ["_target"];
					if (cursorObject != _target || !GVAR(actionKeyPressed)) exitWith {
						[_this select 1] call CFUNC(removePerFrameHandler);
					};

					if (!isNull GVAR(actions)) then {
						{
							_x params ["_condition", "_code"];

							if (_condition) then _code;
						} count GVAR(actions);
					};
				}, 0, [cursorObject]] call CFUNC(addPerFrameHandler);

				hint "SPACE DOWN";
				true;
			};
			false;
		}];

		(findDisplay 46) displayAddEventHandler ["KeyUp", {
			params ["_ctrl","_key"];

			if (_key == 57) then {
				GVAR(actionKeyPressed) = false;

				hint "SPACE UP";
			};
			false;
		}];
	}, {!isNull (findDisplay 46)}, _this] call CFUNC(waitUntil);
	*/

};
