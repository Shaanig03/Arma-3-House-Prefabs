/*
	spawns/despawns a prefab
*/
params ["_house","_prefabName",["_spawnOrDespawn", true],["_isLocal_or_globalMemoryScripts", true]];




// get prefab data (stored objects to spawn, memory points)
private _varName_prefabData = format ["houseprefab_%1_%2_data", typeOf _house, _prefabName];
private _prefabData = missionNamespace getVariable _varName_prefabData;

// if no prefab was found for this house then set 'hp_disabled' to true to ignore this house 
if (isNil {_prefabData}) exitWith {
	_house setVariable ["hp_disabled", true];
};


// despawn
if (!_spawnOrDespawn) exitWith {
	if (_isLocal_or_globalMemoryScripts) then {
		// despawn local objects (only for the local player)
		
		// exit if house is not in local active houses or if house is still in the process of locally spawning objects
		if (!(_house in sblib_housePrefab_activeHousesLocal) || _house in sblib_housePrefab_activeHousesLocalProcessing) exitWith {};
		
		// add house to processing houses that is in the process of despawning
		sblib_housePrefab_activeHousesLocalProcessing = sblib_housePrefab_activeHousesLocalProcessing + [_house];
		
		// remove house from local active houses
		sblib_housePrefab_activeHousesLocal = sblib_housePrefab_activeHousesLocal - [_house];
		
		
		
		
		private _localObjects = _house getVariable ["hp_lo", []];
		
		// despawn local objects
		{
			if (!isNull _x) then {
				deleteVehicle _x;
			};
		} forEach _localObjects;
		
		_house setVariable ["hp_lo", nil];
		
		// remove house from local processing houses
		sblib_housePrefab_activeHousesLocalProcessing = sblib_housePrefab_activeHousesLocalProcessing - [_house];
		
		
		// if house is in global active houses
		if (_house in sblib_housePrefab_activeHousesGlobal) then {
	
			// execute for server 
			// despawn memory points
			[[_house, _prefabName], {
				params ["_house","_prefabName"];
				
				// if there is no player near within this house
				if ({_x distance _house <= sblib_housePrefab_spawnRadius} count allPlayers == 0) then {
					// despawn memory points
					[_house, _prefabName, false, false] call houseprefabs_fnc_spawnPrefab;
				};
			}] remoteExec ["bis_fnc_call", 2];
		
		};
		
	
	} else {
		// despawning memory points can be only called on server 
		if (!isServer) exitWith {};
		
		// exit if house is not in global active houses or if house in still in the process of spawning/despawning
		if (!(_house in sblib_housePrefab_activeHousesGlobal) || _house in sblib_housePrefab_activeHousesGlobalProcessing) exitWith {};
		
		// add house to processing (in the despawning of memory points)
		private _global_processing_houses = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobalProcessing", []];
		_global_processing_houses = _global_processing_houses + [_house];
		missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobalProcessing", _global_processing_houses, true];

		// remove house from global active houses
		private _active_global_houses = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobal", []];
		_active_global_houses = _active_global_houses - [_house];
		missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobal", _active_global_houses, true];
	
		
		// get created memory points
		private _saved_memoryPointData = _house getVariable ["hp_mp", []];
		private _length = (count _saved_memoryPointData) - 1;
		
		// get prefab memory points
		private _prefabMemoryPoints =_prefabData select 1;
		{
			_x params ["_memoryPointName","_memoryRelativePosDir",["_memoryArgs", []],"_memoryPointCode"];
			
			private _i = sblib_housePrefab_memoryPointKeys find _memoryPointName;
		
			// if a memory point is defined
			if (_i != -1) then {
				// if provided memory point code is nil
				if (isNil {_memoryPointCode}) then {
					// select the defined memory point code
					_memoryPointCode = sblib_housePrefab_memoryPointCodes select _i;
				};
			};
			
			// get memory point data
			private _memoryPointData = [];
			private _memoryPointIndex = _forEachIndex;
			if (_length >= _memoryPointIndex) then {
				_memoryPointData =_saved_memoryPointData select _memoryPointIndex;
			};
			
			// get relative position & direction
			_memoryRelativePosDir params ["_relativePos","_relativeDir"];
			
			
			private _housePos = getPosATL _house;
			private _houseDir = (getDir _house) * -1;
			// get relative object position and add+ the offset position of the pasted object
			private _newObjectPos = (_housePos vectorAdd _relativePos);
			
			// rotate position from relative object's center
			_newObjectPos = [_newObjectPos, _housePos, _houseDir] call extra_fnc_rotatePosFromCenter;
			private _vectorDirAndUp = [_relativeDir, _houseDir, 0, 0] call BIS_fnc_transformVectorDirAndUp;
			
			// execute memory point code
			[_memoryPointName, false, [_newObjectPos, _vectorDirAndUp], _memoryArgs, _memoryPointData, _memoryPointIndex, _house] call _memoryPointCode;
			
		} forEach _prefabMemoryPoints;
		
		
		
		
		
		// remove house from global processing houses when it's finished despawning
		private _global_processing_houses = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobalProcessing", []];
		_global_processing_houses = _global_processing_houses - [_house];
		missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobalProcessing", _global_processing_houses, true];
	};
};


// spawn





	

// if prefab objects is spawning for a player locally excluding the other players
if (_isLocal_or_globalMemoryScripts) then {
	
	// exit if house already locally spawned objects for this player
	if (_house in sblib_housePrefab_activeHousesLocal || _house in sblib_housePrefab_activeHousesLocalProcessing) exitWith {};
	
	// store house prefab inside house (locally)
	if (isNil {_house getVariable "hp_p"}) then {
	
		// store prefab name locally & for server
		_house setVariable ["hp_p", _prefabName];
		
		[[_house, _prefabName],{
			params ["_house","_prefabName"];
			_house setVariable ["hp_p", _prefabName];
		}] remoteExec ["bis_fnc_call", 2];
		
	};
		
	// add house to locally active houses
	sblib_housePrefab_activeHousesLocal = sblib_housePrefab_activeHousesLocal + [_house];
	sblib_housePrefab_activeHousesLocalProcessing = sblib_housePrefab_activeHousesLocalProcessing + [_house];
	
	// get prefab objects & memory points
	_prefabData params ["_prefabObjects"];
	
	// spawn local objects for the player 
	private _localObjects = [];
	{
		private _localObject = [_x, true, _house] call extra_fnc_pasteObject;
		
		if (!sblib_housePrefab_enableSimulation) then {
			_localObject enableSimulationGlobal false;
		};
		
		
		
		
		_localObjects = _localObjects + [_localObject];
	} forEach _prefabObjects;
	
	// store local objects in a variable locally 
	_house setVariable ["hp_lo", _localObjects];
	
	// remove house from local processing (when local objects are finished spawning)
	if (_house in sblib_housePrefab_activeHousesLocalProcessing) then {sblib_housePrefab_activeHousesLocalProcessing = sblib_housePrefab_activeHousesLocalProcessing - [_house];};
	
	// if house is not activated globally
	if (!(_house in sblib_housePrefab_activeHousesGlobal)) then {
	
		// activate the memory points
		// to execute the memory points (the loot/scripts, so it would sync for all players)
		[[_house, _prefabName], {
			params ["_house","_prefabName"];
			[_house, _prefabName, true, false] call houseprefabs_fnc_spawnPrefab;
		}] remoteExec ["bis_fnc_call", 2];
		
	};
	/*
	sblib_housePrefab_activeHousesGlobal = [];
publicVariable "sblib_housePrefab_activeHousesGlobal";
sblib_housePrefab_activeHousesGlobalProcessing = [];
	*/
} else {
	// spawning can be only called on server 
	if (!isServer) exitWith {};
	
	// execute memory point scripts globally 

	// exit if house is already in global active houses
	if (_house in sblib_housePrefab_activeHousesGlobal || _house in sblib_housePrefab_activeHousesGlobalProcessing) exitWith {};
	
	// add house to global active houses
	private _activeHousesGlobal = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobal", []];
	_activeHousesGlobal = _activeHousesGlobal + [_house];
	missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobal", _activeHousesGlobal, true];
	
	// add house to global active processing houses
	private _activeHousesGlobalProcessing = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobalProcessing", []];
	_activeHousesGlobalProcessing = _activeHousesGlobalProcessing + [_house];
	missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobalProcessing", _activeHousesGlobalProcessing, true];
	
	private _created_memoryPoints = [];
	
	private _saved_memoryPointDatas = _house getVariable ["hp_mp", []];
	private _saved_memoryPointLength = (count _saved_memoryPointDatas) - 1;
	
	// get prefab memory points
	private _prefabMemoryPoints =_prefabData select 1;
	{
		
		// execute memory point code
		_x params ["_memoryPointName","_memoryRelativePosDir",["_memoryArgs", []],"_memoryPointCode"];
		
		//	_prefabMemoryPoints pushBack [_memoryPointName, [getPosATL _x_editorObject, getDir _x_editorObject], _memory_args, _memoryPointCode, []];
		
		private _i = sblib_housePrefab_memoryPointKeys find _memoryPointName;
		
		// if a memory point is defined
		if (_i != -1) then {
			// if provided memory point code is nil
			if (isNil {_memoryPointCode}) then {
				// select the defined memory point code
				_memoryPointCode = sblib_housePrefab_memoryPointCodes select _i;
			};
		};
		
		// load memory point data
		private _memoryPointData = [];
		if (_saved_memoryPointLength >= _forEachIndex) then {
			_memoryPointData =_saved_memoryPointDatas select _forEachIndex;
		};
		
		_memoryRelativePosDir params ["_relativePos","_relativeDir"];
		
		//	get memory point position & direction
			// get house position
			private _housePos = getPosATL _house;
			private _houseDir = (getDir _house) * -1;
			// get relative object position and add+ the offset position of the pasted object
			private _newObjectPos = _house modelToWorld _relativePos;
			
			// rotate position from relative object's center
			//_newObjectPos = [_newObjectPos, _housePos, _houseDir] call extra_fnc_rotatePosFromCenter;
			private _vectorDirAndUp = [_relativeDir, _houseDir, 0, 0] call BIS_fnc_transformVectorDirAndUp;
			
			
		
		
		
		
		
		// store memory point name & data
		_created_memoryPoints pushBack [_memoryPointName, [_newObjectPos, _vectorDirAndUp], _memoryPointData];
		
		// set house prefab (stored memory points)
		_house setVariable ["hp_mp", _created_memoryPoints];
		
		// execute memory point code
		[_memoryPointName, true, [_newObjectPos, _vectorDirAndUp], _memoryArgs, _memoryPointData, _forEachIndex, _house] call _memoryPointCode;
	} forEach _prefabMemoryPoints;
	
	
	
	// remove house from global active processing houses when it's finished the process of spawning memory points
	private _activeHousesGlobalProcessing = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobalProcessing", []];
	
	if (_house in _activeHousesGlobalProcessing) then {
		_activeHousesGlobalProcessing = _activeHousesGlobalProcessing - [_house];
		missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobalProcessing", _activeHousesGlobalProcessing, true];
	};
	
};