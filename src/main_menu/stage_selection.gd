extends Control

var stage_button_list: Array = []

func _ready() -> void:
	var x = get_tree().get_nodes_in_group("stage_buttons")
	for btn in get_tree().get_nodes_in_group("stage_buttons"):
		btn.pressed.connect(_on_stage_pressed.bind(btn, btn.name))
		btn.get_node("Label").text = str(btn.name)
		stage_button_list.append(btn)

func _on_stage_pressed(btn: TextureButton, stage: String) -> void:
	for b in stage_button_list:
		b.disabled = true
	var scene = "res://src/stages/stage_%s.tscn" % stage
	if FileAccess.file_exists(scene):
		get_tree().change_scene_to_file(scene)
