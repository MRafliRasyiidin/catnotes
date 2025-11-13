extends Node2D

@onready var cat: AnimatedSprite2D = $CanvasLayer/Title/Cat
@onready var notes: AnimatedSprite2D = $CanvasLayer/Title/Notes

func _ready() -> void:
	MusicManager.play_music(MusicManager.bgm)
	cat.play("default")
	notes.play("default")

func _on_start_pressed() -> void:
	SfxManager.play(SfxManager.click)
	get_tree().change_scene_to_file("res://src/stages/stage_1.tscn")

func _on_exit_pressed() -> void:
	SfxManager.play(SfxManager.click)
	get_tree().quit()
