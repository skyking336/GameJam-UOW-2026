extends Weapon

func fire() -> void:
	var fireball = projectile_scene.instantiate()
	fireball.position = position
	fireball.rotation = (get_global_mouse_position() - global_position).angle()
	fireball.linear_velocity = (get_global_mouse_position() - global_position).normalized() * projectile_speed

	get_tree().get_first_node_in_group("Player").add_child(fireball)
