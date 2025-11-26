extends Control

@onready var resume_button: TextureButton = $PauseLayer/MarginContainer/Panel/VBoxContainer/ResumeButton
@onready var settings_button: TextureButton = $PauseLayer/MarginContainer/Panel/VBoxContainer/SettingsButton
@onready var quit_button: TextureButton = $PauseLayer/MarginContainer/Panel/VBoxContainer/ExitButton
@onready var options_menu: Control = $PauseLayer/PauseOptionsMenu
@onready var margin_container: MarginContainer = $PauseLayer/MarginContainer
#@onready var back_options: Button = $PauseLayer/PauseOptionsMenu/MarginContainer/VBoxContainer/Button
@onready var canvas_layer: CanvasLayer = $PauseLayer

func _ready():
	options_menu.connect("back_options_pressed", Callable(self, "_on_child_closed"))
	canvas_layer.hide()

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		if get_tree().current_scene.name == "MainMenu":
			return
		#pause()
			
func pause():
	# Toggle pause state
	var tree = get_tree()
	tree.paused = !tree.paused
	if tree.paused:
		canvas_layer.show()
	else:
		canvas_layer.hide()
	SfxManager.play(SfxManager.phone)

func _on_resume_pressed():
	SfxManager.play(SfxManager.click)
	var tree = get_tree()
	tree.paused = false
	canvas_layer.hide()

func _on_settings_button_pressed() -> void:
	SfxManager.play(SfxManager.click)
	options_menu.visible = true
	margin_container.visible = false

func _on_exit_button_pressed() -> void:
	SfxManager.play(SfxManager.click)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")

func _on_resume_button_focus_entered() -> void:
	print("hohohoho")

func _on_child_closed():
	options_menu.visible = false
	margin_container.visible = true
	canvas_layer.show()
