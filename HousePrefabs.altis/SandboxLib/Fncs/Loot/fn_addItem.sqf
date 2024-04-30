params ["_object","_class","_count"];

_itemType = [_class] call BIS_fnc_itemType;
_itemType params ["_category","_type"];

if (_category == "Weapon") exitWith {
	_object addWeaponCargoGlobal [_class, _count];
	_category
};

if (_category == "Item") exitWith {
	_object addItemCargoGlobal [_class, _count];
	_category
};

if (_category == "Equipment") exitWith {
	if (_type != "Backpack") then {
		_object addItemCargoGlobal [_class, _count];
	} else {
		_object addBackpackCargoGlobal [_class, _count];
	};
	_category
};
if (_category == "Magazine" || _category == "Mine") exitWith {
	_object addMagazineCargoGlobal [_class, _count];
	_category
};

_category