extends Node2D

@onready var notes: Control = $GUI/Notes
@onready var choco: Node2D = $Cats/Choco
@onready var tissue: Node2D = $Cats/Tissue
@onready var chris: Node2D = $Cats/Chris
@onready var boom: Node2D = $Cats/Boom
@onready var nima: Node2D = $Cats/Nima
@onready var miko: Node2D = $Cats/Miko
@onready var cat_spots: TileMapLayer = $CatSpots
@onready var cats: Node2D = $Cats
@onready var continue_button: TextureButton = $GUI/Continue
@onready var transition_anim: AnimationPlayer = $Transition/AnimationPlayer
@onready var pause_button: TextureButton = $GUI/PauseButton
@onready var pause: Node = $GUI/Pause

var is_complete: bool = false

func _ready() -> void:
	var rules_path = "res://src/rules/stage_%d_rule.gd" % GlobalState.stage_counter
	var rules = load(rules_path)
	GlobalState.placement_rules = rules.new()
	notes.make_children(GlobalState.placement_rules.rules_text)
	set_cat_init_position()
	set_cat_name()
	set_tile_in_room()
	
	transition_anim.play_backwards("fade")
	await transition_anim.animation_finished

func _process(delta):
	is_complete = true
	var cat_list = cats.get_children()
	for cat in cat_list:
		if cat.is_dragging():
			is_complete = false
			break
	if is_complete:
		for cat in cat_list:
			if not cat.is_loaf():
				is_complete = false
				break
	if is_complete && not GlobalState.cat_locations.values().has(Vector2i(0,0)):
		continue_button.show()
	else:
		continue_button.hide()

func set_cat_init_position():
	GlobalState.cat_locations = {
		"Choco": Vector2i(0,0),
		"Tissue": Vector2i(0,0),
		"Boom": Vector2i(0,0),
		"Chris": Vector2i(0,0),
		"Miko": Vector2i(0,0),
		"Nima": Vector2i(0,0),
	}
	GlobalState.occupied_tiles = {}
	if GlobalState.stage_counter >= 4:
		GlobalState.cat_locations["Tissue"] = Vector2i(-1,0)

func set_cat_name():
	print(choco, tissue, chris)
	choco.set_meta('cat_name', 'Choco')
	if GlobalState.stage_counter < 4:
		tissue.set_meta('cat_name', 'Tissue')
	chris.set_meta('cat_name', 'Chris')
	boom.set_meta('cat_name', 'Boom')
	nima.set_meta('cat_name', 'Nima')
	miko.set_meta('cat_name', 'Miko')
	
func set_tile_in_room():
	var all_rooms = []
	# Living room tiles
	GlobalState.room_tiles = {
		"living_room": {},
		"bedroom": {},
		"kitchen": {},
		"office": {}
	}
	
	for x in range(-21, -9):
		for y in range(27, 52):
			var coords = Vector2i(x, y)
			var tile_id = cat_spots.get_cell_source_id(coords)
			if tile_id != -1:
				GlobalState.room_tiles['living_room'][coords] = get_neighbor_tiles(coords)
				print("Tile Vector2i", coords, " is part of the living room")
				all_rooms.append(coords)

	# Bedroom tiles
	for x in range(-8, 4):
		for y in range(27, 38):
			var coords = Vector2i(x, y)
			var tile_id = cat_spots.get_cell_source_id(coords)
			if tile_id != -1:
				GlobalState.room_tiles['bedroom'][coords] = get_neighbor_tiles(coords)
				print("Tile Vector2i", coords, " is part of the bedroom")
				all_rooms.append(coords)
				
	for x in range(-8, 4):
		for y in range(40, 49):
			var coords = Vector2i(x, y)
			var tile_id = cat_spots.get_cell_source_id(coords)
			if tile_id != -1:
				GlobalState.room_tiles['office'][coords] = get_neighbor_tiles(coords)
				print("Tile Vector2i", coords, " is part of the office")
				all_rooms.append(coords)
				
	for x in range(-18, -1):
		for y in range(52, 64):
			var coords = Vector2i(x, y)
			var tile_id = cat_spots.get_cell_source_id(coords)
			if tile_id != -1:
				GlobalState.room_tiles['kitchen'][coords] = get_neighbor_tiles(coords)
				print("Tile Vector2i", coords, " is part of the kitchen")
				all_rooms.append(coords)
	for coords in all_rooms:
		print("Vector2i", coords,",")
				
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		var tile_coords = cat_spots.local_to_map(mouse_pos)
		
		if cat_spots.get_cell_source_id(tile_coords) != -1:
			if tile_coords in GlobalState.room_tiles['living_room']:
				print("Tile ", tile_coords, " is part of the living room")
			elif tile_coords in GlobalState.room_tiles['bedroom']:
				print("Tile ", tile_coords, " is part of the bedroom")
			elif tile_coords in GlobalState.room_tiles['kitchen']:
				print("Tile ", tile_coords, " is part of the kitchen")
			elif tile_coords in GlobalState.room_tiles['office']:
				print("Tile ", tile_coords, " is part of the office")
			else:
				print("Tile ", tile_coords, " is not part of any room")
		else: print("Unavailable tile at ", tile_coords)

func _on_continue_pressed() -> void:
	SfxManager.play(SfxManager.click)
	continue_button.disabled = true
	GlobalState.stage_counter += 1
	transition_anim.play("fade")
	await transition_anim.animation_finished
	if GlobalState.stage_counter > GlobalState.max_stage:
		get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")
	else:
		get_tree().change_scene_to_file("res://src/transition.tscn")

func get_neighbor_tiles(tile: Vector2i) -> Array:
	var offsets = [
		Vector2i(0, -1),  # TOP
		Vector2i(1, -1),  # TOP-RIGHT
		Vector2i(1, 0),   # RIGHT
		Vector2i(1, 1),   # BOTTOM-RIGHT
		Vector2i(0, 1),   # BOTTOM
		Vector2i(-1, 1),  # BOTTOM-LEFT
		Vector2i(-1, 0),  # LEFT
		Vector2i(-1, -1)  # TOP-LEFT
	]

	var neighbors: Array = []

	for offset in offsets:
		var pos = tile + offset
		neighbors.append(pos)

	return neighbors

func _on_pause_button_pressed() -> void:
	pause.pause()
