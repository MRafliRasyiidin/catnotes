extends Node2D

@onready var blinker: AnimationPlayer = $CanvasLayer/Title/AnimationPlayer
@onready var transition_anim: AnimationPlayer = $Transition/AnimationPlayer


func _ready() -> void:
	GlobalState.stage_counter = 1
	MusicManager.play_music(MusicManager.bgm)
	blinker.play("blink")
	
	transition_anim.play_backwards("fade")
	await transition_anim.animation_finished

func _on_start_pressed() -> void:
	SfxManager.play(SfxManager.click)
	transition_anim.play("fade")
	await transition_anim.animation_finished
	get_tree().change_scene_to_file("res://src/stages/stage_1.tscn")

func _on_exit_pressed() -> void:
	SfxManager.play(SfxManager.click)
	get_tree().quit()
