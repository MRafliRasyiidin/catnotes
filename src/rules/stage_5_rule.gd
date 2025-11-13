extends StageRule

var rules_text: Array[String] = [
	#"[color=#d44d13][b]Lala[/b][/color] wants to sit near the window"
	"[color=#d44d13][b]Choco[/b][/color] has calmed down lately, He naps by the window in my bedroom",
	"[color=#d44d13][b]Nima[/b][/color] wants to be in the kitchen for some reason.",
	"[color=#d44d13][b]Miko[/b][/color] and [color=#d44d13][b]Chris[/b][/color] are at it as always.",
	"[color=#d44d13][b]Chris[/b][/color] still doesn't like [color=#d44d13][b]Boom[/b][/color] but also doesn't like the office.",
	"I’m thinking of fostering another cat soon."
]

var rule: Dictionary = {
	"Choco":{
		"coor": [
			Vector2i(-19, 31),
			Vector2i(-11, 28),
			Vector2i(-11, 35),
			#Vector2i(2, 31),
			Vector2i(-6, 40),
			Vector2i(-16, 62),

			],
		"cat": []
	},
	"Tissue": {
		"coor": [],
		"cat": []
	},
	"Chris": {
		"coor": [Vector2i(-6, 40)],
		"cat": ["Boom"]
	},
	"Boom": {
		"coor": [],
		"cat": []
	},
	"Nima": {
		"coor": [],
		"cat": []
	},
	"Miko": {
		"coor": [],
		"cat": ["Chris"]
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
