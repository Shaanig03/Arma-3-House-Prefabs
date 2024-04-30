/* // comment

	sets a variable for the site, the site variable is stored in missionNameSpace in the following variable name "sites_<siteName>_<varName>"
	
	player can use:
	
		missionNameSpace getVariable (format [sblib_site_varName, _siteName, "variableName"]);
		
	to get the value of a site variable, but use:
	
	["site1", "varName", <value_to_return_if_variable_value_doesnt_exist>(optional)] call sites_fnc_getVar;
		
*/

params ["_siteName","_varName","_varValue"];

// get full variable name 'vars'
private _varName_vars = (format [sblib_site_varName, _siteName, "vars"]);

// get vars
private _vars = missionNamespace getVariable [_varName_vars, []];
if (!(_varName in _vars)) then {
	// add variable name to vars
	_vars pushBack _varName;
	missionNamespace setVariable [_varName_vars, _vars];
};

// set var
missionNamespace setVariable [(format [sblib_site_varName, _siteName, _varName]), _varValue];