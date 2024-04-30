params ["_houseObject",["_global", false]];

if (!_global) then {
	// get house objects
	private _objects = _houseObject getVariable ["hpo", _spawnedObjects];
	
	// despawn local house objects
	{
		if (!isNull _x) then {
			deleteVehicle _x;
		};
	} forEach _objects;
	
	// get local player & player uid
	private _player = player;
	private _uid = getPlayerUID _player;
	
	// get active uids
	private _active_uids = _houseObject getVariable ["hp_uids", []];
	
	// if uid is in active uids
	if ((_uid in _active_uids)) then {
		// remove uid
		_active_uids = _active_uids - [_uid];
		_houseObject setVariable ["hp_uids", _active_uids, true];
	};
} else {
	// get prefab objects & memory points
	_prefabData params ["_prefabObjects","_prefabMemoryPoints"];
	
};