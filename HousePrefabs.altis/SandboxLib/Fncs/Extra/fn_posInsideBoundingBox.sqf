params ["_pos","_target"];

_pos = _target worldToModel _pos;
		
// Get the bounding box 	
_boundingBox = boundingBoxReal _target;
	 
// Split the bounding box into two corners 
_corner1 = _boundingBox select 0; 
_corner2 = _boundingBox select 1; 
		
		
_min = _corner1;
_max = _corner2;
		
		
		_r = (
			(_pos select 0) >= (_min select 0) && 
			(_pos select 0) <= (_max select 0) &&
			(_pos select 1) >= (_min select 1) &&
			(_pos select 1) <= (_max select 1) &&
			(_pos select 2) >= (_min select 2) &&
			(_pos select 2) <= (_max select 2)); _r
		