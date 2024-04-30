params ["_objectc","_cargo",["_clearCargo", true]];


_cargo params 
[
	"_weaponsItems",
	"_mags",
	"_objectc_items",
	"_containers"
];

if (_clearCargo) then {
	clearWeaponCargoGlobal _objectc;
	clearMagazineCargoGlobal _objectc;
	clearItemCargoGlobal _objectc;
	clearBackpackCargoGlobal _objectc;
};

// add weapons
{
	_objectc addWeaponWithAttachmentsCargoGlobal 
	[
		_x,
		1
	];
} forEach _weaponsItems;

// add mags
{
	_x params ["_magClass","_ammoCount"];
	_objectc addMagazineAmmoCargo [_magClass, 1, _ammoCount];
} forEach _mags;


private _item_classes =_objectc_items select 0;
private _item_counts =_objectc_items select 1;

// container types
private _container_types = ["Vest","Uniform","Backpack"];

// add items
{
	private _itemType = [_x] call BIS_fnc_itemType;
	_itemType params ["_item_category","_item_type"];
	
	if (_item_category != "Equipment") then {
		_objectc addItemCargoGlobal [_x, (_item_counts select _forEachIndex)];
	} else {
		if (!(_item_type in _container_types)) then {
			// if item type is not a container
			_objectc addItemCargoGlobal [_x, (_item_counts select _forEachIndex)];
		};
	};
} forEach _item_classes;

// add containers
{
	_x params ["_container_class","_container_cargo"];
	
	private _itemType = [_container_class] call BIS_fnc_itemType;
	_itemType params ["_item_category","_item_type"];
	
	if (_item_type != "Backpack") then {
		_objectc addItemCargoGlobal [_container_class, 1];
	} else {
		_objectc addBackpackCargoGlobal [_container_class, 1];
	};
	
} forEach _containers;

// add container vest, uniform, backpack items
{
	// get container object
	private _container_objectc =_x select 1;
	
	// clear default backpack items
	clearWeaponCargoGlobal _container_objectc;
	clearMagazineCargoGlobal _container_objectc;
	clearItemCargoGlobal _container_objectc;
	clearBackpackCargoGlobal _container_objectc;
	
	if (!isNil {_containers}) then {
		if (count _containers > 0) then {
			// get data
			private _container_info =_containers select _forEachIndex;
			if (!isNil {_container_info}) then {
				_container_info params ["_container_class","_container_cargo"];
				
				// data
				_container_cargo params ["_weaponsItems","_mags","_objectc_items"];
				
				// add weapons stored in backpack
				{
					_container_objectc addWeaponWithAttachmentsCargoGlobal 
					[
						_x,
						1
					];
				} forEach _weaponsItems;
				
				
				// add mags stored in uniform || vest || backpack
				{
					_x params ["_magClass","_ammoCount"];
					_container_objectc addMagazineAmmoCargo [_magClass, 1, _ammoCount];
				} forEach _mags;
				
				// add items stored in uniform || vest || backpack
				_objectc_items params ["_items_classes","_items_counts"];
				{
					_container_objectc addItemCargoGlobal [_x, (_items_counts select _forEachIndex)];
				} forEach _items_classes;
			};
		};
	};
	
} forEach (everyContainer _objectc);
