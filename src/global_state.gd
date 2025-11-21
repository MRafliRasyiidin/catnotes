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
static var months = ["March","April","May","June","July","August"]
