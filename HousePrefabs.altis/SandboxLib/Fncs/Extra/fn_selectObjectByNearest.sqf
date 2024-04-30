params ["_pos", "_nearestCandidates"];

_candidateDistances = [];

// loop through each nearest candidates
{
	// get position & add distance to an array
	_candidatePos = getPosATL _x;
	_candidateDistances pushBack (_candidatePos distance _pos);
} forEach _nearestCandidates;


// select the min
_min = selectMin _candidateDistances;

// select the closest candidate
_selectedCandidateIndex = _candidateDistances find _min;

// return candidate
_r = (_nearestCandidates select _selectedCandidateIndex);
_r
