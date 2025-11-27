extends Node

@onready var bgm = preload("res://assets/music/bgm.ogg")
@onready var bgm_rain = preload("res://assets/music/bgm_rain.ogg")

@onready var all_music = [
	bgm,
	bgm_rain
]

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
var current_track: AudioStream = null
var fade_speed := 0.8 # seconds for fade in/out
var fade_tween: Tween = null

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(music_player)
	music_player.bus = "Music"
	music_player.volume_db = -4
	music_player.autoplay = false
	music_player.finished.connect(_on_music_finished)

	MusicManager.play_music(MusicManager.bgm)


func play_music(stream: AudioStream):
	if stream == null:
		return
		
	# If same track already playing do nothing
	if current_track == stream and music_player.playing:
		return
	
	# Cancel previous tween
	if fade_tween:
		fade_tween.kill()

	# Create new tween
	fade_tween = get_tree().create_tween()
	
	var old_volume = music_player.volume_db

	# fade out
	if music_player.playing:
		fade_tween.tween_property(music_player, "volume_db", -40, fade_speed)
		fade_tween.tween_callback(func():
			_m_switch_to(stream)
		)
	else:
		
		_m_switch_to(stream)

func _m_switch_to(stream: AudioStream):
	current_track = stream
	music_player.stop()
	music_player.stream = stream
	music_player.volume_db = -40
	music_player.play()

	# Fade in
	var tween = get_tree().create_tween()
	tween.tween_property(music_player, "volume_db", -4, fade_speed)

func _on_music_finished():
	if current_track:
		music_player.play()

func play_random_music():
	if all_music.size() == 0:
		return
	var i = randi() % all_music.size()
	play_music(all_music[i])

func stop_music():
	if fade_tween:
		fade_tween.kill()
	var tween = get_tree().create_tween()
	tween.tween_property(music_player, "volume_db", -40, fade_speed)
	tween.tween_callback(func():
		music_player.stop()
		current_track = null)
