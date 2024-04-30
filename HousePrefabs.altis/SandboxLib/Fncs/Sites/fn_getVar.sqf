params ["_siteName","_varName",["_default", nil]];

private _value = nil;

if (!isNil {_default}) then {
	_value = missionNamespace getVariable [(format [sblib_site_varName, _siteName, _varName]), _default];
} else {
	_value = missionNamespace getVariable (format [sblib_site_varName, _siteName, _varName]);
};

_value