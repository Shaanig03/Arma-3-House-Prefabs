if (!isServer) exitWith {};

// server only 


[] spawn {
	while {true} do {
		// if house prefab spawning is enabled
		if (sblib_housePrefab_enabled) then {
			// loop through each global active houses
			{
				private _x_house = _x;
				
				// if there are no players within the spawn range of this house 
				// and if memory points are active (loot are spawned)
				// attempt to despawn them
				if ({_x distance _x_house <= sblib_housePrefab_spawnRadius} count allPlayers == 0) then {
					// if house is not processing, not in the state of spawning/despawning
					if (!(_x in sblib_housePrefab_activeHousesGlobalProcessing)) then {
						// get prefab name
						private _prefabName = _x getVariable "hp_p";
						
						// to wait until prefab name initializes
						if (!isNil {_prefabName}) then {
							// despawn memory codes
							[_x, _prefabName, false, false] call houseprefabs_fnc_spawnPrefab;
						};
					};
				};
				
				sleep 0.1;
				
			} forEach sblib_housePrefab_activeHousesGlobal;
		};
		sleep 1;
	};
};