extends StageRule

var rules_text: Array[String] = [
	#"[color=#d44d13][b]Lala[/b][/color] wants to sit near the window"
	"Just moved in. The cats are still getting used to the place.",
	"Assign each cat to their bed.",
	"[color=#0c19ad][b]HINTS:[/b][/color]\nLeft-click and drag the cats to a location indicated by the [b]paws.[/b]\nRight-click and drag to move the camera around."
]

var rule: Dictionary = {
	"Choco":{
		"coor": [],
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
