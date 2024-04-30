params ["_point", "_center", "_angle"];

// get center x,y,z & point x,y,z
_center params ["_centerX","_centerY","_centerZ"];
_point params ["_pointX", "_pointY", "_pointZ"];

private _newX = _centerX + (_pointX-_centerX) * cos(_angle) - (_pointY-_centerY) * sin(_angle);
private _newY = _centerY + (_pointX-_centerX) * sin(_angle) + (_pointY-_centerY) * cos(_angle);

private _return = [_newX, _newY, _pointZ];
_return

/*

_xValue = 270;

// get center
_center = getPos circle; 
_center params ["_centerX","_centerY","_centerZ"];

// get point
_point = circle modelToWorld [0,15,0];
_point params ["_pointX", "_pointY", "_pointZ"];


//newX = centerX + (point2x-centerX)*Math.cos(x) - (point2y-centerY)*Math.sin(x);
//newY = centerY + (point2x-centerX)*Math.sin(x) + (point2y-centerY)*Math.cos(x);

_newX = _centerX + (_pointX-_centerX) * cos(_xValue) - (_pointY-_centerY) * sin(_xValue);
_newY = _centerY + (_pointX-_centerX) * sin(_xValue) + (_pointY-_centerY) * cos(_xValue);


_new = [_newX, _newY, 0];
player setPos [_newX, _newY, _centerZ];*/