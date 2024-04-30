class sandboxlib
{
	class fncs
	{
		file = "SandboxLib\Fncs";

		class config {preInit  = 1;};
		class defined_housePrefabs {preInit  = 1;};
		class defined_loots {preInit  = 1;}
	};
};

class loot 
{
	class fncs 
	{
		file = "SandboxLib\Fncs\Loot";
		
		class addItem {};
		class addLoot {};
		class addWeaponMag {};
		class getWeaponObjectClass {};
		
	};
};

class houseprefabs
{
	class fncs 
	{
		file = "SandboxLib\Fncs\HousePrefabs";
		
		class createPrefabs {};
		class definePrefab {};
		class spawnPrefab {};
		class defineMemoryPoint {};
		class playerInit {postInit = 1;};
		class disconnectDespawner {postInit = 1;};
		class houseSeed {};
	};
	class memoryPoints
	{
		file = "SandboxLib\Fncs\HousePrefabs\MemoryPoints";
		class house_mempoint_loot {};
	};
};

class extra
{
	class fncs 
	{
		file = "SandboxLib\Fncs\Extra";
		
		class debugMarker {};
		class playSoundGlobal {};
		
		class posInsideBoundingBox {};
		class sortPositionsByDistance {};
		class relativePos {};
		class rotatePosFromCenter {};
		class selectObjectByNearest {};
		
		class copyObject {};
		class pasteObject {};
		
		class copyInventory {};
		class pasteInventory {};
		class hasInv {};
		
		class convertRange {};
	};
};