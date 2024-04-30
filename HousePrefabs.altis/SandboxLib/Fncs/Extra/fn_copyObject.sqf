/*
params ["_object",["_copyInventory", true],["_copyAmmo", true],["_isEditor", false],["_disableEditorObject", false]];


params ["_object","_relativeObject",["_copyInventory", true],["_copyAmmo", true],["_isEditor", false],["_disableEditorObject", false]];


params ["_object","_centerPos",["_copyInventory", true],["_copyAmmo", true],["_isEditor", false],["_disableEditorObject", false]];

*/

params 
[
	"_object", // object to copy (3DEN editor or ingame)
	["_relativeObjectOrPos", objNull], // relative object  to get relative position (eg: house)
	["_copyInventory", true], // copies object's inventory (if object has an inventory)
	["_copyAmmo", true], // copy object(eg: turret)/vehicle ammo?
	["_isEditor", false], // is object a 3DEN editor object?
	["_disable_editorObject", false] // if true disables the 3DEN editor object from being active in the game 
]; 


private _saving_vars = [];
// if copying object is in game not editor
if (!_isEditor) then {

	// get saving variable names 
	private _svar_names = _object getVariable ["svars", []]; // variable names to save for this object
	{
		private _value = _object getVariable _x;
		if (!isNil {_value}) then {
			_saving_vars pushBack [_x, _value];
		};
	} forEach _svar_names;
};

// get object class
private _objectClass = typeOf _object;

// get object inventory
private _objectInventory = [];
if (_copyInventory) then {
	// check if this object class has any inventory space 
	if ([_objectClass] call extra_fnc_hasInv) then {
		// get object inventory
		_objectInventory = [_object] call extra_fnc_copyInventory;
	};
};

// get object/vehicle ammo
private _vehAmmo = [];
if (_copyAmmo) then {
	// if this object has turrets 
	_turrets = allTurrets _object;
	
	// get all turret mags
	if (count _turrets > 0) then {
		_vehAmmo = magazinesAllTurrets _object;
	};
};

// get object code
private _objectCode = _object getVariable ["code", ""];

// if copying object is a editor object
if (_isEditor) then {
	// get init
	_objectCode = (_object get3DENAttribute "Init") select 0;
	
	// disable editor object 
	if (_disable_editorObject) then {
		// disable object from editor
		_object set3DENAttribute ["presence" , 0];
		_object set3DENAttribute ["presenceCondition" , "false"];
	};
};

// get object position & vector dir & up
private _objectPos = getPosWorld _object;
private _object_dirAndUp = [vectorDir _object, vectorUp _object];
private _copyType = "";

if (typeName _relativeObjectOrPos == "OBJECT") then {
	if (!isNull _relativeObjectOrPos) then {
		// get relative position & direction
		//_objectPos = [_relativeObjectOrPos, _object, true] call extra_fnc_relativePos;
		_objectPos = _relativeObjectOrPos worldToModel (ASLToAGL getPosASL _object);
		
		_object_dirAndUp = [_object, _relativeObjectOrPos] call BIS_fnc_vectorDirAndUpRelative;
		_copyType = "r"; // relative to an object
	};
} else 
{
	if (typeName _relativeObjectOrPos == "ARRAY") then {
		_objectPos = [_relativeObjectOrPos, getPosATL _object, true] call extra_fnc_relativePos;
		//_relativePos = [_centerPos, getPosATL _object, true] call extra_fnc_relativePos;
		_copyType = "rp"; // relative to a position
	};
};

// get object data
private _objectData =
[
	_objectClass,
	_objectPos,
	_object_dirAndUp,
	damage _object,
	fuel _object,
	_objectInventory,
	_objectCode,
	_saving_vars,
	_vehAmmo,
	_copyType
];

_objectData