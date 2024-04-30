params ["_areaName",["_execute_despawnCodes", false]];

// get existing areas
private _areas = missionNamespace getVariable ["sl_areas", []];

// exit if area doesn't exist
if (!(_areaName in _areas)) exitWith {};

// delete area from areas
_areas = _areas - [_areaName];
missionNamespace setVariable ["sl_areas", _areas];


// destroy site activator (handle)
private _activator_handle = [_areaName, "activator_handle", scriptNull] call sites_fnc_getVarArea;
terminate _activator_handle;


if (_execute_despawnCodes) then {
	// call despawn codes
	[_areaName, false] call sites_fnc_areaActivation;
	
	
	// delete area variables after despawn codes finish executing
	[_areaName] spawn {
		params ["_areaName"];
		
		// wait until despawn scripts are finished
		waitUntil {
			sleep 1;
			
			private _scripts_finished = true;
		
			// get area scripts
			private _scripts = [_areaName, "script_handles", []] call sites_fnc_getVarArea;
			
			// loop through area script
			{
				// if area script is not finished executing
				if (!scriptDone _x) exitWith {
					// set scripts finished to false
					_scripts_finished = false;
				};
			} forEach _scripts;
			
			_scripts_finished
		};
		
		// get all site vars & areas
		private _vars = [_areaName, "vars", []] call sites_fnc_getVarArea;
		
		// loop through each area var & delete it
		{
			[_areaName, _x, nil] call sites_fnc_setVarArea;
		} forEach _vars;
	
		// delete vars
		missionNamespace setVariable [(format [sblib_siteArea_varName, _areaName, "vars"]), nil];
	};
} else {
	// get all site vars & areas
	private _vars = [_areaName, "vars", []] call sites_fnc_getVarArea;
	
	// loop through each area var & delete it
	{
		[_areaName, _x, nil] call sites_fnc_setVarArea;
	} forEach _vars;
	
	// delete vars
	missionNamespace setVariable [(format [sblib_siteArea_varName, _areaName, "vars"]), nil];
};


