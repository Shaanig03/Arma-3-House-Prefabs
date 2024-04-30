_className = _this select 0;
_tb = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxbackpacks");
_tm = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxmagazines");
_tw = getNumber (configFile >> "CfgVehicles" >> _className >> "transportmaxweapons");
_return = if (_tb > 0  || _tm > 0 || _tw > 0) then {true;} else {false;};
_return