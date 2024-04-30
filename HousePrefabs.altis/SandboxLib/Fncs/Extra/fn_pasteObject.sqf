/*
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
*/

params 
[
	"_objectData",
	["_isLocal", false],
	["_relativeObjectOrPos", objNull],
	["_relativePosRotation", 0]
];


_objectData params 
[
	"_objectClass",
	"_objectPos",
	"_vectorDirUp",
	"_objectDamage",
	"_objectFuel",
	["_objectInventory", []],
	["_objectCode", ""],
	["_objectVars", []],
	["_objectAmmo", []],
	["_copyType", ""]
];

private _pastedObject = objNull;

// create object
if (!_isLocal) then {
	_pastedObject = _objectClass createVehicle _objectPos;
} else {
	_pastedObject = _objectClass createVehicleLocal _objectPos;
};

// set pos & direction based on copy type
switch(_copyType) do {
	// if copied object didn't have any relative position/object
	case "": { // #tested
		_pastedObject setPosWorld _objectPos;
		_pastedObject setVectorDirAndUp _vectorDirUp;
	};
	// if copied object has a relative object
	case "r": {
		// get relative object or position typeName
		private _typeName_relativeObject = typeName _relativeObjectOrPos;
		// if it's a relative object
		if (_typeName_relativeObject == "OBJECT") then {
			// if object exists
			if (!isNull _relativeObjectOrPos) then {
				
				// get inverted direction
				private _dir_inverted = (getDir _relativeObjectOrPos) * -1;
				
				_pastedObject setVectorDirAndUp ([_vectorDirUp, _dir_inverted, 0, 0] call BIS_fnc_transformVectorDirAndUp);
				_pastedObject setPosATL (_relativeObjectOrPos modelToWorld _objectPos);
				
				
				/* backup 
				// get inverted direction
				private _dir_inverted = (getDir _relativeObjectOrPos) * -1;
				
				// get relative object position
				private _relativeObjectPos = getPosWorld _relativeObjectOrPos;
				
				// get relative object position and add+ the offset position of the pasted object
				private _newObjectPos = (_relativeObjectPos vectorAdd _objectPos);
				
				// rotate position from relative object's center
				_newObjectPos = [_newObjectPos, _relativeObjectPos, _dir_inverted] call extra_fnc_rotatePosFromCenter;
				
				
				_pastedObject setPosWorld _newObjectPos;
				_pastedObject setVectorDirAndUp ([_vectorDirUp, _dir_inverted, 0, 0] call BIS_fnc_transformVectorDirAndUp);
				*/
				/*
					_houseDir_inverted = (getDir _relativeObject) * -1;
					_pastedObjectPos = ((getPosWorld _relativeObject) vectorAdd _relativePos);
					_pastedObjectPos = [_pastedObjectPos, getPosWorld _relativeObject, _houseDir_inverted] call extra_fnc_rotatePosFromCenter;
				*/
			};
		};
	};
	case "rp": {
		// get relative object or position typeName
		private _typeName_relativeObject = typeName _relativeObjectOrPos;
	
		// if it's a position
		if (_typeName_relativeObject == "ARRAY") then {
			
			// get relative object position and add+ the offset position of the pasted object
			private _newObjectPos = (_relativeObjectOrPos vectorAdd _objectPos);
			
			// rotate position from relative object's center
			_newObjectPos = [_newObjectPos, _relativeObjectOrPos, _relativePosRotation] call extra_fnc_rotatePosFromCenter;
			
			/*
			
			*/
			
			
			_pastedObject setPosATL _newObjectPos;
			_pastedObject setVectorDirAndUp ([_vectorDirUp, _relativePosRotation, 0, 0] call BIS_fnc_transformVectorDirAndUp);
		};
	};
	default {};
};
// set object properties 


_pastedObject setDamage _objectDamage;
_pastedObject setFuel _objectFuel;

_pastedObject