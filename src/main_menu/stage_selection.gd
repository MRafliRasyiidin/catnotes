extends Control

var stage_button_list: Array = []

func _ready() -> void:
	var button_list: Array[Node] = get_tree().get_nodes_in_group("stage_buttons")
	for btn: TextureButton in button_list:
		print(btn.name)
		if GlobalState.unlocked_stage[btn.name]:
			btn.pressed.connect(_on_stage_pressed.bind(btn, btn.name))
		else:
			btn.disabled = true
			btn.texture_normal = preload("res://assets/ui/Stage selection/Locked stage.png")
			btn.texture_hover = null
		btn.get_node("Label").text = str(btn.name)
		stage_button_list.append(btn)

func _on_stage_pressed(btn: TextureButton, stage: String) -> void:
	for b in stage_button_list:
		b.disabled = true
	var scene = "res://src/stages/stage_%s.tscn" % stage
	if FileAccess.file_exists(scene):
		get_tree().change_scene_to_file(scene)
