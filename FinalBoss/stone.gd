extends RigidBody2D

var damage = 30

func _on_lifetime_timer_timeout() -> void:
	queue_free()

func _on_area_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")) == true:
		body.got_damaged(damage)
		queue_free()
