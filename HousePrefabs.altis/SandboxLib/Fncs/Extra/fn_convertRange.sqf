private _originalStart =_this select 0;
private _originalEnd =_this select 1;
private _newStart =_this select 2;
private _newEnd =_this select 3;
private _value =_this select 4;

private _scale = (_newEnd - _newStart) / (_originalEnd - _originalStart);

private _r = (_newStart + ((_value - _originalStart) * _scale));
_r

