params ["_houseObject",["_global", false], ["_selectedPrefabOrSeed", random(99999)]];

private _houseClass = typeOf _houseObject;
private _houseIndex = sblib_housePrefab_houseClasses find _houseClass;

// exit if no prefab is defined for this house
if (_houseIndex == -1) exitWith {
	// set house prefab disabled to true
	_houseObject setVariable ["hpd", true];
};

private _selectedPrefab = _selectedPrefabOrSeed;

private _failed_to_select_prefab = false;

// if a number is provided
if (typeName _selectedPrefabOrSeed == "SCALAR") then {
	// get defined prefabs for this house class
	private _definedPrefabs = sblib_housePrefab_prefabNames select _houseIndex;
	private _count_definedPrefabs = count _definedPrefabs;
	
	// if there aren't any defined prefabs for this house class
	if (_count_definedPrefabs == 0) exitWith {
		// set house prefab disabled to true
		_houseObject setVariable ["hpd", true];
		_failed_to_select_prefab = true;
	};
	
	// select a random s
	private _selectedPrefabIndex = round (_selectedPrefabOrSeed random(_count_definedPrefabs-1));
	_selectedPrefab =_definedPrefabs select _selectedPrefabIndex;
};


if (_failed_to_select_prefab) exitWith {};


// get prefab data
private _str_varName_prefabObjects = format ["houseprefab_%1_%2_data", _houseClass, _selectedPrefab];
private _prefabData = missionNamespace getVariable _str_varName_prefabObjects;

// exit if prefab data is not defined
if (isNil {_prefabData}) exitWith {
	systemChat format [sblib_houseprefab_error_prefabDataNotFound, _selectedPrefab];
};
	
	
	
	
// get prefab objects & memory points
_prefabData params ["_prefabObjects","_prefabMemoryPoints"];
	
if (!_global) then {
	// spawn local objects
	private _spawnedObjects = [];
	{
		private _spawnedObject = [_x, true, _houseObject, 0] call extra_fnc_pasteObject;
		_spawnedObjects = _spawnedObjects + [_spawnedObject];
	} forEach _prefabObjects;
	
	// house prefab objects
	_houseObject setVariable ["hpo", _spawnedObjects];
	
	if (_houseObject in sblib_housePrefab_activeHousesLocalProcessing) then {
		sblib_housePrefab_activeHousesLocalProcessing = sblib_housePrefab_activeHousesLocalProcessing - [_houseObject];
	};
	
	// get local player & player uid
	private _player = player;
	private _uid = getPlayerUID _player;
	
	// get active uids
	private _active_uids = _houseObject getVariable ["hp_uids", []];
	if (!(_uid in _active_uids)) then {
		_active_uids pushBack _uid;
		_houseObject setVariable ["hp_uids", _active_uids, true];
	};
	
} else {
	{
		_x params ["_memoryName","_memoryArgs","_memoryCode"];
		
	
		private _memoryIndex = sblib_housePrefab_memoryPointKeys find _memoryName;
		
		// if defined memory was found
		if (_memoryIndex != -1) then {
			// if code is not provided
			if (isNil {_memoryCode}) then {
				// get the defined memory code
				_memoryCode = sblib_housePrefab_memoryPointCodes select _memoryIndex;
			};
		
		};
		
		[_houseObject, _memoryArgs, true] call _memoryCode;
	} forEach _prefabMemoryPoints;
	
	if (isNil {_houseObject getVariable "hp_p"}) then {
		_houseObject setVariable ["hp_p", _selectedPrefab, true];
	};
	_processingGlobal = missionNamespace getVariable ["sblib_housePrefab_activeHousesGlobalProcessing", []];
	if (_houseObject in _processingGlobal) then {
		_processingGlobal = _processingGlobal - [_houseObject];
		missionNamespace setVariable ["sblib_housePrefab_activeHousesGlobalProcessing", _processingGlobal, true];
	};
	
	
};