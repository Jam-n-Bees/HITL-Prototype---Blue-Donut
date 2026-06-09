extends RigidBody2D

var detectedPlayer := false
var attractSpeed : float = 0
var playerArea
func _process(delta: float) -> void:
	if (detectedPlayer):
		global_position = global_position.move_toward(playerArea.global_position, delta*400*attractSpeed)
		attractSpeed += 20*delta
		if global_position.distance_squared_to(playerArea.global_position) < 10:
			queue_free()

	if attractSpeed > 5:
		attractSpeed = 5
		
func _on_magnet_range_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		detectedPlayer = true
		playerArea = area
	pass # Replace with function body.
