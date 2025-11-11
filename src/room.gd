extends Node2D

@onready var tilemap: TileMapLayer = $TileMapLayer
@onready var icon: Sprite2D = $Icon

var dragging = false
var drag_offset = Vector2.ZERO

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Check if mouse is over the icon
			if is_mouse_over_icon():
				print('ayaya')
				dragging = true
				drag_offset = icon.global_position - get_global_mouse_position()
		else:
			if dragging:
				# Stop dragging and snap to tile
				dragging = false
				snap_to_tile()

func _process(delta):
	if dragging:
		# Update icon position while dragging
		icon.global_position = get_global_mouse_position() + drag_offset

func is_mouse_over_icon() -> bool:
	var local_mouse = icon.to_local(get_global_mouse_position())
	return icon.get_rect().has_point(local_mouse)

func snap_to_tile():
	# Get the mouse position in tilemap coordinates
	var mouse_pos = get_global_mouse_position()
	
	# Convert world position to tilemap coordinates
	var tile_coords = tilemap.local_to_map(tilemap.to_local(mouse_pos))
	
	# Convert back to world position (center of the tile)
	var tile_center = tilemap.to_global(tilemap.map_to_local(tile_coords))
	
	# Snap the icon to the tile center
	icon.global_position = tile_center
