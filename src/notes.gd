extends Control

@onready var v_box_container: VBoxContainer = $TextureRect/MarginContainer/VSplitContainer/VBoxContainer
@onready var note = $TextureRect/MarginContainer/VSplitContainer/VBoxContainer/Note
@onready var texture_rect: TextureRect = $TextureRect
@onready var expand: Label = $TextureRect/MarginContainer/VSplitContainer/VBoxContainer2/Expand
@onready var month: Label = $TextureRect/MarginContainer/VSplitContainer/VBoxContainer2/Month


var notes: Array = []
var is_moved_up: bool = false
var tween: Tween

func _ready() -> void:
	set_month()
	notes.clear()
	for child in v_box_container.get_children():
		notes.append(child)
	
	# Connect the click signal
	texture_rect.gui_input.connect(_on_texture_rect_gui_input)

func make_children(text: String):
	var new_note = note.duplicate()
	new_note.text = "[color=#2d2244]" + text + "[/color]"
	v_box_container.add_child(new_note)

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_toggle_texture_rect_position()

func _toggle_texture_rect_position() -> void:
	if tween and tween.is_running():
		return # prevent interrupting the animation

	var target_y: float
	if is_moved_up:
		target_y = texture_rect.position.y + 520
		expand.text = "Click to expand"
	else:
		target_y = texture_rect.position.y - 520
		expand.text = "Click to collapse"

	is_moved_up = !is_moved_up

	# Create and start tween animation
	tween = create_tween()
	tween.tween_property(texture_rect, "position:y", target_y, 0.4).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func set_month() -> void:
	if GlobalState.months && GlobalState.stage_counter < 6:
		month.text = GlobalState.months[GlobalState.stage_counter-1]
	else:
		month.text = "Unknown Scene"
