
// exit if not server
if (!isServer) exitWith {};

params ["_areaName","_areaPos","_areaRadius",["_siteAssigned", ""],["_autoLoad", true]];


// get existing areas
private _areas = missionNamespace getVariable ["sl_areas", []];

// exit if area name is already taken
if (_areaName in _areas) exitWith {};


// set area vars 
[_areaName, "pos", _areaPos] call sites_fnc_setVarArea;
[_areaName, "radius", _areaRadius] call sites_fnc_setVarArea;



// if site is assigned 
if (_siteAssigned != "") then 
{
	// get site areas
	private _areas = [_siteAssigned, "areas", []] call sites_fnc_getVar;
	_areas pushBack _areaName;
	[_siteAssigned, "areas", _areas] call sites_fnc_setVar;
};

  




// add area to site areas
_areas pushBack _areaName;
missionNamespace setVariable ["sl_areas", _areas];

// set loaded as true if (_autoLoad is set to true)
if (_autoLoad) then {
	[_areaName, "loaded", true] call sites_fnc_setVarArea;
};

// spawn site area activator
private _activator_scriptHandle = [_areaName] spawn sites_fnc_areaActivator;
[_areaName, "activator_handle", _activator_scriptHandle] call sites_fnc_setVarArea;

// #temp
if (sblib_debugging) then {
	private _debugMarker = ["ellipse", _areaPos, _areaRadius] call extra_fnc_debugMarker;
	[_areaName, "debugMarker", _debugMarker] call sites_fnc_setVarArea;
};
//params [["_markerType", ""], "_markerPos", ["_text_or_radius", ""], ["_attachObject", objNull]];