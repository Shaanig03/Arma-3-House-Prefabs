params ["_objectA","_objectB",["_posWorld", false]];

private _pos1 = [0,0,0];
private _pos2 = [0,0,0];

if (typeName _objectA == "OBJECT") then {
	if (_posWorld) then {
		_pos1 = getPosWorld _objectA;
		_pos2 = getPosWorld _objectB;
	} else {
		_pos1 = getPosATL _objectA;
		_pos2 = getPosATL _objectB;
	};
} else {
	_pos1 = _objectA;
	_pos2 = _objectB;
};

private _relativeOffset = [0,0,0];
_relativeOffset set [0, (_pos2 select 0) - (_pos1 select 0)];
_relativeOffset set [1, (_pos2 select 1) - (_pos1 select 1)];
_relativeOffset set [2, (_pos2 select 2) - (_pos1 select 2)];

_relativeOffset