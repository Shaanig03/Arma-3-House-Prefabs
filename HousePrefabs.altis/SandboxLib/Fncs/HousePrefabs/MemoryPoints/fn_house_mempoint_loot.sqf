params ["_memoryPointName","_spawned","_memoryPosDir","_memoryArgs",["_data", []],"_memoryPointIndex","_house"];



if (!_spawned) exitWith {
	// get created  memory point 
	private _created_memoryPoints = _house getVariable ["hp_mp", []];
	private _created_memoryPoint =_created_memoryPoints select _memoryPointIndex;
	
	// get memory point data
	private _memoryPointData =_created_memoryPoint select 2;
	
	// save loot (before despawning)
	
	// despawn weapon holder
	_memoryPointData params [["_wpnholder", objNull]];
	
	
	if (!isNull _wpnholder) then {
		// get weapon holder inventory 
		private _wpnholder_inventory = [_wpnholder] call extra_fnc_copyInventory;
		
		// delete weapon holder
		deleteVehicle _wpnholder;
		
		// update weapon holder inventory
		_memoryPointData = [objNull, _wpnholder_inventory];
		
		_created_memoryPoint set [2, _memoryPointData];
		_created_memoryPoints set [_memoryPointIndex, _created_memoryPoint];
		
		
	} else {
		// update weapon holder inventory
		_memoryPointData = [objNull, true]; // set loot as taken to true
		
		_created_memoryPoint set [2, _memoryPointData];
		_created_memoryPoints set [_memoryPointIndex, _created_memoryPoint];
	};
	
	_house setVariable ["hp_mp", _created_memoryPoints];
};

// <continue> - storing inventory loot in data

// get memory pos & direction
_memoryPosDir params ["_pos","_dir"];

// create loot
private _wpnholder = "GroundWeaponHolder" createVehicle [0,0,0];

_wpnholder setPosATL _pos;
_wpnholder setVectorDirAndUp _dir;

private _addLoot = true;


if (count _data	> 0) then {
	// [0_memoryPointName, 1[_newObjectPos, _vectorDirAndUp], 2_memoryPointData]
	
	// get memory point data
	private _memoryPointData =_data select 2;
	
	// if memory point data exists
	if (!isNil {_memoryPointData}) then {
		private _savedLoot =_memoryPointData select 1;
		
		// if saved loot exists
		if (!isNil {_savedLoot}) then {
			// if it's not a bool
			if (typeName _savedLoot != "BOOL") then {
				
				[_wpnholder, _savedLoot, false] call extra_fnc_pasteInventory; 
				_addLoot = false;
			} else {
				// if it's a bool then it's loot taken
				_addLoot = false;
			};
		};
	};	
};

if (_addLoot) then {
	[_wpnholder, missionNameSpace getVariable (selectRandom _memoryArgs), false] call loot_fnc_addLoot;
};

// get created  memory point 
private _created_memoryPoints = _house getVariable ["hp_mp", []];
private _created_memoryPoint =_created_memoryPoints select _memoryPointIndex; //[0 _memoryPointName, 1 [_newObjectPos, _vectorDirAndUp], 2 _memoryPointData];

// update created memory point data
_created_memoryPoint set [2, [_wpnholder]];

// update created memory point
_created_memoryPoints set [_memoryPointIndex, _created_memoryPoint];

_house setVariable ["hp_mp", _created_memoryPoints];



