// exit if not a player
if (!hasInterface) exitWith {};


// wait until player initializes
waitUntil {!isNull player && player == player};

private _init = {
	params ["_player"];
	
	[_player] spawn {
		params ["_player"];
		
		while {alive _player} do {
		
			// get nearby houses
			private _houses = nearestObjects [getPos _player, sblib_housePrefab_classes, sblib_housePrefab_spawnRadius];
			
			
			// loop through each local active houses
			{
				// if house is no longer within spawn range
				if (!(_x in _houses)) then {
					// if house is not in the process of spawning/despawning
					if (!(_x in sblib_housePrefab_activeHousesLocalProcessing)) then {
						// get house seed
						private _seed = [_x] call houseprefabs_fnc_houseSeed;
						
						// get prefab 
						private _prefabName = _x getVariable "hp_p";
						[_x, _prefabName, false, true] spawn houseprefabs_fnc_spawnPrefab;
					};
				};
			} forEach sblib_housePrefab_activeHousesLocal;
			
			
			
			// loop through each house
			{
				// if house exists && house is not destroyed
				if (alive _x) then {
					// if spawning house prefabs is not disabled for this house && house is not in local active houses && house is not in local processing houses
					if (isNil {_x getVariable "hp_disabled"} && !(_x in sblib_housePrefab_activeHousesLocal) && !(_x in sblib_housePrefab_activeHousesLocalProcessing)) then {
						// get house class 
						private _houseClass = typeOf _x;
						private _houseIndex = sblib_housePrefab_houseClasses find _houseClass;
						
						// if a prefab is defined for this house class
						if (_houseIndex != -1) then {
						
							// generate a seed to select a prefab based on position 
							//private _x_housePos = getPos _x;
						
							// generate a seed from the position (X,Y,Z) values, so all players can see the same prefab in the same house
							//private _seed = ((_x_housePos select 0) * 0.5) + ((_x_housePos select 1) * 0.5) + ((_x_housePos select 2) * 0.5);
							private _seed = [_x] call houseprefabs_fnc_houseSeed;
							
							// get defined prefabs 
							private _definedPrefabs = sblib_housePrefab_prefabNames select _houseIndex;
							private _length_definedPrefabs = (count _definedPrefabs) - 1;
							
							// select a prefab through seed
							private _seed_selection_index = round(_seed random(_length_definedPrefabs));
							private _selectedPrefab =_definedPrefabs select _seed_selection_index;
							[_x, _selectedPrefab, true, true] spawn houseprefabs_fnc_spawnPrefab;
						};
					};
				};
			} forEach _houses;
			
			sleep sblib_housePrefab_sleepDelay;
		};
	};
};

sblib_housePrefab_activeHousesLocal = [];
sblib_housePrefab_activeHousesLocalProcessing = [];

[player] call _init;
player addEventHandler ["Respawn", _init];