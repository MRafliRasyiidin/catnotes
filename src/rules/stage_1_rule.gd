extends StageRule

var rule = {
	"cat_1": [Vector2i(17, 46)]
}

func can_place_cat(tile: Vector2i, cat: Node2D) -> bool:
	var cat_name = cat.get_meta('cat_name')
	print(cat_name)
	var cat_rule = rule.get(cat_name)
	if cat_rule and tile in cat_rule:
		
		return false
	return true

#(17,46)
#(16,29)
#(13,27)
#(12,46)
#(6,50)
#(23,78)
