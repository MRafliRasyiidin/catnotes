extends Control

@onready var name_label: Label = $Name
@onready var nametag_animations: AnimationPlayer = $Name/NametagAnimations

@export var cat_name: String = "Choco"

func _ready() -> void:
	name_label.text = cat_name

func hide_cat_name(picked: bool):
	if picked: return
	nametag_animations.play_backwards("appear")
	await nametag_animations.animation_finished
	hide()
	
func show_cat_name(picked: bool):
	if picked: return
	show()
	nametag_animations.play("appear")
	await nametag_animations.animation_finished
