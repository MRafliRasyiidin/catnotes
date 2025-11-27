extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var texture_rect: Sprite2D = $TextureRect


func _ready() -> void:
	texture_rect.modulate = Color.TRANSPARENT
	animation_player.play("ending")
	await  animation_player.animation_finished
	get_tree().change_scene_to_file("res://src/transition.tscn")
