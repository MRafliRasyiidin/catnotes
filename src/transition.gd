extends Node2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var current_month: Label = $Top/CurrentMonth
@onready var next_month: Label = $Bottom/NextMonth

func _ready() -> void:
	set_month()
	anim.play("new_month")
	await anim.animation_finished
	var stage_path = "res://src/stages/stage_%d.tscn" % GlobalState.stage_counter
	if GlobalState.stage_counter > 5:
		get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")
	else:
		get_tree().change_scene_to_file(stage_path)
	
func set_month():
	var stage = GlobalState.stage_counter
	
	current_month.text = GlobalState.months[stage-2]
	next_month.text = GlobalState.months[stage-1]
