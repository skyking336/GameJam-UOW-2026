extends Enemy

@export var rock_scene : PackedScene
@export var projectile_speed: float = 400.0


func _on_stone_attack_timer_timeout() -> void:
	var stone = rock_scene.instantiate()
	stone.global_position = global_position + Vector2(0, -10)
	stone.linear_velocity = (player.global_position - global_position).normalized() * projectile_speed
	print("Rock thrown")
	get_tree().get_first_node_in_group("MainScene").add_child(stone)


func got_damaged():
	if Alive == true:
		health -= 1
		if health <= 0:
			$HitBoxes/AttackCollision.set_deferred("disabled", true)
			on_died.emit(exp_value)
			Alive = false
			fade_out_on_dying()
			player.inc_experience(exp_value)

		$EnemyAnimation.stop()
		$EnemyAnimation.play("hurt")
		await $EnemyAnimation.animation_finished
		$EnemyAnimation.play("idle")
