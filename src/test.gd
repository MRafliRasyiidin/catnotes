extends Node2D

@onready var notes: Control = $GUI/Notes
@onready var cat_1: Node2D = $Cats/Cat1
@onready var cat_2: Node2D = $Cats/Cat2

func _ready() -> void:
	var rules = load('res://src/rules/stage_1_rule.gd')
	GlobalState.placement_rules = rules.new()
	cat_1.set_meta('cat_name', 'cat_1')
	cat_2.set_meta('cat_name', 'cat_2')
	notes.make_children("[color=#d44d13][b]Lala[/b][/color] wants to sit near the window")
