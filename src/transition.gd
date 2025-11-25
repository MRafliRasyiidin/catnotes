extends Control

@onready var anim: AnimationPlayer = $Calander/AnimationPlayer
@onready var current_month: Label = $Calander/Top/CurrentMonth
@onready var next_month: Label = $Calander/Bottom/NextMonth
@onready var transition_anim: AnimationPlayer = $Transition/AnimationPlayer


func _ready() -> void:
	set_month()
	
	anim.play("RESET")
	
	transition_anim.play_backwards("fade")
	await transition_anim.animation_finished
	
	anim.play("new_month")
	await anim.animation_finished
	
	transition_anim.play("fade")
	await transition_anim.animation_finished
	
	var stage_path = "res://src/stages/stage_%d.tscn" % GlobalState.stage_counter
	if GlobalState.stage_counter > 5:
		get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")
	else:
		get_tree().change_scene_to_file(stage_path)
	
func set_month():
	var stage = GlobalState.stage_counter
	
	current_month.text = GlobalState.months[stage-2]
	next_month.text = GlobalState.months[stage-1]
