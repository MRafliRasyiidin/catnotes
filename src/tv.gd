extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var togglable: bool = false

@onready var tv_on: bool = false
var is_hovered: bool = false


func _ready() -> void:
	GlobalState.tv_on = tv_on

func _process(delta):
	_check_hover()


func _check_hover():
	if !togglable: return
	
	var mouse_pos = get_global_mouse_position()
	var local_mouse = sprite_2d.to_local(mouse_pos)

	var hovering = sprite_2d.get_rect().has_point(local_mouse)

	if hovering and !is_hovered:
		is_hovered = true
		if tv_on:
			sprite_2d.frame = 3
		else:
			sprite_2d.frame = 2
		print("TV hovered")
		# TODO: trigger hover visual indicator here
		
	elif !hovering and is_hovered:
		is_hovered = false
		if tv_on:
			sprite_2d.frame = 1
		else:
			sprite_2d.frame = 0
		print("TV unhovered")
		# TODO: disable hover visual indicator here


func _input(event):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.pressed:
		if is_hovered:
			_toggle_tv()


func _toggle_tv():
	if !togglable: return
	
	SfxManager.play(SfxManager.click)
	
	tv_on = !tv_on
	GlobalState.tv_on = tv_on
	if tv_on:
		print("TV turned ON")
		sprite_2d.frame = 1
		if animation_player:
			animation_player.play_backwards("turn_on")
	else:
		print("TV turned OFF")
		sprite_2d.frame = 0
		if animation_player:
			animation_player.stop()
