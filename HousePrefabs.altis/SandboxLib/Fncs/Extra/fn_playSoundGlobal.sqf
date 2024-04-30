params ["_object","_soundName",["_maxDistance", 10]];

[[_object, _soundName, _maxDistance], {
	// exit if dedicated or headless client
	if (!hasInterface) exitWith {};
	
	params ["_object","_soundName","_maxDistance"];
	
	// play sound
	_object say3D [_soundName, _maxDistance];
}] remoteExec ["bis_fnc_call", 0];