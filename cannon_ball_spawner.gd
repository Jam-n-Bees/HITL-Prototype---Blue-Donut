extends CharacterBody2D

@onready var sfx : AudioStreamPlayer = $AudioStreamPlayer
@onready var sprite := $Sprite2D

var cannonball = preload("res://cannon_ball.tscn")

var colour_toggle := false

var active := false
var warning = preload("res://audio/snd_mtt_prebomb.wav")
var explosion = preload("res://audio/snd_bombsplosion.wav")

var red_warning := preload("res://warning_sprites/warning red.png")
var blue_warning := preload("res://warning_sprites/warning blue.png")

var soundFinishedAmount = 1

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if active:
		velocity.x = 700
		move_and_slide()
	
func _process(delta: float) -> void:
	if colour_toggle:
		sprite.texture = blue_warning
	else:
		sprite.texture = red_warning
	

func _on_audio_stream_player_finished() -> void:
	match soundFinishedAmount:
		1:
			colour_toggle = !colour_toggle
			soundFinishedAmount += 1
			await get_tree().create_timer(0.09).timeout
			sfx.play()
		2:
			colour_toggle = !colour_toggle
			soundFinishedAmount += 1
			await get_tree().create_timer(0.09).timeout
			sfx.play()
			colour_toggle = !colour_toggle
		3:
			await get_tree().create_timer(0.09).timeout
			colour_toggle = !colour_toggle
			sprite.visible = false
			sfx.stream = explosion
			sfx.play()
			soundFinishedAmount += 1
			var instance = cannonball.instantiate()
			get_parent().add_child(instance)
			instance.global_position = self.global_position
			instance.global_position.x += 300
		4:
			
			pass


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	active = true
	sprite.visible = true
	sfx.stream = warning
	sfx.play()
