extends Node

func can_place_cat(tile: Vector2i, cat: Node2D) -> bool:
	var cat_name = cat.get_meta('cat_name')
	var cat_rule = GlobalState.placement_rules.rule.get(cat_name)
	
#	Specific tile
	if cat_rule and tile in cat_rule["coor"]:
		return false
		
#	Rule for enemy cat
	for cat_enemy_name in cat_rule["cat"]:
		var enemy_cat_loc = GlobalState.cat_locations[cat_enemy_name]
		for room_tile in GlobalState.room_tiles.values():
			if tile in room_tile && enemy_cat_loc in room_tile:
				return false
	
#	Rule for tv
	var tv_rule = cat_rule.get("tv", false)
	if tv_rule:
		if tile in GlobalState.room_tiles["living_room"] and GlobalState.tv_on:
			return false
			
	var one_room_rule = cat_rule.get("same_room", [])
	if one_room_rule or len(one_room_rule) != 0:
		for friend_cat in one_room_rule:
			var friend_cat_loc = GlobalState.cat_locations[friend_cat]
			for room_tile in GlobalState.room_tiles.values():
				if tile in room_tile && not friend_cat_loc in room_tile:
					return false
	
	return true
