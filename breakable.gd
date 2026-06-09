extends RigidBody2D

var effect = preload("res://default_explosion.tscn")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player") or area.is_in_group("PlayerAttackBox"):
		var instance = effect.instantiate()
		get_parent().add_child(instance)
		instance.global_position = self.global_position
		queue_free()
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") or body.is_in_group("PlayerAttackBox"):
		var instance = effect.instantiate()
		get_parent().add_child(instance)
		instance.global_position = self.global_position
		queue_free()
	
