extends CharacterBody2D

@onready var toggle_timer : Timer = $WarningToggleTimer
@onready var warning_sprite : Sprite2D = $WarningSign
@onready var shuffle : Node2D = $SyncronisedShuffle
@onready var audio_player : AudioStreamPlayer2D = $WarningBlip

@export var flicker_count : int = 4
var flicker_start : int = 0

var warning_sprite_red = load("res://warning_sprites/warning red.png")
var warning_sprite_blue = load("res://warning_sprites/warning blue.png")
var threat = load("res://projectile/cannon_ball.tscn")

var blue : bool = false
var active : bool = false
var triggered : bool = false
# NOTE : false is red, true is blue

func _ready() -> void:
	active = false
	warning_sprite.texture = warning_sprite_red

	
func _process(delta: float) -> void:
	if active && triggered == false:
		toggle_timer.start()
		triggered = true
	
func _physics_process(delta: float) -> void:
	if active:
		move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	active = true
	warning_sprite.visible = true
	#sfx.stream = warning
	#sfx.play()
	pass # Replace with function body.


func _on_warning_toggle_timer_timeout() -> void:
	if flicker_start < flicker_count:
		flicker()
		audio_player.play()
		toggle_timer.start()
	else:
		flicker()
		spawn_threat()
		
func flicker():
	flicker_start += 1
	if flicker_start % 2 != 0:
		warning_sprite.texture = warning_sprite_blue
	if flicker_start % 2 == 0:
		warning_sprite.texture = warning_sprite_red
		
		
func spawn_threat():
	var instance = threat.instantiate()
	get_parent().add_child(instance)
	instance.global_position = self.global_position
	instance.global_position.x += 300
	queue_free()
	
