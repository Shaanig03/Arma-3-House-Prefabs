House Prefabs
----------------------------------

- allows you to creates prefabs for houses and other object classes, then spawn & despawn the prefab or objects & custom loot when the player is nearby/or is away from the house, created for a survival mission that I'm longing to make before heading to Arma 4

- by default there are 115 prefabs(existing furnitures and loots) created for all houses (that is present in Altis, Stratis & Malden)


Features:

	- create custom prefabs and define custom loot positions through 3DEN Editor for a house class or for any object class 

	- spawned/despawning objects are created locally for the player who is near the house saving performance for the server, however loots (ground items) are global but is despawned when there is no player near the house

	- objects are static by default (for performance)
	
	

Creating a prefab:

	- place your prefab house through 3DEN Editor and tag the house as a house prefab by putting the code in the house object's init:
	
	[code]
	_tags = "#houseprefab_local"; ["YourPrefabName"]
	[/code]

	- you can replace 'YourPrefabName' with any name but note that these names have to be unique for the same prefab house, the same type of house cannot have two same prefab names


	Creating Objects & Loot Points:
	
		- you can place your furnitures or objects, and you can place loot spawning points by placing the code in any helper category object:
		
		[code]
		["mem_loot", ["Your_Loot_Table_Name"]]	
		[/code]

	
	- to make your created prefabs appear in game map houses, execute the function in 3DEN Editor by pressing Ctrl+D or going from the top menu to "Tools" then "Debug Console...", paste the below code in debug console and execute it

	[code]
	[] call houseprefabs_fnc_createPrefabs;
	[/code]
	
	- once executed, it should disable all the prefab houses and objects within the house bounding box, preventing them from spawning in game, since we want to only spawn those objects inside existing map houses 
	
	- after execution, you have copied the data into your clipboard now to paste the data 
	
	(script version):
	- open "SandboxLib\Fncs\fn_defined_housePrefabs.sqf", press ctrl+A and delete all the content and paste your new clipboard and save
	
	(mod version):
	create a .sqf file in your mission folder eg: "houseprefabs.sqf" and paste the clipboard to the .sqf file and execute "houseprefabs.sqf" from your "init.sqf" in the mission folder, like below:
	

	
	init.sqf (file):
	
	[code]
	execVM "houseprefabs.sqf";
	[/code]
	
	- and that's it ^_^ , and wait nope I haven't talked about defining custom loots 
	
	
	
Defining Custom Loots:

	- the already existing prefabs have defined loot tables, you can define new loot tables or modify/replace the existing ones
	
	- list of existing loot table variable names:
	
		[code]
		c_loot_house
		c_loot_house_broken
		c_loot_house_food
		c_holder_airport
		c_holder_garage
		c_loot_house_slum
		c_holder_shed
		c_loot_office
		c_loot_shop
		c_loot_construction
		c_loot_industrial
		c_loot_research
		c_loot_military
		c_loot_military_abandoned
		c_loot_military_tower
		c_loot_military_office
		c_loot_medical
		[/code]
		
	- example loot table:
	
	[code]
	your_loot_table_name =
	[ // loot table contains item arrays, these item arrays contains candidate arrays, for an item array a random candidate is selected from the candidates to add an item
		[ // item 1 (array)
			[ // candidate 1 has (item/weapon/loot_table) class names(array of strings), item count(array of numbers), item spawn chance(number 0-1), item magazine count (array of numbers)
				["ItemMap","ItemGPS","c_custom_loot_table"], // item/loot_table class names
				[
					[1], // item count (with spawn chance)
					0.5, // spawn chance from 0 to 1, 1 = 100% spawn chance
					[[0]] // magazine count if item class is a weapon
				]
			],
			[ // candidate 2 has (item/weapon/loot_table) class names(array of strings), item count(array of numbers), item spawn chance(number 0-1), item magazine count (array of numbers)
				["ItemMap","ItemGPS",""], // item/loot_table class names
				[
					[1], // item count (with spawn chance)
					1, // spawn chance from 0 to 1, 1 = 100% spawn chance
					[[0]] // magazine count if item class is a weapon
				]
			]
		],
		[ // item 2 (array)
			[ // candidate 1 has (item/weapon/loot_table) class names(array of strings), item count(array of numbers), item spawn chance(number 0-1), item magazine count (array of numbers)
				["ItemRadio","c_custom_loot_table"], // item/loot_table class names
				[
					[1], // item count (with spawn chance)
					1, // spawn chance from 0 to 1, 1 = 100% spawn chance
					[[0]] // magazine count if item class is a weapon
				]
			]
		]
	];
	[/code]
	
	- you can replace the existing loot tables with your own loot classes, replace the loot table name eg to replace: "c_loot_house", you write in: 
	
	[code]
	c_loot_house = <loot_table_format>
	[/code]
	
	(script version)
	- to modify existing loot tables take a look at "SandboxLib\Fncs\fn_defined_loots.sqf"
	
	(script/mod version)
	- to create new/modify existing loot tables create a .sqf file and define your loot tables in the .sqf file and execute the file using "execVM" command


	- to load/add a loot table to a container:
	
	[code]
		[this, missionNamespace getVariable "your_loot_table_name"] call loot_fnc_addLoot;
	[/code]
	
	or:
	
	[code]
		[this, your_loot_table_name] call loot_fnc_addLoot;
	[/code]
	
	
	- to quickly copy your own classes I included a little script:
	
	[code]
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
	[/code]
	
	- the above script allows you to quickly copy equipment and weapon classes in the Arsenal by pressing Numpad 5  
	
	- note: this script is part of another library I'm working on
