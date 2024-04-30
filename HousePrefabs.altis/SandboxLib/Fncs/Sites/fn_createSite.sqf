// exit if not server
if (!isServer) exitWith {};

params ["_siteName", "_areaInfo", ["_areas",[]]];



// get existing sites
private _sites = missionNamespace getVariable ["sl_sites", []];


// if provided siteName is empty
// then generate a name
if (_siteName == "") then {
	if (isNil "siteCount") then {
		siteCount = 0;
	};
	siteCount = siteCount + 1;
	_siteName = format ["site%1", siteCount];
};


// exit if site name is already taken
if (_siteName in _sites) exitWith {};

_sites pushBack _siteName;
missionNamespace setVariable ["sl_sites", _sites];

// get site areas
private _site_areas = [_siteName, "areas", []] call sites_fnc_getVar;

// add areas to site areas
{
	if (!(_x in _site_areas)) then {
		_site_areas pushBack _x;
	};
} forEach _areas;
[_siteName, "areas", _areas] call sites_fnc_setVar;


// if default area position & radius is provided
if (!isNil {_areaInfo}) then {
	_areaInfo params ["_areaPos","_areaRadius",["_area_autoLoad", true]];
	
	// create default area
	private _areaName = format ["%1_area", _siteName];
	[_areaName, _areaPos, _areaRadius, _siteName, _area_autoLoad] call sites_fnc_createSiteArea;
};



_siteName