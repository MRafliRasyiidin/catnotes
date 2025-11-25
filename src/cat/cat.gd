extends Node2D

@export var tilemap: TileMapLayer
@onready var loaf: Sprite2D = $Loaf
@onready var picked: Sprite2D = $Picked
@onready var landing_point: Marker2D = $LandingPoint
@onready var angry: Sprite2D = $Angry
@onready var sit: Sprite2D = $Sit
@onready var cat_name: Control = $Name
@onready var hover_area: Area2D = $Area2D 
@onready var cat_animations: AnimationPlayer = $CatAnimations
@onready var nametag_animations: AnimationPlayer = $NametagAnimations
@onready var particles: GPUParticles2D = $GPUParticles2D
@onready var heart_animations: AnimationPlayer = $HeartAnimations


const CURSOR_GRAB = preload("res://assets/ui/cursor/cursor_grab.png")
const CURSOR_HOVER = preload("res://assets/ui/cursor/cursor_hover.png")
const CURSOR_NORMAL = preload("res://assets/ui/cursor/cursor_normal.png")

var dragging = false
var drag_offset = Vector2.ZERO
var previous_position = Vector2.ZERO
var hissed: bool = false
var has_been_placed: bool = false  # NEW FLAG

func _ready():
	cat_animations.play("idle")
	sprite_to_sit()  # start sitting
	# Get tilemap reference
	if !tilemap:
		# Try to find TileMapLayer in parent or scene
		tilemap = get_parent().get_parent().get_node("CatSpots")
	hover_area.connect("mouse_entered", Callable(self, "_on_mouse_entered"))
	hover_area.connect("mouse_exited", Callable(self, "_on_mouse_exited"))

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
				SfxManager.play_random_meow()
				change_cursor(CURSOR_GRAB)
				GlobalState.is_grabbing_cat = true
		else:
			if dragging:
				# Stop dragging and snap to tile
				dragging = false
				snap_to_tile()
				# Reset z_index
				z_index = 0
				GlobalState.is_grabbing_cat = false
				change_cursor(CURSOR_NORMAL)
				

func _process(delta):
	if dragging:
		# Update position while dragging
		global_position = get_global_mouse_position() + drag_offset
		
		#if is_inside_tilemap():
			#if !inside_tilemap:
				#inside_tilemap = true
				#print("Entered tilemap area")
				#sprite_to_sit()
		#else:
			#if inside_tilemap:
				#inside_tilemap = false
				#print("Exited tilemap area")
				#sprite_to_picked()
		#
	else:
		# Only update sprite if cat has been placed
		if has_been_placed:
			var cat_name = self.get_meta("cat_name")
			if cat_name in GlobalState.cat_locations:
				change_sprite(GlobalState.cat_locations[cat_name])

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
	var neighbor_tile_valid = is_valid_tile(mouse_tile, landing_tile)
	# Choose which tile to snap to (cursor first, else landing_point)
	var target_tile: Vector2i
	if neighbor_tile_valid["valid"]:
		target_tile = neighbor_tile_valid["tile"]
	elif landing_valid:
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
	
	# clear old tile reference
	for key in GlobalState.occupied_tiles.keys():
		if GlobalState.occupied_tiles[key] == self:
			GlobalState.occupied_tiles.erase(key)
			break
	
	# assign new tile
	GlobalState.occupied_tiles[target_tile] = self
	GlobalState.cat_locations[self.get_meta("cat_name")] = target_tile
	has_been_placed = true  # ✅ now the cat can change sprites afterward

	change_sprite(target_tile)
	
	# Snap to tile center
	SfxManager.play(SfxManager.get_random_sfx(SfxManager.pillows))
	var tile_center = tilemap.to_global(tilemap.map_to_local(target_tile))
	global_position = tile_center
	print(name, " snapped to tile: ", target_tile)
	particles.emitting = true

func is_valid_tile(mouse: Vector2i, landing: Vector2i):
	var tiles = GlobalState.room_tiles
	for room_name in tiles.keys():
		var room = tiles[room_name]
		for key in room:
			var neighbor = tiles[room_name][key]
			if mouse in neighbor or landing in neighbor:
				return {"valid": true, "tile": key}
	return {"valid": false, "tile": null}

func change_sprite(target_tile):
	if GameManager.can_place_cat(target_tile, self):
		sprite_to_loaf()
	else:
		sprite_to_angry()

func move_to_position(target_pos: Vector2):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", target_pos, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	if GlobalState.cat_locations[self.get_meta('cat_name')] == Vector2i(0,0):
		sprite_to_sit()

func is_loaf() -> bool:
	return loaf.visible == true

func is_dragging() -> bool:
	return dragging

func _on_mouse_entered() -> void:
	change_cursor(CURSOR_HOVER)
	#cat_name.show()
	cat_name.show_cat_name(picked.visible)

func _on_mouse_exited() -> void:
	change_cursor(CURSOR_NORMAL)
	#cat_name.hide()
	cat_name.hide_cat_name(picked.visible)

func sprite_to_picked():
	#var pos = cat_name.position
	#pos.y = -100
	#cat_name.position = pos
	reposition_cat_name(-120)
	hissed = false
	hide_all_sprite()
	picked.show()


func sprite_to_loaf():
	hissed = false
	#var pos = cat_name.position
	#pos.y = -185
	#cat_name.position = pos
	reposition_cat_name(-210.0)
	hide_all_sprite()
	loaf.show()
	

func sprite_to_angry():
	#var pos = cat_name.position
	#pos.y = -185
	#cat_name.position = pos
	reposition_cat_name(-170)
	if !hissed:
		hissed = true
		SfxManager.play(SfxManager.hiss)
		
	hide_all_sprite()
	angry.show()
	

func sprite_to_sit():
	#var pos = cat_name.position
	#pos.y = -220
	#cat_name.position = pos
	reposition_cat_name(-240)
	hide_all_sprite()
	sit.show()
	

func hide_all_sprite():
	loaf.hide()
	picked.hide()
	angry.hide()
	sit.hide()
	
func reposition_cat_name(offset: float):
	var pos = cat_name.position
	pos.y = offset
	cat_name.position.y = pos.y
	
func change_cursor(img: CompressedTexture2D):
	if img == CURSOR_NORMAL and not GlobalState.is_grabbing_cat:
		Input.set_custom_mouse_cursor(img, Input.CURSOR_ARROW,Vector2(16,6))
	elif img == CURSOR_HOVER and not GlobalState.is_grabbing_cat:
		Input.set_custom_mouse_cursor(img, Input.CURSOR_ARROW,Vector2(16,6))
	elif img == CURSOR_GRAB:
		Input.set_custom_mouse_cursor(img, Input.CURSOR_ARROW,Vector2(24,27))
