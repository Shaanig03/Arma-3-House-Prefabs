params ["_houseObject"];

// get house class
private _houseClass = typeOf _houseObject;
private _houseIndex = sblib_housePrefab_houseClasses find _houseClass;

// exit if no prefab is defined for this house
if (_houseIndex == -1) exitWith {
	// set house prefab disabled to true
	_houseObject setVariable ["hpd", true];
};


// else get defined prefabs for this house 

private _definedPrefabs = sblib_housePrefab_prefabNames select _houseIndex;

private _count_definedPrefabs = count _definedPrefabs;
// exit if no prefab is defined for this house
if (_count_definedPrefabs == 0) exitWith {
	// set house prefab disabled to true
	_houseObject setVariable ["hpd", true];
};

private _housePos = getPos _houseObject;

// house prefab random selection seed based on X,Y,Z positions
private _seed = ((_housePos select 0) * 0.5) + ((_housePos select 1) * 0.5) + ((_housePos select 2) * 0.5);

// select a random prefab
private _selectedPrefabIndex = round (_seed random(_count_definedPrefabs-1));
private _selectedPrefab =_definedPrefabs select _selectedPrefabIndex;

// get prefab data
private _str_varName_prefabObjects = format ["houseprefab_%1_%2_data", _houseClass, _selectedPrefab];
private _prefabData = missionNamespace getVariable _str_varName_prefabObjects;

// exit if prefab data is not defined
if (isNil {_prefabData}) exitWith {
	systemChat format [sblib_houseprefab_error_prefabDataNotFound, _selectedPrefab];
};

// get prefab objects & memory points
_prefabData params ["_prefabObjects","_prefabMemoryPoints"];

/*
params 
[
	"_objectData",
	["_isLocal", false],
	["_relativeObjectOrPos", objNull],
	["_relativePosRotation", 0]
];

*/
private _spawnedObjects = [];
{
	private _spawnedObject = [_x, true, _houseObject, 0] call extra_fnc_pasteObject;
	_spawnedObjects = _spawnedObjects + [_spawnedObject];
} forEach _prefabObjects;

// house prefab objects
_houseObject setVariable ["hpo", _spawnedObjects];