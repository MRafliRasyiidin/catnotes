extends Control

@onready var fullscreen_checkbox: CheckBox = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Checkbox
@onready var music_slider: HSlider = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer3/HSlider
@onready var sfx_slider: HSlider = $MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer4/HSlider

signal back_options_pressed

func _ready():
	# Initialize settings
	print('hihih', DisplayServer.window_get_mode())
	fullscreen_checkbox.button_pressed = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
	
	# Initialize music volume slider
	var music_bus_idx = AudioServer.get_bus_index("Music")
	if music_bus_idx != -1:
		music_slider.value = AudioServer.get_bus_volume_db(music_bus_idx)
	
	# Initialize SFX volume slider
	var sfx_bus_idx = AudioServer.get_bus_index("SFX")
	if sfx_bus_idx != -1:
		sfx_slider.value = AudioServer.get_bus_volume_db(sfx_bus_idx)
	
	# Populate resolutions
	var current_res = DisplayServer.window_get_size()
	
	# Connect signals
	fullscreen_checkbox.toggled.connect(_on_fullscreen_toggled)
	music_slider.value_changed.connect(_on_music_volume_changed)
	sfx_slider.value_changed.connect(_on_sfx_volume_changed)
 
func _on_fullscreen_toggled(pressed):
	SfxManager.play(SfxManager.click)
	if pressed:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		await get_tree().process_frame
		DisplayServer.window_set_size(Vector2i(1280, 720))
		center_window()
		print("Mode click:", DisplayServer.window_get_mode())
		print("Size click:", DisplayServer.window_get_size())
	fullscreen_checkbox.release_focus()

func _on_resolution_selected(index):
	center_window()

func _on_music_volume_changed(value):
	#SfxManager.play(SfxManager.click)
	var music_bus_idx = AudioServer.get_bus_index("Music")
	if music_bus_idx != -1:
		# If slider is at minimum, mute the audio
		if value == music_slider.min_value:
			AudioServer.set_bus_volume_db(music_bus_idx, -80.0)  # -80 dB is effectively mute
		else:
			AudioServer.set_bus_volume_db(music_bus_idx, value)

func _on_sfx_volume_changed(value):
	var sfx_bus_idx = AudioServer.get_bus_index("SFX")
	if sfx_bus_idx != -1:
		# If slider is at minimum, mute the audio
		if value == sfx_slider.min_value:
			AudioServer.set_bus_volume_db(sfx_bus_idx, -80.0)  # -80 dB is effectively mute
		else:
			AudioServer.set_bus_volume_db(sfx_bus_idx, value)

func center_window():
	var screen_size = DisplayServer.screen_get_size() # Get screen resolution
	var window_size = DisplayServer.window_get_size()  # Get current window size
	if (screen_size != window_size): # if not full screen res
		var new_position = (screen_size - window_size) / 2  # Calculate center position
		DisplayServer.window_set_position(new_position)  # Move window to center
	else:
		DisplayServer.window_set_position(Vector2i(0,0)) # set to top left (windowed fullscreen)
	
func save_settings():
	var config = ConfigFile.new()
	config.set_value("display", "fullscreen", fullscreen_checkbox.button_pressed)
	config.set_value("audio", "music_volume", music_slider.value)
	config.set_value("audio", "sfx_volume", sfx_slider.value)
	config.save("user://settings.cfg")

func load_settings():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		fullscreen_checkbox.button_pressed = config.get_value("display", "fullscreen", false)
		music_slider.value = config.get_value("audio", "music_volume", 0.0)
		sfx_slider.value = config.get_value("audio", "sfx_volume", 0.0)
		
		# Apply the loaded volumes
		var music_bus_idx = AudioServer.get_bus_index("Music")
		if music_bus_idx != -1:
			AudioServer.set_bus_volume_db(music_bus_idx, music_slider.value)
		
		var sfx_bus_idx = AudioServer.get_bus_index("SFX")
		if sfx_bus_idx != -1:
			AudioServer.set_bus_volume_db(sfx_bus_idx, sfx_slider.value)

func _on_back_button_pressed() -> void:
	SfxManager.play(SfxManager.click)
	emit_signal("back_options_pressed")
	self.hide()
