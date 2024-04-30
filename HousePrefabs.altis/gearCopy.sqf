[] spawn {
	if (!isNil "gearCopyMode") exitWith {};
	
	hint parseText "gear copy - enabled<br/>------------------------------------<br/><br/>choose an item type to copy then open arsenal and press Numpad 5 to copy your wearing item";
	gearClasses = [];
	gearType = "uniform";
	gearCopyMode = true;
	
	waitUntil { !isNull (findDisplay 46) };
	
	player addAction ["Open Arsenal",{
		["Open", true] spawn BIS_fnc_Arsenal;
	}];
	systemChat "gear copy mode: enabled, use Numpad 5 to copy class";
	systemChat format ["copy gear classes type is now %1", gearType];
		
	player addAction ["Gear Copy",{
		copyToClipboard str(gearClasses);
		systemChat format ["%1 classes copied", count gearClasses];
	}];
	
	player addAction ["Gear: Headgear",{
		gearType = "headgear";
		systemChat "copy gear classes type is now headgear";
	}];
	
	player addAction ["Gear: Uniform",{
		gearType = "uniform";
		systemChat "copy gear classes type is now uniform";
	}];
	
	player addAction ["Gear: Primary Weapon",{
		gearType = "primaryWeapon";
		systemChat "copy gear classes type is now primary weapon";
	}];
	
	player addAction ["Gear: Secondary Weapon",{
		gearType = "secondaryWeapon";
		systemChat "copy gear classes type is now secondary weapon";
	}];
	player addAction ["Gear: Handugn",{
		gearType = "handgun";
		systemChat "copy gear classes type is now handgun";
	}];
	player addAction ["Gear: Vest",{
		gearType = "vest";
		systemChat "copy gear classes type is now vest";
	}];
	player addAction ["Gear: Backpack",{
		gearType = "backpack";
		systemChat "copy gear classes type is now backpack";
	}];
	
	player addAction ["Gear: Goggles",{
		gearType = "goggles";
		systemChat "copy gear classes type is now goggles";
	}];
	
	player addAction ["Gear: Clear All Copied Classes",{
		gearClasses = [];
		systemChat "copy gear classes - cleared";
	}];
	
	
	
	
	
		systemChat "gear copy enabled";
	
	_arsenalDisplay = nil;
	_displayList = allDisplays;
	while {alive player} do {
		_currentDisplays = allDisplays;
		
		{
			if (!(_x in _displayList)) then {
				_displayList pushBack _x;
				_arsenalDisplay = _x;
				
				_arsenalDisplay displayAddEventHandler ["KeyDown", {
					_display =_this select 0;
					_key =_this select 1;
					


					// numpad 5
					if (_key == 76) then {
						// get gear type
						_gearType = gearType;
						
						// get gear class
						_class = "";
						if (_gearType == "uniform") then {
							_class = uniform player;
						};
						if (_gearType == "primaryWeapon") then {
							_class = primaryWeapon player;
						};
						if (_gearType == "secondaryWeapon") then {
							_class = secondaryWeapon player;
						};
						if (_gearType == "vest") then {
							_class = vest player;
						};
						if (_gearType == "backpack") then {
							_class = backpack player;
						};
						if (_gearType == "goggles") then {
							_class = goggles player;
						};
						if (_gearType == "headgear") then {
							_class = headgear player;
						};
						if (_gearType == "handgun") then {
							_class = handgunWeapon player;
						};
						if (_class != "" && !(_class in gearClasses)) then {
							gearClasses pushBack _class;
							systemChat format ["'%1' class added to copy list, copied class count: %2", _class, count gearClasses];
						};
					};
				}];
					
				
			};
		} forEach _currentDisplays;
		sleep 1;
	};

	
	
};