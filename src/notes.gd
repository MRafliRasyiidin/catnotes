extends Control

@onready var v_box_container: VBoxContainer = $TextureRect/MarginContainer/VSplitContainer/VBoxContainer
@onready var note = $TextureRect/MarginContainer/VSplitContainer/VBoxContainer/Note
@onready var texture_rect: TextureRect = $TextureRect
@onready var expand: Label = $TextureRect/MarginContainer/VSplitContainer/VBoxContainer2/Expand
@onready var month: Label = $TextureRect/MarginContainer/VSplitContainer/VBoxContainer2/Month
@onready var previous_page: TextureButton = $TextureRect/HBoxContainer/PreviousPage
@onready var next_page: TextureButton = $TextureRect/HBoxContainer/NextPage

var notes: Array = []
var is_moved_up: bool = false
var tween: Tween
var current_page: int = 1
var max_page: int = 1

# Note: this page_texts has an int key that represents the page index (start from 1)
var page_texts = {}

func _ready() -> void:
	set_month()
	notes.clear()
	for child in v_box_container.get_children():
		notes.append(child)
	
	# Connect the click signal
	texture_rect.gui_input.connect(_on_texture_rect_gui_input)
	
	_toggle_texture_rect_position()

func setup_page(list: Array[Array]):
	var temp_arr = []
	max_page = len(list)
	for i in range(max_page):
		var page_rule = list[i]
		temp_arr = []
		for rule in page_rule:
			var new_note = note.duplicate()
			new_note.text = "[color=#2d2244]" + rule + "[/color]"
			temp_arr.append(new_note)
		page_texts[i+1] = temp_arr
	
	previous_page.hide()
	if max_page == 1:
		next_page.hide()
	
	set_rule_for_current_page(current_page)

func set_rule_for_current_page(current_page):
	var current_page_rule = page_texts[current_page]
	for node in current_page_rule:
		v_box_container.add_child(node)

func make_children(list: Array[String]):
	for rule in list:
		var new_note = note.duplicate()
		new_note.text = "[color=#2d2244]" + rule + "[/color]"
		v_box_container.add_child(new_note)

func _on_texture_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_toggle_texture_rect_position()
		SfxManager.play(SfxManager.paper)

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

func _on_next_page_pressed() -> void:
	handle_page_pressed(1)
	if current_page == max_page:
		next_page.hide()
	previous_page.show()

func _on_previous_page_pressed() -> void:
	handle_page_pressed(-1)
	if current_page == 1:
		previous_page.hide()
	next_page.show()
	
func handle_page_pressed(value: int):
	current_page += (1*value)
	var note_childs = v_box_container.get_children()
	for text in note_childs:
		if text != note:
			v_box_container.remove_child(text)

	set_rule_for_current_page(current_page)
		
