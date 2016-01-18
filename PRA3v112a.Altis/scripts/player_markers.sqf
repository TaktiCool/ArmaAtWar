/*
	
	AUTHOR: aeroson
	NAME: player_markers.sqf
	VERSION: 2.6
	
	DOWNLOAD & PARTICIPATE:
		https://github.com/aeroson/a3-misc
		http://forums.bistudio.com/showthread.php?156103-Dynamic-Player-Markers
	
	DESCRIPTION:
		A script to mark players on map
		All markers are created locally
		Designed to be dynamic, small and fast
		Shows driver/pilot, vehicle name and number of passengers
		Click vehicle marker to unfold its passengers list
		Lets BTC mark unconscious players
		Shows Norrin's revive unconscious units
		Shows who is in control of UAV unit
	
	USAGE:
		in (client's) init do:		
		0 = [] execVM 'player_markers.sqf';
		this will show players for your side in multiplayer
		or you and all ais on your side in singleplayer
		
		to change this you can add any of the following options
			"players" will show players
			"ais" will show ais
			"allsides" will show all sides not only the units on player's side
		0 = ["player","ai"] execVM 'player_markers.sqf';
		this will show all player and all ais, you can add allside if you want to show all sides 
		once you add any of these default behaviour is not used								 			 	

*/
				   
if (isDedicated) exitWith {}; // is server  
if (!isNil{aero_player_markers_pos}) exitWith {}; // already running
				   
private ["_marker","_markerText","_temp","_unit","_vehicle","_markerNumber","_show","_injured","_text","_num","_getNextMarker","_getMarkerColor","_showAllSides","_showPlayers","_showAIs","_l"];

_showAllSides=false;
_showPlayers=false;
_showAIs=false;

if(count _this==0) then {
	_showAllSides=false;
	_showPlayers=true;
	_showAIs=!isMultiplayer;
};
                         
{
	_l=toLower _x;
	if(_l in ["player","players"]) then {
		_showPlayers=true;
	};
	if(_l in ["ai","ais"]) then {
		_showAIs=true;
	};
	if(_l in ["allside","allsides"]) then {
		_showAllSides=true;
	};
} forEach _this;

aero_player_markers_pos = [0,0];
onMapSingleClick "aero_player_markers_pos=_pos;";

_getNextMarker = {
	private ["_marker"]; 
	_markerNumber = _markerNumber + 1;
	_marker = format["um%1",_markerNumber];	
	if(getMarkerType _marker == "") then {
		createMarkerLocal [_marker, _this];
	} else {
		_marker setMarkerPosLocal _this;
	};
	_marker;
};

_getMarkerColor = {	
	[(((side _this) call bis_fnc_sideID) call bis_fnc_sideType),true] call bis_fnc_sidecolor;
};

while {true} do {
	  
	waitUntil {
		sleep 0.025;
		true;
	};
	
	_markerNumber = 0; 
	
	// show players or player's vehicles
	{
		_show = false;
		_injured = false;
		_unit = _x;
		
		if(
			(
				(_showAIs && {!isPlayer _unit} && {0=={ {_x==_unit} count crew _x>0} count allUnitsUav}) ||
				(_showPlayers && {isPlayer _unit})
			) && {
				_showAllSides || group _unit==group player
			}
		) then {	
			if((crew vehicle _unit) select 0 == _unit) then {
				_show = true;
			};		
			if(!alive _unit || damage _unit > 0.9) then {
				_injured = true;
			};	  
			if(!isNil {_unit getVariable "hide"}) then {
				_show = false;
			};  
			if(_unit getVariable ["BTC_need_revive",-1] == 1) then {
				_injured = true;
				_show = false;
			};		  
			if(_unit getVariable ["NORRN_unconscious",false]) then {
				_injured = true;
			};	  			
		};
			  	 
		if(_show) then {
			_vehicle = vehicle _unit;  				  	
			_pos = getPosATL _vehicle;		  					
			_color = _unit call _getMarkerColor;  

			_markerText = _pos call _getNextMarker;						
			_markerText setMarkerColorLocal _color;	 						 				
 			_markerText setMarkerTypeLocal "c_unknown";		  			   
			_markerText setMarkerSizeLocal [0.5,0];

			_marker = _pos call _getNextMarker;			
			_marker setMarkerColorLocal _color;
			_marker setMarkerDirLocal getDir _vehicle;
			_marker setMarkerTypeLocal "mil_triangle";
			_marker setMarkerTextLocal "";			
			if(_vehicle == vehicle player) then {
				_marker setMarkerSizeLocal [0.5,1];
			} else {
				_marker setMarkerSizeLocal [0.3,0.7];
			};
			
 			if(_vehicle != _unit && !(_vehicle isKindOf "ParachuteBase")) then {			 						
				_text = format["[%1]", getText(configFile>>"CfgVehicles">>typeOf _vehicle>>"DisplayName")];
				if(!isNull driver _vehicle) then {
					_text = format["%1 %2", name driver _vehicle, _text];	
				};							 						
				
				if((aero_player_markers_pos distance getPosATL _vehicle) < 50) then {
					aero_player_markers_pos = getPosATL _vehicle;
					_num = 0;
					{
						if(alive _x && isPlayer _x && _x != driver _vehicle) then {						
							_text = format["%1%2 %3", _text, if(_num>0)then{","}else{""}, name _x];
							_num = _num + 1;
						};						
					} forEach crew _vehicle; 
				} else { 
					_num = {alive _x && isPlayer _x && _x != driver _vehicle} count crew _vehicle;
					if (_num>0) then {					
						if (isNull driver _vehicle) then {
							_text = format["%1 %2", _text, name (crew _vehicle select 0)];
							_num = _num - 1;
						};
						if (_num>0) then {
							_text = format["%1 +%2", _text, _num];
						};
					};
				};	 					
			} else {
				_text = name _x;			
			};
			_markerText setMarkerTextLocal _text;
		};
		
	} forEach allUnits;


	// show player controlled uavs
	{
		if(isUavConnected _x) then {	
			_unit=(uavControl _x) select 0;
			if(
				(				
					(_showAIs && {!isPlayer _unit}) || 
					(_showPlayers && {isPlayer _unit})
				) && {
					_showAllSides || side _unit==side player
				}
			) then {
				_color = _x call _getMarkerColor;								  										  				
				_pos = getPosATL _x;
				
				_marker = _pos call _getNextMarker;			
				_marker setMarkerColorLocal _color;
				_marker setMarkerDirLocal getDir _x;
				_marker setMarkerTypeLocal "mil_triangle";			
				_marker setMarkerTextLocal "";
				if(_unit == player) then {
					_marker setMarkerSizeLocal [0.5,1];
				} else {
					_marker setMarkerSizeLocal [0.3,0.7];
				};
									  		
				_markerText = _pos call _getNextMarker;	
				_markerText setMarkerColorLocal _color;	   
				_markerText setMarkerTypeLocal "c_unknown";
				_markerText setMarkerSizeLocal [0.5,0];
				_markerText setMarkerTextLocal format["%1 [%2]", name _unit, getText(configFile>>"CfgVehicles">>typeOf _x>>"DisplayName")];	
			};
		};
	} forEach allUnitsUav; 
	
	
	

	_markerNumber = _markerNumber + 1;
	_marker = format["um%1",_markerNumber];	
	while {(getMarkerType _marker) != ""} do {
		deleteMarkerLocal _marker;
		_markerNumber = _markerNumber + 1;
		_marker = format["um%1",_markerNumber];
	};
	 
};
