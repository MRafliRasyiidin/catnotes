extends Node

func can_place_cat(tile: Vector2i, cat: Node2D) -> bool:
	var cat_name = cat.get_meta('cat_name')
	var cat_rule = GlobalState.placement_rules.rule.get(cat_name)
	
	if cat_rule and tile in cat_rule["coor"]:
		return false
		
	for cat_enemy_name in cat_rule["cat"]:
		var enemy_cat_loc = GlobalState.cat_locations[cat_enemy_name]
		for room_tile in GlobalState.room_tiles.values():
			if tile in room_tile && enemy_cat_loc in room_tile:
				return false
				
	return true
