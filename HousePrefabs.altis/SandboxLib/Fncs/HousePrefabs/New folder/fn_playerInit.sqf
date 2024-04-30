// exit if not a player
if (!hasInterface) exitWith {};


// wait until player initializes
waitUntil {!isNull player && player == player};



/*
private _init = {
	params ["_player"];
	
	[_player] spawn {
		params ["_player"];
		
		// while player is alive 
		while {alive _player} do {
			// get player pos
			private _playerPos = getPosATL _player;
			
			// get nearby houses
			private _nearby_houses = nearestObjects [_playerPos, sblib_housePrefab_houseClasses, sblib_housePrefab_spawnRadius];
			
			
			// loop through each active house 
			{
				// if house is no longer in nearby houses
				if (!(_x in _nearby_houses)) then {
					// despawn prefab
					[_x] call houseprefabs_fnc_despawnPrefab;
				};
			} forEach sblib_housePrefab_activeHousesLocal;
			
			// count houses and execute code
			{
				// if house prefab is not disabled for this house & this house is not in active houses
				if (isNil {_x getVariable "hpd"} && !(_x in sblib_housePrefab_activeHousesLocal)) then {
					sblib_housePrefab_activeHousesLocal = sblib_housePrefab_activeHousesLocal + [_x];
					sblib_housePrefab_activeHousesLocalProcessing = sblib_housePrefab_activeHousesLocalProcessing + [_x];
					
					if (!(_x in sblib_housePrefab_activeHousesGlobal)) then {
						private _active_housesGlobal = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobal", []];
						_active_housesGlobal = _active_housesGlobal + [_x];
						missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobal", _active_housesGlobal, true];
						
						private _processing_houses = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobalProcessing", []];
						_processing_houses = _processing_houses + [_x];
						missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobalProcessing", _active_housesGlobal, true];
					};
					
					// spawn prefab
					[_x] call houseprefabs_fnc_spawnPrefab;
				};
			} count _nearby_houses;
			
			
			sleep 1;
		};
	};
};*/

[player] call _init;
player addEventHandler ["Respawn", _init];