extends CharacterBody2D


var off_screen = false

func _physics_process(delta: float) -> void:
	velocity.x = -4000
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	off_screen = true
	


func _on_audio_stream_player_2d_finished() -> void:
	if off_screen:
		queue_free()
