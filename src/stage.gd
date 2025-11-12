extends Node2D

@onready var notes: Control = $GUI/Notes
@onready var choco: Node2D = $Cats/Choco
@onready var tissue: Node2D = $Cats/Tissue
@onready var chris: Node2D = $Cats/Chris
@onready var boom: Node2D = $Cats/Boom
@onready var cat_spots: TileMapLayer = $CatSpots

func _ready() -> void:
	var rules_path = "res://src/rules/stage_%d_rule.gd" % GlobalState.stage_counter
	var rules = load(rules_path)
	GlobalState.placement_rules = rules.new()
	notes.make_children("[color=#d44d13][b]Lala[/b][/color] wants to sit near the window")
	set_cat_name()
	set_tile_in_room()

func set_cat_name():
	print(choco, tissue, chris)
	choco.set_meta('cat_name', 'Choco')
	tissue.set_meta('cat_name', 'Tissue')
	chris.set_meta('cat_name', 'Chris')
	boom.set_meta('cat_name', 'Boom')
	

func set_tile_in_room():
	# Living room tiles
	GlobalState.room_tiles = {
		"living_room": [],
		"bedroom": [],
		"kitchen": [],
		"office": []
	}
	for x in range(-21, -9):
		for y in range(27, 52):
			var coords = Vector2i(x, y)
			var tile_id = cat_spots.get_cell_source_id(coords)
			if tile_id != -1:
				GlobalState.room_tiles['living_room'].append(coords)
				print("Tile ", coords, " is part of the living room")

	# Bedroom tiles
	for x in range(-8, 3):
		for y in range(27, 37):
			var coords = Vector2i(x, y)
			var tile_id = cat_spots.get_cell_source_id(coords)
			if tile_id != -1:
				GlobalState.room_tiles['bedroom'].append(coords)
				print("Tile ", coords, " is part of the bedroom")
				
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		var tile_coords = cat_spots.local_to_map(mouse_pos)
		
		if cat_spots.get_cell_source_id(tile_coords) != -1:
			if tile_coords in GlobalState.room_tiles['living_room']:
				print("Tile ", tile_coords, " is part of the living room")
			elif tile_coords in GlobalState.room_tiles['bedroom']:
				print("Tile ", tile_coords, " is part of the bedroom")
			else:
				print("Tile ", tile_coords, " is not part of any room")
		else: print("Unavailable tile at ", tile_coords)
