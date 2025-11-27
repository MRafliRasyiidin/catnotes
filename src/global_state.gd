extends Node

static var occupied_tiles = {}
static var placement_rules = null
static var stage_counter = 1
static var cat_locations = {
	"Choco": Vector2i(0,0),
	"Tissue": Vector2i(0,0),
	"Boom": Vector2i(0,0),
	"Chris": Vector2i(0,0),
	"Miko": Vector2i(0,0),
	"Nima": Vector2i(0,0),
}
static var room_tiles: Dictionary = {
	"living_room": {},
	"bedroom": {},
	"kitchen": {},
	"office": {}
}
static var months = [
	"May","June","July","August",
	"September","October","November","December",
	"January","February","March","April"
	]
static var max_stage = 12
static var tv_on = false

static var unlocked_stage = {
	"1": true,
	"2": false,
	"3": false,
	"4": false,
	"5": false,
	"6": false,
	"7": false,
	"8": false,
	"9": false,
	"10": false,
	"11": false,
	"12": false,
}

static var is_grabbing_cat: bool = false

func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
