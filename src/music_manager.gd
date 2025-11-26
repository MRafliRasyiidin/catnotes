extends Node

# 🎶 Preload your music tracks here
@onready var bgm = preload("res://assets/music/bgm.ogg")

# You can access them as an array too
@onready var all_music = [
	bgm
]

# Internal Audio Player
@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
var current_track: AudioStream = null

func _ready():
	add_child(music_player)
	music_player.bus = "Music" # optional audio bus
	music_player.autoplay = false
	music_player.volume_db = -4
	music_player.finished.connect(_on_music_finished)
	MusicManager.play_music(MusicManager.bgm)

# ▶️ Play a specific track
func play_music(stream: AudioStream):
	if stream == null:
		return
	
	# if it's already playing the same track, skip
	if current_track == stream and music_player.playing:
		return
	
	current_track = stream
	music_player.stop()
	music_player.stream = stream
	music_player.play()


func _on_music_finished():
	if current_track:
		music_player.play()


func play_random_music():
	if all_music.size() == 0:
		return
	var random_index = randi_range(0, all_music.size() - 1)
	play_music(all_music[random_index])


func stop_music():
	music_player.stop()
	current_track = null
