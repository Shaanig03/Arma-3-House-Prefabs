params ["_areaName"];

// wait until area finishes loading
waitUntil {([_areaName, "loaded", false] call sites_fnc_getVarArea)};

// get area position & radius
private _areaPos = [_areaName, "pos"] call sites_fnc_getVarArea;
private _areaRadius = [_areaName, "radius"] call sites_fnc_getVarArea;

systemChat "#t site area loaded";
while {true} do {



	/* // comment
		main script that activates or deactivates a site by checking conditions
	*/
	// activation condition
	private _activation_condition = [_areaName, _areaPos, _areaRadius] call sblib_siteArea_activationCondition;
	
	// site area activated?
	private _activated = [_areaName, "activated", false] call sites_fnc_getVarArea;
	
	// site area activation / deactivation script
	if (_activation_condition != _activated) then {
		// set as activating or deactivating
		[_areaName, "activating", _activation_condition] call sites_fnc_setVarArea;
		
		
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
		
		// if scripts are finished executing
		if (_scripts_finished) then {
			[_areaName, _activation_condition] call sites_fnc_areaActivation;
		};
		
	};
	
	/*	// comment
	
		if the player quickly enters and leaves an area, if a player leaves an area then 'activating' is set to false (which is deactivating), when false the spawning scripts would stop the spawning process of units or objects, but if the player quicky and leaves and enters and if the objects or units stops spawning but the site is already activated because the player quickly left and entered the area, and the units and objects didn't spawn because player quickly left and entered then do a restart by despawning the current objects and spawning them again 
	*/
	// if site is in the process of (spawning/despawning) activating or deactivating
	private _activating = [_areaName, "activating"] call sites_fnc_getVarArea;
	if (!isNil {_activating}) then {
	
		// if area is activated but site is set to deactivating
		if (_activated && !_activating) then {
		
			// get script handles
			private _script_handles = [_areaName, "script_handles", []] call sites_fnc_getVarArea;
			
			// loop through each script handles to check if it's finished
			private _all_scripts_finished = true;
			{
				// if script handle isn't finished executing
				if (!scriptDone _x) exitWith {
					_all_scripts_finished = false;
				};
			} forEach _script_handles;
			
			// if all scripts are finished
			if (_all_scripts_finished) then {
				[_areaName, false] call sites_fnc_areaActivation;
			};
		};
	};
	
	sleep sblib_site_activationConditionDelay;
};