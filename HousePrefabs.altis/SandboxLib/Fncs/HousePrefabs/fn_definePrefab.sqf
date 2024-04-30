if (!isServer) exitWith {};

params ["_prefabHouseClass","_prefabName","_prefabObjects",["_prefabMemoryPoints", []]];



//  add prefab house class if it doesn't exist
if (!(_prefabHouseClass in sblib_housePrefab_houseClasses)) then {
	sblib_housePrefab_houseClasses pushBack _prefabHouseClass;
	publicVariable "sblib_housePrefab_houseClasses";
	sblib_housePrefab_prefabNames pushBack [];
	publicVariable "sblib_housePrefab_prefabNames";
};


// get prefab house class index
private _prefabHouseClass_index = sblib_housePrefab_houseClasses find _prefabHouseClass;

// get defined prefab names (for this house class)
private _defined_prefabNames = sblib_housePrefab_prefabNames select _prefabHouseClass_index;


// if prefab name is empty
if (_prefabName == "") then {
	private _assigning_index = (count sblib_housePrefab_prefabNames) + 1;
	_prefabName = format ["prefab%1", _assigning_index];
};


// if prefab name already exists for this house class
if (_prefabName in _defined_prefabNames) exitWith {
	systemChat format [sblib_houseprefab_error_prefabAlreadyDefined, _prefabName, _prefabHouseClass];
};

// define prefab for this house class
_defined_prefabNames pushBack _prefabName;
sblib_housePrefab_prefabNames set [_prefabHouseClass_index, _defined_prefabNames];
publicVariable "sblib_housePrefab_prefabNames";

// global variable name to store house prefab objects
private _str_varName_prefabObjects = format ["houseprefab_%1_%2_data", _prefabHouseClass, _prefabName];

missionNamespace setVariable [_str_varName_prefabObjects, [_prefabObjects, _prefabMemoryPoints], true]; 
/*
sblib_housePrefab_prefabHouseClasses = [];
sblib_housePrefab_prefabDefinedPrefabNames = [];

// if prefab house class is not defined
if (!(_prefabHouseClass in sblib_housePrefab_prefabHouseClasses)) then {
	// add class & empty array to store prefab names 
	sblib_housePrefab_prefabHouseClasses pushBack _prefabHouseClass;
	sblib_housePrefab_prefabDefinedPrefabNames pushBack [];
};

// get class index
private _class_index = sblib_housePrefab_prefabHouseClasses find _prefabHouseClass;


// get defined prefab names for this house/object class
private _defined_prefabNames_for_class = sblib_housePrefab_prefabDefinedPrefabNames select _class_index;

// if prefab name is not assigned, assign a prefab name
if (_prefabName == "") then {
	private _count = (count _defined_prefabNames_for_class) + 1;
	private _prefabName = format ["prefab%1", _count];
};


// if a prefab with this name is already defined, exit
// note: prefab names have to be unique, this is to identify and retrieving data
if (_prefabName in _defined_prefabNames_for_class) exitWith {
	systemChat format [sblib_houseprefab_error_prefabAlreadyDefined, _prefabName, _prefabHouseClass];
}];*/