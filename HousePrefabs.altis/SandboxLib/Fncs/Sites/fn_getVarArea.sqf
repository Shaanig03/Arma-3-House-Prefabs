params ["_siteName","_varName",["_default", nil]];



private _value = nil;

try {
if (!isNil {_default}) then {
	_value = missionNamespace getVariable [(format [sblib_siteArea_varName, _siteName, _varName]), _default]; 
} else {
	_value = missionNamespace getVariable (format [sblib_siteArea_varName, _siteName, _varName]);
};
} catch {};

if (!isNil {_value}) then {
	_value
};
