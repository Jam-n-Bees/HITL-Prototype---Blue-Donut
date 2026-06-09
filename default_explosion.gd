extends GPUParticles2D

func _ready() -> void:
	restart()
	await get_tree().create_timer(0.4).timeout
	queue_free()
