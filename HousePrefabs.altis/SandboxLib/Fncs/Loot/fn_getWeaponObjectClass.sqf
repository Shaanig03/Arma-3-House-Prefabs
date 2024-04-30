params ["_weaponClass"];

_r = ""; 
_weaponObjectClassFound = false;
_weaponObjectClass = "Item_" + _weaponClass;

						
						// get object class
						// if (weapon object) class was found, set found as true
						if (isClass(configFile >> "CfgVehicles" >> _weaponObjectClass)) then {
							_weaponObjectClassFound = true;
							_r = _weaponObjectClass;
							_r
						} else {
							// if (weapon object) class was found, set found as true
							_weaponObjectClass = "Weapon_" + _weaponClass;
							if (isClass(configFile >> "CfgVehicles" >> _weaponObjectClass)) then {
								_weaponObjectClassFound = true;
								_r = _weaponObjectClass;
								_r
							};
						};
						

_r