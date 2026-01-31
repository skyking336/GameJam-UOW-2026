extends RigidBody2D


func _on_lifetime_timer_timeout() -> void:
	queue_free()
