params [["_markerType", ""], "_markerPos", ["_text_or_radius", ""], ["_attachObject", objNull]];


// generate an id for debug marker
if (isNil "debugMarkerID") then {
	debugMarkerID = 0;
};
debugMarkerID = debugMarkerID + 1;

// debug marker name
private _debugMarkerName = format ["debugMarker%1", debugMarkerID];

switch (_markerType) do {
	case "ellipse": {
		_debugMarkerName = createMarker [_debugMarkerName, _markerPos];
		_debugMarkerName setMarkerShape "ELLIPSE";
		_debugMarkerName setMarkerAlpha 0.5;
		_debugMarkerName setMarkerSize [_text_or_radius, _text_or_radius];
	};
	default 
	{
		_debugMarkerName = createMarker [_debugMarkerName, _markerPos];
		_debugMarkerName setMarkerType "mil_dot";
		
	};
};

if (typeName _text_or_radius == "STRING") then {
	_debugMarkerName setMarkerText _text_or_radius;
};



if (!isNull _attachObject) then {
	[_debugMarkerName, _attachObject] spawn {
		params ["_markerName","_attachObject"];
		
		while {!isNull _attachObject} do {
			_markerName setMarkerPos (getPos _attachObject);
			sleep 0.05;
		};
		
		deleteMarker _markerName;
	};
};
_debugMarkerName