// exit if not a player
if (!hasInterface) exitWith {};


// wait until player initializes
waitUntil {!isNull player && player == player};


sblib_housePrefab_activeHousesLocal = [];
sblib_housePrefab_activeHousesLocalProcessing = [];

private _init = {
	params ["_player"];
	
	[_player] spawn {
		params ["_player"];
		
		// while player is alive
		while {alive _player} do {
			
			// get house objects
			private _houseObjects = nearestObjects [getPosATL _player, sblib_housePrefab_classes, sblib_housePrefab_spawnRadius];
			
			
			// loop through each house object
			{
				// if house is not in the local processing array & not in active houses local
				if (
					!(_x in sblib_housePrefab_activeHousesLocalProcessing) && 
					!(_x in sblib_housePrefab_activeHousesLocal) &&
					isNil {_x getVariable "hpd"}
				) then {
					sblib_housePrefab_activeHousesLocal = sblib_housePrefab_activeHousesLocal + [_x];
					sblib_housePrefab_activeHousesLocalProcessing = sblib_housePrefab_activeHousesLocalProcessing + [_x];
					private _housePos = getPos _x;

					// house prefab random selection seed based on X,Y,Z positions
					private _seed = ((_housePos select 0) * 0.5) + ((_housePos select 1) * 0.5) + ((_housePos select 2) * 0.5);
					
					[_x, false, _seed] spawn houseprefabs_fnc_spawnPrefab;
					
					
					
					
					private _activeHousesGlobal = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobal", []];
					private _activeHousesGlobalProcessing = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobalProcessing", []];
					
					if (
						!(_x in _activeHousesGlobalProcessing) && 
						!(_x in _activeHousesGlobal)
					) then {
						_activeHousesGlobal = _activeHousesGlobal + [_x];
						_activeHousesGlobalProcessing = _activeHousesGlobalProcessing + [_x];
						missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobal", _activeHousesGlobal, true];
						missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobalProcessing", _activeHousesGlobalProcessing, true];
						
						// execute for server | dedicated
						[[_x, _seed],{
							params ["_houseObject","_seed"];
							[_houseObject, true, _seed] spawn houseprefabs_fnc_spawnPrefab;
						}] remoteExec ["spawn", 2];
					};
					
				};
			} forEach _houseObjects;
			
			sleep 1;
		};
	};
};


[player] call _init;
player addEventHandler ["Respawn", _init];