extends StageRule

var rules_text: Array[String] = [
	#"[color=#d44d13][b]Lala[/b][/color] wants to sit near the window"
	"[color=#d44d13][b]Choco[/b][/color] likes to sleep near a window. Perhaps she likes playing outside.",
	"[color=#d44d13][b]Boom[/b][/color] likes to be close to me recently, usually in the bedroom.",
	"[color=#d44d13][b]Chris[/b][/color] has been messing around the TV. I don't want to deal with paying for repairs."
]

var rule: Dictionary = {
	"Choco":{
		"coor": [Vector2i(-16, 35),Vector2i(-12,40),Vector2i(-5, 35),Vector2i(0, 27),Vector2i(-3, 45),Vector2i(-16, 62)],
		"cat": []
	},
	"Tissue": {
		"coor": [],
		"cat": []
	},
	"Chris": {
		"coor": [Vector2i(-12, 40),Vector2i(-11, 28),Vector2i(-16, 35)],
		"cat": []
	},
	"Boom": {
		"coor": [Vector2i(-16, 35),Vector2i(-12, 40),Vector2i(-11, 28),Vector2i(-16, 62),Vector2i(-3,45)],
		"cat": []
	},
	"Nima": {
		"coor": [],
		"cat": []
	},
	"Miko": {
		"coor": [],
		"cat": []
	}
}

func can_place_cat(tile: Vector2i, cat: Node2D) -> bool:
	var cat_name = cat.get_meta('cat_name')
	var cat_rule = rule.get(cat_name)
	
	if cat_rule and tile in cat_rule["coor"]:
		return false
		
	for cat_enemy_name in cat_rule["cat"]:
		var enemy_cat_loc = GlobalState.cat_locations[cat_enemy_name]
		for room_tile in GlobalState.room_tiles.values():
			if tile in room_tile && enemy_cat_loc in room_tile:
				return false
				
	return true
