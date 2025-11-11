extends Node2D

@onready var notes: Control = $GUI/Notes

func _ready() -> void:
	notes.make_children("[color=#d44d13][b]Lala[/b][/color] wants to sit near the window")
