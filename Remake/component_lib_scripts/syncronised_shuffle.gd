extends Node2D

@export var level_data_r : LevelData
var max_speed_modifier : float = 550

var player_modifier : float 
var moving : bool = false

func _ready() -> void:
	get_parent().velocity.x = level_data_r.base_velocity
	#player_modifier = clampf(player_modifier, -max_speed_modifier, +max_speed_modifier)
	

func _physics_process(delta: float) -> void:
	get_parent().velocity.x = level_data_r.base_velocity + player_modifier
	
	if !moving && player_modifier != 0:
		player_modifier = move_toward(player_modifier, 0, 40)
	
	if player_modifier > max_speed_modifier:
		player_modifier = max_speed_modifier
	if player_modifier < -max_speed_modifier:
		player_modifier = -max_speed_modifier
