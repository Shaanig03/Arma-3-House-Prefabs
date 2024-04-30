params ["_object","_loot_table",["_clearCargo", false]];

if (isNil {_loot_table}) exitWith {};

/*
if (isNil {_loot_table}) exitWith {
	hintC format ["Loot table is nil: %1", _loot_table];
};

*/


if (_clearCargo) then {
	clearWeaponCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	clearItemCargoGlobal _object;
	clearBackpackCargoGlobal _object;
};

/*
	_example_loot_table = 
	[
		[ // item
			[ // candidate item
				["ItemMap","ItemRadio","ItemGPS","ItemWatch"],
				[[1,3],0,[5]]
			]
		],
		[ // item
			[ // candidate item
				["rhs_weap_ak103"],
				[[1,3],0,[5]] // <itemCount>, <requiredRandomNumber / spawnChance>, <magazineCount>
			]
		]
	];
*/

// loop through each item in _loot_table
{
	// select a random candidate item (from item)
	_candidateItem = selectRandom _x;
	
	// candidate item variables
	_candidateItem params ["_classArray","_lootInfo"];
	_lootInfo params ["_spawnCount","_spawnChance","_magazineCount",["_classWeights", []]];
	

	private _real_spawnChance = [0,1,1,0, _spawnChance] call extra_fnc_convertRange;
	// if random generated number is >= to spawn chance
	if (random(1) >= _real_spawnChance) then {
		
		// spawn count
		_spawnCount = selectRandom _spawnCount;
		
		
		for "_i" from 1 to _spawnCount do {
			_class = "";
			
			// select class
			if (count _classWeights == 0) then {
				_class = selectRandom _classArray;
			} else {
				_class = _classArray selectRandomWeighted _classWeights;
			};
		
			// get loot table
			private _lootTable = missionNamespace getVariable _class;
			
			if (isNil {_lootTable}) then {
				// if loot table doesn't exist
				
				// add item
				_itemCategory = [_object, _class, 1] call loot_fnc_addItem;
				
				// if adding item is an weapon
				if (_itemCategory == "Weapon") then {
					// add magazine
					_magCount = selectRandom _magazineCount;
					if (_magCount > 0) then { [_object, _class, _magCount] call loot_fnc_addWeaponMag; };
				
				};
				
			} else {
				// if loot table isn't a string
				if (typeName _lootTable != "STRING") then {
					// if loot table exists
					[_object, _lootTable] call loot_fnc_addLoot;
				} else {
					// if it's a string then add item
					// add item
					_itemCategory = [_object, _lootTable, 1] call loot_fnc_addItem;
					
					// if adding item is an weapon
					if (_itemCategory == "Weapon") then {
						// add magazine
						_magCount = selectRandom _magazineCount;
						if (_magCount > 0) then { [_object, _lootTable, _magCount] call loot_fnc_addWeaponMag; };
					
					};
					
				};
				
			};
		};
		
		
	};
	
	
	

	// if class provided is a loot table 
	
	
} forEach _loot_table;