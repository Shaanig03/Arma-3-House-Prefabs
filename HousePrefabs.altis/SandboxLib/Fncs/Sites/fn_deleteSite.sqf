params ["_siteName",["_execute_despawnCodes", false]];

// get sites
private _sites = missionNamespace getVariable ["sl_sites", []];

// exit if site doesn't exist
if (!(_siteName in _sites)) exitWith {};

// delete from sites
_sites = _sites - [_siteName];
missionNamespace setVariable ["sl_sites", _sites];

// get all site vars & areas
private _vars = [_siteName, "vars", []] call sites_fnc_getVar;
private _areas = [_siteName, "areas", []] call sites_fnc_getVar;

// loop through each site area & delete it
{
	[_x, _execute_despawnCodes] call sites_fnc_deleteSiteArea;
} forEach _areas;

// loop through each site var & delete it
{
	[_siteName, _x, nil] call sites_fnc_setVar;
} forEach _vars;

// delete vars
missionNamespace setVariable [(format [sblib_site_varName, _siteName, "vars"]), nil];