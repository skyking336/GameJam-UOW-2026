extends RigidBody2D


func _on_lifetime_timer_timeout() -> void:
	queue_free()

func _on_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var target
	if area.get_parent() == null:
		print("no parents in the object that shuriken hit")
	else:
		target = area.get_parent()
	if (target.is_in_group("Enemies")) == true:
		target.got_damaged()
	queue_free()
