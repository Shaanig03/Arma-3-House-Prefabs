params ["_object","_weaponClass","_magCount"];

_mags = getArray (configFile / "CfgWeapons" / _weaponClass / "magazines");
_magClass = _mags call bis_fnc_selectRandom; 

_object addMagazineCargoGlobal [_magClass, _magCount];