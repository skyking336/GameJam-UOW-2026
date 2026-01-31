extends Weapon

func fire():
	var shuriken = projectile_scene.instantiate()
	shuriken.position = position
	shuriken.linear_velocity = (get_global_mouse_position() - global_position).normalized() * projectile_speed

	get_tree().get_first_node_in_group("Player").add_child(shuriken)
