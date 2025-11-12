extends Node2D

@onready var notes: Control = $GUI/Notes
@onready var cat_1: Node2D = $Cats/Cat1
@onready var cat_2: Node2D = $Cats/Cat2
@onready var cat_spots: TileMapLayer = $CatSpots

# Arrays for each room
var living_room_tiles: Array[Vector2i] = []
var bedroom_tiles: Array[Vector2i] = []

# Optional dictionary if you ever want to look up by room name
var room_tiles := {
	"living_room": living_room_tiles,
	"bedroom": bedroom_tiles
}

func _ready() -> void:
	var rules = load('res://src/rules/stage_1_rule.gd')
	GlobalState.placement_rules = rules.new()
	cat_1.set_meta('cat_name', 'cat_1')
	cat_2.set_meta('cat_name', 'cat_2')
	notes.make_children("[color=#d44d13][b]Lala[/b][/color] wants to sit near the window")
	set_tile_in_room()

func set_tile_in_room():
	# Living room tiles
	for x in range(-21, -9):
		for y in range(27, 52):
			var coords = Vector2i(x, y)
			var tile_id = cat_spots.get_cell_source_id(coords)
			if tile_id != -1:
				living_room_tiles.append(coords)
				print("Tile ", coords, " is part of the living room")

	# Bedroom tiles
	for x in range(-8, 3):
		for y in range(27, 37):
			var coords = Vector2i(x, y)
			var tile_id = cat_spots.get_cell_source_id(coords)
			if tile_id != -1:
				bedroom_tiles.append(coords)
				print("Tile ", coords, " is part of the bedroom")
				
				
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		var tile_coords = cat_spots.local_to_map(mouse_pos)
		
		if cat_spots.get_cell_source_id(tile_coords) != -1:
			if tile_coords in living_room_tiles:
				print("Tile ", tile_coords, " is part of the living room")
			elif tile_coords in bedroom_tiles:
				print("Tile ", tile_coords, " is part of the bedroom")
			else:
				print("Tile ", tile_coords, " is not part of any room")
		else: print("Unavailable tile at ", tile_coords)

	
