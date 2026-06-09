extends Area2D

signal collected_page




var detected_player := false
var player_area

func _process(delta: float) -> void:
	if (detected_player):
		await get_tree().create_timer(0.1).timeout 
		emit_signal("collected_page")
		get_parent().queue_free()
		



func _on_area_entered(area: Area2D) -> void:
		if area.is_in_group("Player"):
			detected_player = true
			player_area = area
