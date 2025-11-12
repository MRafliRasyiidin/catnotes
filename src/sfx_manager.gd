extends Node

# Preload or load your SFX here
@onready var click = preload("res://assets/sfx/click.mp3")
@onready var paper = preload("res://assets/sfx/paper.mp3")
@onready var tear = preload("res://assets/sfx/tear.mp3")
@onready var hiss = preload("res://assets/sfx/hiss.mp3")
@onready var pillows = [
	preload("res://assets/sfx/pillow_1.mp3"),
	preload("res://assets/sfx/pillow_2.mp3")
]
@onready var meows = [
	#preload("res://assets/sfx/meow_1.mp3"),
	preload("res://assets/sfx/meow_2.mp3"), #Buat Choco
	preload("res://assets/sfx/meow_3.mp3"),
	preload("res://assets/sfx/meow_4.mp3"),
	preload("res://assets/sfx/meow_5.mp3"),
	preload("res://assets/sfx/meow_6.mp3"),
	preload("res://assets/sfx/meow_7.mp3")
]

var _last_meow_indices: Array = []

func _ready():
	# No need for a single player now — each sound will use its own temporary AudioStreamPlayer
	pass

# Play any sound (creates a temporary player that deletes itself)
func play(sound: AudioStream):
	if not sound:
		return
	var p = AudioStreamPlayer.new()
	add_child(p)
	p.stream = sound
	p.bus = "SFX"
	p.play()
	
	# Automatically free the player after the sound ends
	p.finished.connect(func(): p.queue_free())

# Return a random sound from an array
func get_random_sfx(array: Array) -> AudioStream:
	if array.is_empty():
		return null
	return array[randi() % array.size()]

# Play a random meow (won’t repeat the last two)
func play_random_meow():
	if meows.is_empty():
		return
	
	var new_index = randi() % meows.size()
	var tries = 0
	
	while new_index in _last_meow_indices and tries < 10:
		new_index = randi() % meows.size()
		tries += 1
	
	_last_meow_indices.append(new_index)
	if _last_meow_indices.size() > 2:
		_last_meow_indices.pop_front()
	
	play(meows[new_index])
