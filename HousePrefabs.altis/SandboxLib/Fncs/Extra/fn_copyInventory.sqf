params ["_object"];


private _object_containers = [];
{
	_x params ["_x_objectClass","_x_objectContainer"];
	
	_object_containers = _object_containers +
	[
		[
			_x_objectClass,
			[
				weaponsItemsCargo _x_objectContainer,
				magazinesAmmoCargo _x_objectContainer,
				getItemCargo _x_objectContainer
			]
		]
	];
} forEach (everyContainer _object);


private _object_cargo =
[	
	weaponsItemsCargo _object,
	magazinesAmmoCargo _object,
	getItemCargo _object,
	_object_containers
];

_object_cargo