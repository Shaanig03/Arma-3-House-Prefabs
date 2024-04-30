params ["_memoryPointName","_memoryPointCode"];

private _i = sblib_housePrefab_memoryPointKeys find _memoryPointName;

if (_i != -1) exitWith {systemChat format ["memory point '%1' is already defined", _memoryPointName]};


sblib_housePrefab_memoryPointKeys pushBack _memoryPointName;
sblib_housePrefab_memoryPointCodes pushBack _memoryPointCode;
publicVariable "sblib_housePrefab_memoryPointKeys";
publicVariable "sblib_housePrefab_memoryPointCodes";