params ["_house"];

// generate a seed to select a prefab based on position 
private _x_housePos = getPos _x;
						
// generate a seed from the position (X,Y,Z) values, so all players can see the same prefab in the same house
private _seed = ((_x_housePos select 0) * 0.5) + ((_x_housePos select 1) * 0.5) + ((_x_housePos select 2) * 0.5);
_seed