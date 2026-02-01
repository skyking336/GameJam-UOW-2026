extends Weapon


func fire() -> void:
	var iceball = projectile_scene.instantiate()
	iceball.position = position
	iceball.rotation = (get_global_mouse_position() - global_position).angle()
	iceball.linear_velocity = (get_global_mouse_position() - global_position).normalized() * projectile_speed

	get_tree().get_first_node_in_group("Player").add_child(iceball)
