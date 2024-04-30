params ["_house",["_global", false]];

if (!_global) then {
	if (_house in sblib_housePrefab_activeHousesLocal) then {
		
		// get house objects
		private _houseObjects = _house getVariable ["hpo", []];
		
		// loop through each house object and despawn it
		{
			if (!isNull _x) then {
				deleteVehicle _x;
			};
		} forEach _houseObjects;
		
		_house setVariable ["hpo", []];
		
		sblib_housePrefab_activeHousesLocal = sblib_housePrefab_activeHousesLocal - [_house];
	};
} else {
	if (_house in sblib_housePrefab_activeHousesGlobal) then {
		
	};
};
