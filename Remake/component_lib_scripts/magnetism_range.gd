extends Area2D

var detected_player := false
var attract_speed : float = 0
var player_area
func _process(delta: float) -> void:
	if (detected_player):
		# Below is kinda trash code. Never really want to be doing "Get Parent" but with current time frames, this is the quickest way to do it.
		# A better way would be to pass self with a signal emitted to the actual page node, which as the root for this collectable would navigate towards the player.
		get_parent().global_position = global_position.move_toward(player_area.global_position, delta*400*attract_speed)
		attract_speed += 20*delta

	if attract_speed > 5:
		attract_speed = 5
		


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		detected_player = true
		player_area = area
