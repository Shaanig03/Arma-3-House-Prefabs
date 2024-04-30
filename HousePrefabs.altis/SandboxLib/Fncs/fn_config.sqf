// exit if not server
if (!isServer) exitWith {};


sblib_debugging = true;

// house prefabs
sblib_housePrefab_enabled = true;
publicVariable "sblib_housePrefab_enabled";

// house prefabs
sblib_housePrefab_classes = ["House","CampEast_EP1","Land_tent_east"]; 
publicVariable "sblib_housePrefab_classes";

sblib_housePrefab_spawnRadius = 30;
publicVariable "sblib_housePrefab_spawnRadius";

sblib_housePrefab_sleepDelay = 1;
publicVariable "sblib_housePrefab_sleepDelay";

sblib_housePrefab_attachObjects = true;
publicVariable "sblib_housePrefab_attachObjects";

sblib_housePrefab_enableSimulation = false;
publicVariable "sblib_housePrefab_enableSimulation";

sblib_housePrefab_houseClasses = [];
sblib_housePrefab_prefabNames = [];
publicVariable "sblib_housePrefab_houseClasses";
publicVariable "sblib_housePrefab_prefabNames";

sblib_housePrefab_activeHousesGlobal = [];
publicVariable "sblib_housePrefab_activeHousesGlobal";
sblib_housePrefab_activeHousesGlobalProcessing = [];
publicVariable "sblib_housePrefab_activeHousesGlobalProcessing";

sblib_housePrefab_memoryPointKeys = [];
publicVariable "sblib_housePrefab_memoryPointKeys";
sblib_housePrefab_memoryPointCodes = [];
publicVariable "sblib_housePrefab_memoryPointCodes";

sblib_housePrefab_excludingClasses =
[
	"Land_Garbage_square3_F",
	"Land_Garbage_line_F",
	"Land_GarbageHeap_03_F"
];





publicVariable "sblib_housePrefab_excludingClasses";

		//[_memoryPointName, _memoryPosDir, _memoryArgs, _memoryPointData] 
// house memory points
["mem_loot",{[_this select 0, _this select 1, _this select 2, _this select 3, _this select 4, _this select 5, _this select 6] call houseprefabs_fnc_house_mempoint_loot}] call houseprefabs_fnc_defineMemoryPoint;

//[_memoryPointName, _memoryArgs, _memoryPointData] 

// (all) helper classes 
sblib_helper_classes = ["Helper_Base_F","Sign_Arrow_F","Sign_Arrow_Green_F","Sign_Arrow_Blue_F","Sign_Arrow_Pink_F","Sign_Arrow_Yellow_F","Sign_Arrow_Cyan_F","Sign_Arrow_Large_F","Sign_Arrow_Large_Green_F","Sign_Arrow_Large_Blue_F","Sign_Arrow_Large_Pink_F","Sign_Arrow_Large_Yellow_F","Sign_Arrow_Large_Cyan_F","Sign_Arrow_Direction_F","Sign_Arrow_Direction_Green_F","Sign_Arrow_Direction_Blue_F","Sign_Arrow_Direction_Pink_F","Sign_Arrow_Direction_Yellow_F","Sign_Arrow_Direction_Cyan_F","Sign_Pointer_F","Sign_Pointer_Green_F","Sign_Pointer_Blue_F","Sign_Pointer_Pink_F","Sign_Pointer_Yellow_F","Sign_Pointer_Cyan_F","Sign_Sphere10cm_F","Sign_Sphere25cm_F","Sign_Sphere100cm_F","Sign_Circle_F","UserTexture1m_F","UserTexture10m_F","Land_ClutterCutter_large_F","Land_ClutterCutter_medium_F","Land_ClutterCutter_small_F","ProtectionZone_F","ProtectionZone_Invisible_F","Lightning_F","Lightning1_F","Lightning2_F","UserTexture_1x2_F","Sign_Sphere200cm_F","Sign_Sphere10cm_Geometry_F","Sign_Sphere25cm_Geometry_F","Sign_Sphere100cm_Geometry_F","Sign_Sphere200cm_Geometry_F","MemoryFragment_F","SmartMarker_Base_F","SmartMarker_Default_F","SmartMarker_Default2_F","SmartMarker_O_Area_F","SmartMarker_I_Cache_F","SmartMarker_B_Cache_F","SmartMarker_O_MosquitosArea_F","SmartMarker_O_Minefield_F","SmartMarker_O_Cache_F","SmartMarker_I_CacheFound_F","SmartMarker_B_CacheFound_F","SmartMarker_O_CacheFound_F","SmartMarker_B_Loc_F","SmartMarker_I_Loc_F","SmartMarker_C_Loc_F","SmartMarker_I_Camp_F","SmartMarker_C_Boats_F","SmartMarker_C_Trucks_F","SmartMarker_C_Cars_F","SmartMarker_I_Cars_F","SmartMarker_I_Workshop_F","SmartMarker_C_Helicopters_F","SmartMarker_C_Planes_F","SmartMarker_C_Armory_F","SmartMarker_I_Armory_B_F","SmartMarker_I_Armory_Special_F","SmartMarker_C_Misc_F","SmartMarker_I_CarCharge_F","SmartMarker_T_CarChargeActive_F","SmartMarker_I_Armory_F","SmartMarker_I_HQ_F","SmartMarker_I_Boats_F","SmartMarker_I_Rest_F","SmartMarker_I_Plane_F","SmartMarker_B_Plane_F","SmartMarker_B_Default_F","SmartMarker_I_Default_F","SmartMarker_U_Default_F","SmartMarker_O_Default_F","SmartMarker_T_Default_F","SmartMarker_B_HQ_F","SmartMarker_I_Storage_F","SmartMarker_U_Sleep_F","SmartMarker_I_Ambush_F","SmartMarker_I_PickUp_F","SmartMarker_I_Sleep_F","SmartMarker_C_Sleep_F","SmartMarker_I_DeliveryPoint_F","SmartMarker_I_TimeBomb_F","SmartMarker_I_Transport_F","SmartMarker_T_TransportPerson_F","SmartMarker_T_TransportPlane_F","SmartMarker_T_Defend_F","SmartMarker_B_Transport_F","SmartMarker_T_Transport_F","SmartMarker_B_Fetch_F","SmartMarker_I_Fetch_F","SmartMarker_T_Fetch_F","SmartMarker_B_Talk_F","SmartMarker_I_Talk_F","SmartMarker_C_Talk_F","SmartMarker_T_Talk_F","SmartMarker_O_Mosquitos_F","SmartMarker_U_Mosquitos_F","SmartMarker_I_Team_F","SmartMarker_B_Team_F","SmartMarker_T_Support_F","SmartMarker_T_Location_F","SmartMarker_T_Destroy_F","SmartMarker_T_Upload_F","SmartMarker_T_Distraction_F","SmartMarker_B_House_F","SmartMarker_IDAP_F","SmartMarker_O_CSAT_F","SmartMarker_O_Gendarme_F","SmartMarker_O_Convoy_F","SmartMarker_O_SDV_F","SmartMarker_O_checkpoint_F","SmartMarker_B_checkpoint_F","SmartMarker_O_CommandCenter_F","SmartMarker_O_CommsCenter_F","SmartMarker_O_Facility_F","SmartMarker_O_Patrol_F","SmartMarker_O_AA_F","SmartMarker_O_Depo_F","SmartMarker_O_Outpost_F","SmartMarker_O_plane_F","SmartMarker_O_tank_F","SmartMarker_O_heli_F","SmartMarker_O_mortar_F","SmartMarker_O_mech_F","SmartMarker_O_naval_F","SmartMarker_C_Meeting_F","SmartMarker_C_HiddenGun_F"];
publicVariable "sblib_helper_classes";

// sites
sblib_site_varName = "sites_%1_%2";
sblib_siteArea_varName = "siteareas_%1_%2";
sblib_siteArea_activationRadius = 800;
sblib_site_activationConditionDelay = 0.5;

// site area activation condition
sblib_siteArea_activationCondition = {
	params ["_areaName","_areaPos","_areaRadius"];
	
	// exit if all players weren't retrieved
	if (isNil "sblib_allPlayers") exitWith {false};
	
	// exit if there are no players on this server
	if (count sblib_allPlayers == 0) exitWith {false};
	
	private _player_in_activation_radius = false;
	private _exitLoop = false;
	
	// loop through each player
	{
		if (_exitLoop) exitWith {};
		
		// if player exists & player is alive && is in activation radius
		if (alive _x) then {
			if (_x distance _areaPos <= sblib_siteArea_activationRadius) exitWith {
				// exit forEach loop and return this value
				_player_in_activation_radius = true;
				_exitLoop = true;
			};
		};
	} forEach sblib_allPlayers;
	
	_player_in_activation_radius
};

// site area default scripts
sblib_siteArea_scripts = 
[
	//{[_this select 0, _this select 1] call sites_fnc_script_test}
];


// gets all players every 5 second
[] spawn {
	while {true} do {	
		// for performance reasons to use this variable every 0.5s to check and compare distances to activate an site area
		// #temp  #testing (change it to only allPlayers)
		sblib_allPlayers = (playableUnits + switchableUnits);
		//sblib_allPlayers = allPlayers;
		sleep 5;
	};
};


sblib_houseprefab_error_prefabAlreadyDefined = "house prefab with the unique name '%1' for class '%2' is already defined";
sblib_houseprefab_error_prefabDataNotFound = "prefab '%1' doesn't have any data(objects, memory points)";
publicVariable "sblib_houseprefab_error_prefabAlreadyDefined";
publicVariable "sblib_houseprefab_error_prefabDataNotFound";


sblib_config_loaded = true;
publicVariable "sblib_config_loaded"; 