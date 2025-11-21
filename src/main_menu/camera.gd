extends Camera2D

# how much the camera moves relative to cursor (in pixels)
@export var follow_strength: float = 0.01

# how smoothly the camera interpolates (higher = slower)
@export var smoothness: float = 5.0

var target_offset: Vector2 = Vector2.ZERO

func _process(delta):
	var viewport_size = get_viewport_rect().size
	var mouse_pos = get_viewport().get_mouse_position()
	
	# Convert mouse position to a range of -1 to 1
	var normalized = (mouse_pos / viewport_size) * 2.0 - Vector2.ONE
	
	# Target offset based on normalized position
	target_offset = normalized * follow_strength * viewport_size
	
	# Smoothly interpolate offset
	offset = offset.lerp(target_offset, delta * smoothness)
