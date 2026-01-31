extends CharacterBody2D


@export var SPEED = 400.0
@export var player_group = "DummyPlayer"
@export var basic_damage: int = 10
@export var health: int = 3

@onready var player = get_tree().get_first_node_in_group(player_group)

var attacked = false
var player_in_range = false


func _physics_process(_delta: float) -> void:
	var player_direction = (player.global_position - global_position).normalized()
	velocity =  player_direction * SPEED
	move_and_slide()
	if player_direction.x < 0:
		$SlimeAnimation.flip_h = true
		$AttackRange/AttackCollision.position = -abs($AttackRange/AttackCollision.position)
	else:
		$SlimeAnimation.flip_h = false
		$AttackRange/AttackCollision.position = abs($AttackRange/AttackCollision.position)
	if attacked == false and player_in_range == true:
		player.got_damaged(basic_damage)
		attacked = true
		$NormalAttackCooldown.start()


func got_damaged():
	health -= 1
	if health <= 0:
		queue_free()
	$SlimeAnimation.stop()
	$SlimeAnimation.play("hurt")
	await $SlimeAnimation.animation_finished
	$SlimeAnimation.play("idle")


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group(player_group):
		player_in_range = true


func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.is_in_group(player_group):
		player_in_range = false


func _on_normal_attack_cooldown_timeout() -> void:
	attacked = false
