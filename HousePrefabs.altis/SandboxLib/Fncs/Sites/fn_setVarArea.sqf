params ["_areaName","_varName","_varValue"];

// get full variable name 'vars'
private _varName_vars = (format [sblib_siteArea_varName, _areaName, "vars"]);

// get vars
private _vars = missionNamespace getVariable [_varName_vars, []];
if (!(_varName in _vars)) then {
	// add variable name to vars
	_vars pushBack _varName;
	missionNamespace setVariable [_varName_vars, _vars];
};

if (!isNil {_varValue}) then {
	// set var
	missionNamespace setVariable [(format [sblib_siteArea_varName, _areaName, _varName]), _varValue];
} else {
	// set var
	missionNamespace setVariable [(format [sblib_siteArea_varName, _areaName, _varName]), nil];
};
