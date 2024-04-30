params ["_posList","_targetPos"];

// to store distances
_originalDistances = [];
_distances = [];

// loop through each position
{
	// get distance to target position
	_dis = (_x distance _targetPos);
	
	// store distance in an array
	_originalDistances pushBack _dis;
	_distances pushBack _dis;
	
} forEach _posList;

// sort distances
_distances sort true;

// to store sorted positions
_sortedPositions = [];

// loop through each distance
{
	// get distance
	_x_distance = _x;
	
	// get distance's original index
	_sortedPosIndex = _originalDistances find _x_distance;
	
	_sortedPos =_posList select _sortedPosIndex;
	
	_sortedPositions pushBack _sortedPos;
} forEach _distances;

_sortedPositions