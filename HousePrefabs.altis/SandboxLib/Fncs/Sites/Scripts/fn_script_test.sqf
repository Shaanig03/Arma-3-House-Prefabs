params ["_areaName","_activated"];


if (!_activated) exitWith {
	private _civs = [_areaName, "civs", []] call sites_fnc_getVarArea;
	{
		if (!isNull _x) then {deleteVehicle _x};
	} forEach _civs;
	 [_areaName, "civs", []] call sites_fnc_setVarArea;
	 
	 systemChat "#t civs despawned";
};


private _grp = createGroup resistance;

// get area pos & radius
private _areaPos = [_areaName, "pos"] call sites_fnc_getVarArea;
private _areaRadius = [_areaName, "radius"] call sites_fnc_getVarArea;

// to store civilians
private _civilians = [];
private _activating = false;
private _exitLoop = false;

for "_i" from 1 to 30 do {
	if (_exitLoop) exitWith {};
	
	_activating = [_areaName, "activating"] call sites_fnc_getVarArea;
	if (!isNil {_activating}) then {
		if (!_activating) exitWith {
			_exitLoop = true;
			// if site is deactivating because there is no player nearby while the civilians are spawning, exit loop / stop spawning civilians
			systemChat "#t civs spawning exited because there is no player nearby";
		};
	};
	

	_man = _grp createUnit ["C_Man_1", _areaPos, [], _areaRadius, "FORM"];
	
	_civilians pushBack _man;
	

	private _marker = ["", getPos _man, str(_i), _man] call extra_fnc_debugMarker;
	if (_i != 30) then {
		_marker setMarkerColor "ColorGreen";
	} else {
		_marker setMarkerColor "ColorRed";
	};

	
	[_man, _areaPos, _areaRadius] spawn {
		params ["_man","_pos","_radius"];
		
		_grp = group _man;
		while {alive _man} do {
		
			{
				deleteWaypoint _x;
			} forEach (waypoints _grp);
			
			_wp = _grp addWaypoint [_pos, _radius];
			_wp setWaypointType "SAD";
			_wp setWaypointBehaviour "SAFE";
			_wp setWaypointSpeed "LIMITED";
		
			sleep 60;
		};	
	};
};

 systemChat "#t civs spawned";
[_areaName, "civs", _civilians] call sites_fnc_setVarArea;