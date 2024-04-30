params ["_areaName", "_activation"]; 

// get area activated / deactivated
private _area_activated = [_areaName, "activated", false] call sites_fnc_getVarArea;

// if area is already activated or deactivated, exit
if (_activation == _area_activated) exitWith {};

// to store all spawn/despawn script handles
private _script_handles = [];

// loop through each activation/deactivation script
{
	// execute spawn/despawn script
	private _script_handle = [_areaName, _activation] spawn _x;
	_script_handles pushBack _script_handle;
} forEach sblib_siteArea_scripts;


// store script handles
[_areaName, "script_handles", _script_handles] call sites_fnc_setVarArea;

// set activated/deactivated
[_areaName, "activated", _activation] call sites_fnc_setVarArea;

// set activating/deactivating to nil when site is successfully activated or deactivated
[_areaName, "activating", nil] call sites_fnc_setVarArea;

//#temp
if (_activation) then {
	private _debugMarker = [_areaName, "debugMarker"] call sites_fnc_getVarArea;
	_debugMarker setMarkerColor "ColorGreen";
} else {
	private _debugMarker = [_areaName, "debugMarker"] call sites_fnc_getVarArea;
	_debugMarker setMarkerColor "ColorBlack";
};