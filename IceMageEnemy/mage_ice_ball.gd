extends RigidBody2D
var damage = 10

func _on_lifetime_timer_timeout() -> void:
	queue_free()
	
func _on_area_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Player")) == true:
		print("element has hit the player")
		body.got_damaged(damage)
	queue_free()
