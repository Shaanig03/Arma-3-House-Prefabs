if (!isServer) exitWith {};
sblib_loot_survivalpack_loaded = (isClass(configfile >> "CfgPatches" >> "SNG_SurvivalPack"));

private _military_item_classes = ["c_loot_table_military_clothes","c_loot_table_military_headgear","c_loot_table_military_vests","c_loot_table_military_backpack","c_loot_table_military_goggles","c_loot_table_military_guns"];

// load survival pack (military food items)
if (sblib_loot_survivalpack_loaded) then {
	_military_item_classes pushBack "c_loot_table_food_military";
};

c_loot_table_military =
[
	[	// item
		[	// candidate item
			_military_item_classes,
			[[1], 1, [0],[0.5,0.3,0.7,0.7,0.2,0.8,0.7]]
		]
	]
];
c_loot_table_military_clothes = 
[
	[	// item
		[	// candidate item
			["U_B_CombatUniform_mcam","U_B_CombatUniform_mcam_tshirt","U_I_CombatUniform","U_I_OfficerUniform","U_I_CombatUniform_shortsleeve","U_I_E_Uniform_01_F","U_B_CTRG_1","U_B_CTRG_3","U_B_CTRG_2","U_B_FullGhillie_ard","U_O_FullGhillie_ard","U_I_FullGhillie_ard","U_BG_leader","U_B_CombatUniform_mcam_vest","U_O_SpecopsUniform_ocamo","U_B_survival_uniform","U_B_CombatUniform_mcam_worn","U_I_G_Story_Protagonist_F","U_B_Wetsuit","U_O_Wetsuit","U_I_Wetsuit"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_military_headgear = 
[
	[	// item
		[	// candidate item
			["H_Watchcap_camo","H_Booniehat_mgrn","H_Booniehat_wdl","H_HelmetB_black","H_HelmetB","H_HelmetSpecB_sand","H_CrewHelmetHeli_I","H_CrewHelmetHeli_O","H_CrewHelmetHeli_B","H_HelmetB_light","H_Shemag_olive_hs","H_Cap_headphones","H_Booniehat_eaf","H_MilCap_wdl","H_MilCap_grn"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_military_vests = 
[
	[	// item
		[	// candidate item
			["V_PlateCarrierGL_rgr","V_PlateCarrierGL_mtp","V_PlateCarrier1_rgr","V_PlateCarrier1_wdl","V_PlateCarrier2_rgr_noflag_F","V_PlateCarrierSpec_rgr","V_Chestrig_oli","V_PlateCarrierL_CTRG","V_PlateCarrierH_CTRG","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_oli","V_HarnessO_brn","V_HarnessO_gry","V_TacVest_camo","V_TacVest_khk","V_TacVest_brn","V_TacVest_blk","V_BandollierB_oli","V_BandollierB_khk","V_BandollierB_rgr","V_PlateCarrier_Kerry","V_TacVest_oli","V_I_G_resistanceLeader_F","V_CarrierRigKBT_01_light_Olive_F","V_CarrierRigKBT_01_Olive_F"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_military_backpack = 
[
	[	// item
		[	// candidate item
			["B_TacticalPack_oli","B_TacticalPack_mcamo","B_TacticalPack_ocamo","B_TacticalPack_rgr","B_TacticalPack_blk","B_Kitbag_tan","B_Kitbag_sgg","B_Kitbag_mcamo","B_Kitbag_rgr","B_Kitbag_cbr","B_FieldPack_oucamo","B_FieldPack_taiga_F","B_FieldPack_oli","B_FieldPack_khk","B_FieldPack_ocamo","B_FieldPack_cbr","B_Carryall_oucamo","B_Carryall_oli","B_Carryall_mcamo","B_Carryall_khk","B_Carryall_ocamo","B_Bergen_tna_F","B_Bergen_mcamo_F","B_Bergen_hex_F","B_Bergen_dgtl_F"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_military_goggles = 
[
	[	// item
		[	// candidate item
			["G_Balaclava_oli","G_Combat_Goggles_tna_F","G_Balaclava_TI_tna_F","G_Balaclava_TI_G_tna_F","G_Combat","G_AirPurifyingRespirator_01_F","G_AirPurifyingRespirator_02_olive_F"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_military_guns = 
[
	[	// item
		[	// candidate item
			["arifle_AK12_F","arifle_AK12_GL_lush_F","arifle_AK12_GL_F","arifle_AK12U_F","arifle_AK12U_arid_F","LMG_03_F","srifle_LRR_F","srifle_DMR_06_hunter_F","srifle_DMR_06_camo_F","srifle_DMR_06_olive_F","srifle_EBR_F","LMG_Mk200_F","LMG_Mk200_black_F","arifle_Mk20C_plain_F","arifle_MX_F","arifle_MX_Black_F","arifle_MX_GL_F","MMG_01_tan_F","MMG_01_hex_F","arifle_MXM_Black_F","arifle_MXC_F","srifle_DMR_01_F","arifle_RPK12_F","arifle_RPK12_arid_F","arifle_SDAR_F","arifle_SPAR_01_blk_F","arifle_SPAR_01_khk_F","arifle_SPAR_01_GL_blk_F","arifle_SPAR_01_GL_khk_F","arifle_SPAR_03_khk_F","arifle_SPAR_03_snd_F","SMG_02_F","arifle_TRG20_F","LMG_Zafir_F","SMG_01_F","arifle_TRG21_GL_F","arifle_TRG21_F","arifle_Mk20C_F","arifle_MX_GL_Black_F","srifle_DMR_03_tan_F","srifle_DMR_03_F","srifle_LRR_camo_F","srifle_LRR_tna_F"],
			[[1], 1, [5,7,12]]
		]
	]
];

//
c_loot_table_civ_clothes =
[
	[	// item
		[	// candidate item
			["U_C_FormalSuit_01_tshirt_gray_F","U_C_FormalSuit_01_tshirt_black_F","U_C_FormalSuit_01_khaki_F","U_C_FormalSuit_01_gray_F","U_C_FormalSuit_01_blue_F","U_C_FormalSuit_01_black_F","U_C_Uniform_Farmer_01_F","U_C_Poloshirt_tricolour","U_C_Poloshirt_stripped","U_C_Poloshirt_salmon","U_C_Poloshirt_redwhite","U_C_Poloshirt_burgundy","U_C_Poloshirt_blue","U_C_ArtTShirt_01_v3_F","U_C_ArtTShirt_01_v5_F","U_C_Man_casual_1_F","U_C_Man_casual_3_F","U_C_ArtTShirt_01_v4_F","U_C_ArtTShirt_01_v2_F","U_C_Man_casual_2_F","U_C_ArtTShirt_01_v1_F","U_C_ArtTShirt_01_v6_F","U_I_C_Soldier_Bandit_3_F","U_I_C_Soldier_Bandit_5_F","U_I_C_Soldier_Bandit_2_F","U_I_C_Soldier_Bandit_1_F","U_I_C_Soldier_Bandit_4_F","U_C_IDAP_Man_TeeShorts_F","U_C_IDAP_Man_Tee_F","U_C_IDAP_Man_shorts_F","U_C_IDAP_Man_casual_F","U_C_IDAP_Man_Jeans_F","U_C_IDAP_Man_cargo_F","U_C_Mechanic_01_F","U_C_Uniform_Scientist_02_formal_F","U_C_Man_casual_4_F","U_C_Man_casual_5_F","U_C_Poor_1"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_civ_headgear =
[
	[	// item
		[	// candidate item
			["H_Bandanna_gry","H_Bandanna_blu","H_Bandanna_cbr","H_Bandanna_surfer","H_Bandanna_surfer_blk","H_Bandanna_surfer_grn","H_PASGT_basic_blue_F","H_Cap_blk","H_Cap_blu","H_Cap_grn","H_Cap_surfer","H_EarProtectors_black_F","H_EarProtectors_orange_F","H_EarProtectors_white_F","H_EarProtectors_red_F","H_Hat_blue","H_Hat_brown","H_Hat_camo","H_HeadSet_black_F","H_MilCap_blue","H_Helmet_Skate","H_WirelessEarpiece_F","H_RacingHelmet_1_blue_F","H_RacingHelmet_1_black_F","H_RacingHelmet_1_green_F","H_RacingHelmet_1_orange_F","H_RacingHelmet_1_red_F"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_civ_goggles = 
[
	[	// item
		[	// candidate item
			["G_Aviator","G_EyeProtectors_F","G_Respirator_white_F","G_Shades_Black","G_Spectacles","G_Sport_Red","G_Sport_Checkered","G_Sport_BlackWhite","G_WirelessEarpiece_F","G_Spectacles_Tinted","G_Goggles_VR","G_Shades_Green","G_Sport_Blackred","G_Sport_Greenblack"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_civ_vest =
[
	[	// item
		[	// candidate item
			["V_DeckCrew_blue_F","V_DeckCrew_red_F","V_DeckCrew_violet_F","V_EOD_IDAP_blue_F","V_LegStrapBag_black_F","V_Safety_blue_F","V_Safety_orange_F","V_Safety_yellow_F","V_Press_F"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_civ_backpack =
[
	[	// item
		[	// candidate item
			["B_AssaultPack_cbr","B_AssaultPack_blk","B_AssaultPack_rgr","B_CivilianBackpack_01_Everyday_Black_F","B_CivilianBackpack_01_Everyday_Vrana_F","B_FieldPack_cbr","B_FieldPack_blk","B_CivilianBackpack_01_Sport_Blue_F","B_CivilianBackpack_01_Sport_Green_F","B_CivilianBackpack_01_Sport_Red_F","B_Messenger_Coyote_F","B_Messenger_Black_F"],
			[[1], 1, [0]]
		]
	]
];
c_loot_table_civ_guns =
[
	[	// item
		[	// candidate item
			["sgun_HunterShotgun_01_F","sgun_HunterShotgun_01_sawedoff_F","srifle_DMR_06_hunter_F","SMG_02_F","hgun_PDW2000_F"],
			[[1], 1, [5,7,12]]
		]
	]
];

// if survival pack mod is loaded 
if (sblib_loot_survivalpack_loaded) then {

	// define food loot table if survival pack mod is loaded
	c_loot_table_food_civ =
	[
		[	// item
			[	// candidate item
				["SPItem_TacticalBacon","SPItem_Cerealbox","SPItem_PowderedMilk","SPItem_RiceBox","SPItem_Orange","SPItem_BakedBeans","SPItem_Waterbottle","SPItem_CanSpirit","SPItem_CanFranta","SPItem_CanRedGull"],
				[[1], 1, [0]]
			]
		]
	];
	c_loot_table_food_military =
	[
		[	// item
			[	// candidate item
				["SPItem_MRE","SPItem_TacticalBacon","SPItem_CanRedGull"],
				[[1], 1, [0],[1,0.2,0.2]]
			]
		]
	];
	c_loot_house_food =
	[
		[	// item
			[	// candidate item
				["c_loot_table_food_civ"],
				[[1], 0.5, [0]]
			]
		]
	];
};

c_loot_table_civ =
[
	[	// item
		[	// candidate item
			["c_loot_table_civ_clothes","c_loot_table_civ_headgear", "c_loot_table_civ_vest", "c_loot_table_civ_backpack", "c_loot_table_civ_guns","c_loot_table_food_civ","c_loot_table_civ_goggles"],
			[[1], 1, [0],[0.5,0.5,0.7,0.7,0.7,0.7,0.5]]
		]
	]
];


/////////////////////////////////// existing prefab loot tables ///////////////////////////////////////////////

if (sblib_loot_survivalpack_loaded) then {
	c_loot_house_food =
	[
		[	// item
			[	// candidate item
				["c_loot_table_food_civ"],
				[[1], 0.5, [0]]
			]
		]
	];
};



c_loot_house =
[
	[	// item
		[	// candidate item
			["c_loot_table_civ"],
			[[1], 0.5, [0]]
		]
	],
	[	// item
		[	// candidate item
			["c_loot_table_civ"],
			[[1], 0.1, [0]]
		]
	]
];
c_loot_house_broken =
[
	[	// item
		[	// candidate item
			["c_loot_table_civ"],
			[[1], 0.1, [0]]
		]
	]
];
c_holder_airport =
[
	[	// item
		[	// candidate item
			["ItemRadio","RadioGPS","c_loot_table_civ_guns","c_loot_table_civ_headgear"],
			[[1], 0.5, [0]]
		]
	]
];


private _garage_item_and_lootTable_classes = ["c_loot_table_civ_guns","Toolkit"];
if (sblib_loot_survivalpack_loaded) then {
	_garage_item_and_lootTable_classes pushBack ["SPItem_CanisterFuel","SPItem_CanisterFuelEmpty"];
};
c_holder_garage =
[
	[	// item
		[	// candidate item
			_garage_item_and_lootTable_classes,
			[[1], 0.5, [0],[0.7,0.4,0.7,0.7]]
		]
	]
];

c_holder_shed =
[
	[	// item
		[	// candidate item
			["c_loot_table_civ"],
			[[1], 0.4, [0]]
		]
	]
];

c_loot_office =
[
	[	// item
		[	// candidate item
			["c_loot_table_civ_guns", "c_loot_table_civ_headgear", "c_loot_table_civ_backpack"],
			[[1], 0.5, [0],[0.5, 0.7, 0.7]]
		]
	]
];

c_loot_shop =
[
	[	// item
		[	// candidate item
			["c_loot_table_civ"],
			[[1], 0.8, [0]]
		]
	]
];

private _item_classes = ["c_loot_table_civ_backpack","c_loot_table_civ_guns","c_loot_table_civ_headgear","Toolkit"];
if (sblib_loot_survivalpack_loaded) then {
	_item_classes pushBack ["SPItem_CanisterFuel","SPItem_CanisterFuelEmpty"];
};

c_loot_construction =
[
	[	// item
		[	// candidate item
			_item_classes,
			[[1], 0.5, [0], [0.7,0.5,0.7,0.6,0.7,0.7]]
		]
	]
];

_item_classes = ["c_loot_table_civ_backpack","c_loot_table_civ_guns","c_loot_table_civ_headgear","Toolkit"];
if (sblib_loot_survivalpack_loaded) then {
	_item_classes pushBack ["SPItem_CanisterFuel","SPItem_CanisterFuelEmpty"];
};

c_loot_industrial =
[
	[	// item
		[	// candidate item
			_item_classes,
			[[1], 0.4, [0]]
		]
	]
];

c_loot_research =
[
	[	// item
		[	// candidate item
			["FirstAidKit","c_loot_table_civ_backpack","c_loot_table_civ_headgear"],
			[[1], 0.5, [0]]
		]
	]
];

c_loot_military =
[
	[	// item
		[	// candidate item
			["c_loot_table_military"],
			[[1], 0.7, [0]]
		]
	],
	[	// item
		[	// candidate item
			["c_loot_table_military"],
			[[1], 0.2, [0]]
		]
	]
];

c_loot_military_abandoned =
[
	[	// item
		[	// candidate item
			["c_loot_table_military_clothes","c_loot_table_military_headgear","c_loot_table_military_vests","c_loot_table_military_goggles","c_loot_table_military_guns"],
			[[1], 0.5, [0]]
		]
	]
];

c_loot_military_tower =
[
	[	// item
		[	// candidate item
			["c_loot_table_military"],
			[[1], 0.8, [0]]
		]
	],
	[	// item
		[	// candidate item
			["c_loot_table_military"],
			[[1], 0.4, [0]]
		]
	]
];
c_loot_military_office =
[
	[	// item
		[	// candidate item
			["c_loot_table_military_clothes","c_loot_table_military_goggles","c_loot_table_military_backpack","c_loot_table_military_guns"],
			[[1], 0.8, [0],[0.5,0.5,0.5,0.7]]
		]
	]
];

c_loot_medical =
[
	[	// item
		[	// candidate item
			["Medikit","FirstAidKit"],
			[[1], 0.8, [0],[0.1,0.5]]
		]
	],
	[	// item
		[	// candidate item
			["FirstAidKit"],
			[[2,3,4], 0.5, [0]]
		]
	]
];
//////////////////////////////////////////////////////////////////////////////////

/*




c_loot_table_civ_foods =
[
	[ // item
		[ // candidate item
			["SPItem_TacticalBacon","SPItem_Cerealbox","SPItem_PowderedMilk","SPItem_RiceBox","SPItem_Orange","SPItem_BakedBeans","SPItem_Waterbottle","SPItem_CanSpirit","SPItem_CanFranta","SPItem_CanRedGull"],
			[[1], 1, []]
		]
	]
];




sblib_survivalpack_mod_found = (isClass(configfile >> "CfgPatches" >> "SNG_SurvivalPack"));
publicVariable "sblib_survivalpack_mod_found";

c_loot_table_civ_gear =
[
	[ // item
		[ // candidate item
			["c_loot_table_civ_clothes","c_loot_table_civ_headgear","c_loot_table_civ_vest","c_loot_table_civ_backpack","c_loot_table_civ_guns"],
			[[1], 1, []]
		]
	]
];

private _c_loot_civ_classes = ["c_loot_table_civ_gear"];
if (sblib_survivalpack_mod_found) then {
	_c_loot_civ_classes pushBack "c_loot_table_civ_foods";
};

c_loot_civ =
[
	[ // candidate item
		_c_loot_civ_classes,
		[[1], 1, []]
	]
];


 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];


 =
[
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	],
	[	// item 
		[ // candidate item
			[
				"ItemMap",
				"ItemGPS"
				
			],
			[[5], 0, []]
		]
	]
];
