extends Node2D

@export var tilemap: TileMapLayer
@onready var loaf: Sprite2D = $Loaf
@onready var picked: Sprite2D = $Picked
@onready var landing_point: Marker2D = $LandingPoint
@onready var angry: Sprite2D = $Angry
@onready var sit: Sprite2D = $Sit

var dragging = false
var drag_offset = Vector2.ZERO
var previous_position = Vector2.ZERO

func _ready():
	sprite_to_loaf()
	# Get tilemap reference
	if !tilemap:
		# Try to find TileMapLayer in parent or scene
		tilemap = get_parent().get_parent().get_node("CatSpots")

var inside_tilemap = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Check if mouse is over this cat
			if is_mouse_over_cat():
				# Save current position before dragging
				previous_position = global_position
				dragging = true
				sprite_to_picked()
				# Center the picked sprite under cursor
				drag_offset = Vector2.ZERO
				# Bring to front while dragging
				z_index = 100
		else:
			if dragging:
				# Stop dragging and snap to tile
				dragging = false
				snap_to_tile()
				# Reset z_index
				z_index = 0
				sprite_to_loaf()

func _process(delta):
	if dragging:
		# Update position while dragging
		global_position = get_global_mouse_position() + drag_offset
		
		if is_inside_tilemap():
			if !inside_tilemap:
				inside_tilemap = true
				print("Entered tilemap area")
				sprite_to_sit()
		else:
			if inside_tilemap:
				inside_tilemap = false
				print("Exited tilemap area")
				sprite_to_picked()

func is_mouse_over_cat() -> bool:
	var mouse_pos = get_global_mouse_position()
	
	# Check sprite children
	for child in get_children():
		if child is Sprite2D or child is AnimatedSprite2D:
			var local_mouse = child.to_local(mouse_pos)
			if child.get_rect().has_point(local_mouse):
				return true
	
	# Fallback: distance check
	var distance = global_position.distance_to(mouse_pos)
	return distance < 50

func snap_to_tile():
	if not tilemap:
		return
	
	# Convert both cursor and landing_point positions to tilemap coordinates
	var mouse_pos = get_global_mouse_position()
	var landing_pos = landing_point.global_position
	
	var mouse_tile = tilemap.local_to_map(tilemap.to_local(mouse_pos))
	var landing_tile = tilemap.local_to_map(tilemap.to_local(landing_pos))
	
	# Check if either tile is valid (source_id != -1 means there’s a tile)
	var mouse_valid = tilemap.get_cell_source_id(mouse_tile) != -1
	var landing_valid = tilemap.get_cell_source_id(landing_tile) != -1
	
	# Choose which tile to snap to (cursor first, else landing_point)
	var target_tile: Vector2i
	if landing_valid:
		target_tile = landing_tile
	elif mouse_valid:
		target_tile = mouse_tile
	else:
		# No valid tile → revert smoothly
		print(name, " - No valid tile under cat, reverting smoothly to previous position")
		move_to_position(previous_position)
		return
	
	if target_tile in GlobalState.occupied_tiles and GlobalState.occupied_tiles[target_tile] != self:
		print(name, " - Tile already occupied! Reverting...")
		move_to_position(previous_position)
		return
	
	for key in GlobalState.occupied_tiles.keys():
		if GlobalState.occupied_tiles[key] == self:
			GlobalState.occupied_tiles.erase(key)
			break
	
	GlobalState.occupied_tiles[target_tile] = self
	
	# Snap to tile center
	var tile_center = tilemap.to_global(tilemap.map_to_local(target_tile))
	global_position = tile_center
	
	print(name, " snapped to tile: ", target_tile)

func move_to_position(target_pos: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_pos, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func is_inside_tilemap() -> bool:
	if not tilemap:
		return false
	
	var mouse_tile = tilemap.local_to_map(tilemap.to_local(global_position))
	var source_id = tilemap.get_cell_source_id(mouse_tile)
	return source_id != -1

func sprite_to_picked():
	hide_all_sprite()
	picked.show()

func sprite_to_loaf():
	hide_all_sprite()
	loaf.show()
	
func sprite_to_angry():
	hide_all_sprite()
	angry.show()
	
func sprite_to_sit():
	hide_all_sprite()
	sit.show()
	
func hide_all_sprite():
	loaf.hide()
	picked.hide()
	angry.hide()
	sit.hide()
