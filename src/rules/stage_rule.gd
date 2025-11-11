extends Resource
class_name StageRule

# This method must be derived to it's child
func can_place_cat(tile: Vector2i, cat: Node2D) -> bool:
	return true
