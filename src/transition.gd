extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var current_month: Label = $Top/CurrentMonth
@onready var next_month: Label = $Bottom/NextMonth

func _ready() -> void:
	set_month()
	anim.play("new_month")
	await get_tree().create_timer(3).timeout
	var stage_path = "res://src/stages/stage_%d.tscn" % GlobalState.stage_counter
	get_tree().change_scene_to_file(stage_path)
	
func set_month():
	var stage = GlobalState.stage_counter
	var months = ["March","April","May","June","July"]
	
	current_month.text = months[stage-1]
	next_month.text = months[stage]
