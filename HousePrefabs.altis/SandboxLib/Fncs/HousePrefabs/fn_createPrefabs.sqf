#include "..\fn_config.sqf"



// get all editor objects
all3DENEntities params ["_editorObjects"];

// to store the prefab houses and it's objects
private _editor_prefab_houses = [];
private _editor_prefab_houseObjects = [];
private _editor_prefab_houseDatas = [];
private _editor_prefab_memoryPoints = [];

private _rotationErrorCount = 0;

// loop through each editor object to retrieve houses
{
	private _x_editorObject = _x;
	
	private _x_objectClass = typeOf _x;
	
	// if editor object is a house or is in house prefab classes & is not in excluding classes
	if (
		_x_editorObject isKindOf "House" || 
		_x_objectClass in sblib_housePrefab_classes &&
		!(_x_objectClass in sblib_housePrefab_excludingClasses)
	) then {
		// get object init
		private _x_objectInit = (_x_editorObject get3DENAttribute "Init") select 0;
		
		// if object init (string) contains "#houseprefab_local"
		if ("#houseprefab_local" in _x_objectInit) then {
			// if object init returns anything 
			//private _returnValue = call (compile _x_objectInit);
			private _displayName = getText (configFile >> "CfgVehicles" >> _x_objectClass >> "displayname");
			
			
			if (getDir _x_editorObject == 0) then {
				// add prefab house if rotation is zero
				_editor_prefab_houses pushBack _x_editorObject;
				_editorObjects = _editorObjects - [_x_editorObject];
				
				// add a empty array to store objects
				_editor_prefab_houseObjects pushBack [];
				
				// add a empty array for memory points 
				_editor_prefab_memoryPoints pushBack [];
				
				// get house data (contains prefab name)
				private _houseData = call (compile _x_objectInit);
				_editor_prefab_houseDatas pushBack _houseData;
				
				// disable editor house so it won't appear in game mission
				_x_editorObject set3DENAttribute ["presence" , 0];
				_x_editorObject set3DENAttribute ["presenceCondition" , "false"];
			} else {
				_rotationErrorCount = _rotationErrorCount + 1;
				systemChat format ["fn_createPrefabs: warning copy fail, prefab house '%1' rotation values need to be zero to copy", _displayName];
			};
			
		};
	};
} forEach _editorObjects;

if (count _editor_prefab_houses == 0) exitWith {
	systemChat "fn_createPrefabs: there aren't any house/object prefabs defined, put the following '_tags = ""#houseprefab_local"";' in the house object's init to make it a prefab house";
};
if (_rotationErrorCount > 0) exitWith {
	systemChat format ["fn_createPrefabs: failed to copy prefab houses, as '%1' houses have rotation set, rotation needs to be zero x: 0, y: 0, z: 0", _rotationErrorCount];
};	

// clipboard
private _clipboard = "if (!isServer) exitWith {}; private _autoPaste_createPrefabs = true;";
_newline = toString [0x0D, 0x0A];
_clipboard = _clipboard + _newline;

// loop through editor object
{
	private _x_editorObject = _x;
	private _x_pos = getPosATL _x;
	
	// house candidates & selected house
	private _house_candidates = [];
	private _selected_candidate = objNull;
	
	
	// loop through each prefab house and check if object is within the house bounding box
	{
		private _x_prefabHouse = _x;
		
		// check if object is house object
		private _object_insideHouseBoundingBox = [_x_pos, _x_prefabHouse] call extra_fnc_posInsideBoundingBox;
		
		// if object is within house bounding box
		if (_object_insideHouseBoundingBox) then {
			// add prefab house/object as a candidate
			_house_candidates pushBack _x_prefabHouse;
		};
	} forEach _editor_prefab_houses;
	
	if (count _house_candidates == 1) then {
		_selected_candidate =_house_candidates select 0;
	} else {
		// if there is more then one candidate, select the closest house 
		_selected_candidate = [_x_pos, _house_candidates] call extra_fnc_selectObjectByNearest;
	};
	
	if (!isNull _selected_candidate) then {
		// get prefab house index
		private _prefab_house_index = _editor_prefab_houses find _selected_candidate;
		
		
		// get prefab house objects 
		private _prefabObjects = _editor_prefab_houseObjects select _prefab_house_index;
		private _prefabMemoryPoints =_editor_prefab_memoryPoints select _prefab_house_index;
		
		// get object class
		private _x_objectClass = typeOf _x_editorObject;
		
		// if object class is not a helper
		if (!(_x_objectClass in sblib_helper_classes)) then {
			// copy object
			private _copiedObject = [_x_editorObject, _selected_candidate, true, true, true, true] call extra_fnc_copyObject;
			
			// store copied object
			_prefabObjects pushBack _copiedObject;
		} else {
			private _x_objectInit = (_x_editorObject get3DENAttribute "Init") select 0;
			
			private _memoryPointData = call (compile _x_objectInit);
			
			_x_editorObject set3DENAttribute ["presence" , 0];
			_x_editorObject set3DENAttribute ["presenceCondition" , "false"];
			
			_memoryPointData params ["_memoryPointName",["_memory_args", []],"_memoryPointCode",["_memoryPointData", []]];
			
			if (!isNil {_memoryPointName}) then {
				// get relative position & direction
				//private _relativePos2 = [_selected_candidate, _x_editorObject, false] call extra_fnc_relativePos;
				private _relativePos2 = _selected_candidate worldToModel (ASLToAGL getPosASL _x_editorObject); 
				
				private _relativeDirAndUp2 = [_x_editorObject, _selected_candidate] call BIS_fnc_vectorDirAndUpRelative;
				
				/*
				private _relativePos = [_selected_candidate, _x_editorObject, false] call extra_fnc_relativePos;
				private _relativeDirAndUp = [_x_editorObject, _selected_candidate] call BIS_fnc_vectorDirAndUpRelative;
				*/
				if (!isNil {_memoryPointCode}) then {
					_prefabMemoryPoints pushBack [_memoryPointName, [_relativePos2, _relativeDirAndUp2], _memory_args, _memoryPointCode, []];
				} else {	
					_prefabMemoryPoints pushBack [_memoryPointName, [_relativePos2, _relativeDirAndUp2], _memory_args];
				};
			};
			
		};
		
		

	} else {
		// if this object is not within the bounds of the prefab house/object
	};

	
	/*
	// get editor object & position
	private _x_editorObject = _x;
	private _x_pos = getPosATL _x;
	
	// house candidates, if object is inside the boundaries of two houses, then to select the closest house
	private _house_candidates = [];
	private _selected_candidate = objNull;
	
	// loop through each prefab house 
	{
		// check if object is within the boundingBox of this house
		private _x_prefabHouse = _x;
		if (([_x_pos, _x_prefabHouse] call extra_fnc_posInsideBoundingBox)) then {
			_house_candidates pushBack _x_prefabHouse;
		};
	} forEach _editor_prefab_houses;
	
	// if there is only one candidate 
	if (count _house_candidates == 1) then {
		// select candidate
		_selected_candidate =_house_candidates select 0;
	} else {
		// select the closest candidate
		_selected_candidate = [_x_pos, _house_candidates] call extra_fnc_selectObjectByNearest;
	};
	
	// if this object is within the bounding box of a prefab house(_selectedCandidate)
	if (!isNull _selectedCandidate) then {
		// get prefab house index
		private _prefab_house_index = _editor_prefab_houses find _selected_candidate;
		
		// get prefab house objects 
		private _prefabObjects = _editor_prefab_houseObjects select _prefab_house_index;
		
		// copy object 
		systemChat format ["object '%1' in prefab house", typeOf _x];
		//_prefabObjects pushBack 
		
	};*/
} forEach _editorObjects;


// loop through each editor prefab house
{
	// get editor house & house index
	private _x_editor_prefabHouse = _x;
	private _x_houseIndex = _forEachIndex;
	
	// get editor house class 
	private _x_houseClass = typeOf _x_editor_prefabHouse;
	
	// get house objects 
	private _x_houseObjects =_editor_prefab_houseObjects select _x_houseIndex;
	
	// get house memory points 
	private _x_houseMemoryPoints =_editor_prefab_memoryPoints select _x_houseIndex;
	
	// get house data 
	private _x_houseData = _editor_prefab_houseDatas select _x_houseIndex;
	_x_houseData params ["_x_prefabName"];
	

	
	// get house display name
	_x_house_displayName = getText (configFile >> "CfgVehicles" >> _x_houseClass >> "displayname");
	
	
	// clipboard 
	_clipboard = _clipboard + _newline;
	_clipboard = _clipboard + format ["// house '%1': prefab '%2' (%3)", _x_house_displayName, _x_prefabName, (_x_houseIndex + 1)];
	_clipboard = _clipboard + _newline;
	_clipboard = _clipboard + _newline;
	_clipboard = _clipboard + 
	(
		"[""" + _x_houseClass + """, """ + _x_prefabName + """," + str(_x_houseObjects) + ", " + str(_x_houseMemoryPoints) + "] call houseprefabs_fnc_definePrefab;"
	);
	
	_clipboard = _clipboard + _newline;
	_clipboard = _clipboard + _newline;
	_clipboard = _clipboard + "// -------------------------------------------------------";
	_clipboard = _clipboard + _newline;
} forEach _editor_prefab_houses;

copyToClipboard _clipboard;

systemChat format ["%1 prefab houses/objects copied", count _editor_prefab_houses];