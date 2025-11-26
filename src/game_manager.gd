extends Node

func can_place_cat(tile: Vector2i, cat: Node2D) -> bool:
	var cat_name = cat.get_meta('cat_name')
	var cat_rule = GlobalState.placement_rules.rule.get(cat_name)
	
#	Specific tile dislike
	if cat_rule and tile in cat_rule["not_tile"]:
		return false
	
#	Specific tile like
	var only_tiles = cat_rule.get("only_tile", [])
	if only_tiles:
		if not tile in only_tiles:
			return false

	
# 	Rule for disliked rooms
	var avoid_rooms = cat_rule.get("avoid_room", [])
	if avoid_rooms:
		for room_name in avoid_rooms:
			var room_tiles = GlobalState.room_tiles.get(room_name)
			if room_tiles and tile in room_tiles:
				return false
				
# 	Rule for preferred rooms
	var only_rooms = cat_rule.get("only_room", [])
	if only_rooms:
		var in_allowed_room := false
		for room_name in only_rooms:
			var room_tiles = GlobalState.room_tiles.get(room_name)
			if room_tiles and tile in room_tiles:
				in_allowed_room = true
				break
		if not in_allowed_room:
			return false
	
		
#	Rule for enemy cat
	for cat_enemy_name in cat_rule["cat"]:
		var enemy_cat_loc = GlobalState.cat_locations[cat_enemy_name]
		for room_tile in GlobalState.room_tiles.values():
			if tile in room_tile && enemy_cat_loc in room_tile:
				return false
	
#	Rule for tv dislike
	var tv_rule = cat_rule.get("tv", false)
	if tv_rule:
		if tile in GlobalState.room_tiles["living_room"] and GlobalState.tv_on:
			return false
#	Rule for tv like
	var tv_prefer_rule = cat_rule.get("tv_prefer", false)
	if tv_prefer_rule:
		var is_in_living_room = tile in GlobalState.room_tiles["living_room"]
		var tv_is_on = GlobalState.tv_on
		if not (is_in_living_room and tv_is_on):
			return false
			
			
			
	var one_room_rule = cat_rule.get("same_room", [])
	if one_room_rule or len(one_room_rule) != 0:
		for friend_cat in one_room_rule:
			var friend_cat_loc = GlobalState.cat_locations[friend_cat]
			for room_tile in GlobalState.room_tiles.values():
				if tile in room_tile && not friend_cat_loc in room_tile:
					return false
	
	return true
