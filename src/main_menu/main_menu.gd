extends Node2D

@onready var blinker: AnimationPlayer = $CanvasLayer/Title/AnimationPlayer
@onready var transition_anim: AnimationPlayer = $Transition/AnimationPlayer
@onready var start_button: TextureButton = $CanvasLayer/VBoxContainer/Start
@onready var stage_selection_modal: Control = $CanvasLayer/StageSelection


func _ready() -> void:
	MusicManager.play_music(MusicManager.bgm)
	blinker.play("blink")

	transition_anim.play_backwards("fade")
	await transition_anim.animation_finished

func _on_start_pressed() -> void:	
	start_button.disabled = true
	SfxManager.play(SfxManager.click)
	transition_anim.play("fade")
	await transition_anim.animation_finished
	get_tree().change_scene_to_file("res://src/stages/stage_1.tscn")

func _on_exit_pressed() -> void:
	SfxManager.play(SfxManager.click)
	get_tree().quit()

func _on_stages_pressed() -> void:
	SfxManager.play(SfxManager.click)
	stage_selection_modal.show()
