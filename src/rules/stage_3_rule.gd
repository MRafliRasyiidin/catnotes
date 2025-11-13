extends StageRule

var rules_text: Array[String] = [
	#"[color=#d44d13][b]Lala[/b][/color] wants to sit near the window"
	"The office ceiling leaks when it rains. I need to move the beds.",
	"[color=#d44d13][b]Tissue[/b][/color]’s been sleeping more lately. She doesn’t eat as much.",
	"[color=#d44d13][b]Choco[/b][/color] seems restless. Maybe he misses going outside.",
	"[color=#d44d13][b]Nima[/b][/color] scratched the sofa again. I shouldn't put her near it.",
	"[color=#d44d13][b]Miko[/b][/color] hissed at [color=#d44d13][b]Chris[/b][/color] again."
]

var rule: Dictionary = {
	"Choco":{
		"coor": [
			Vector2i(-18, 32),
			Vector2i(-17, 39),
			Vector2i(-11, 35),
			Vector2i(0, 27),
			Vector2i(0, 33),
			Vector2i(-13, 61),
			],
		"cat": []
	},
	"Tissue": {
		"coor": [],
		"cat": []
	},
	"Chris": {
		"coor": [],
		"cat": []
	},
	"Boom": {
		"coor": [],
		"cat": []
	},
	"Nima": {
		"coor": [Vector2i(-11, 35), Vector2i(-11, 28), Vector2i(-17, 39), Vector2i(-18, 32)],
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
