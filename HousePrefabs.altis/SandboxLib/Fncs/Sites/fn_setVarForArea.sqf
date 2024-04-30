params ["_siteName", "_varName", "_varValue"];

private _areas = [_siteName, "areas", []] call sites_fnc_getVar;

{
	[_x, _varName, _varValue] call sites_fnc_setVarArea;
} forEach _areas;