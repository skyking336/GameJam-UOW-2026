extends CharacterBody2D


@export var SPEED = 400.0
@export var player_group = "DummyPlayer"
@export var basic_damage: int = 10
@export var health: int = 3
@export var exp_value: int = 20

@onready var player = get_tree().get_first_node_in_group(player_group)

var attacked = false
var player_in_range = false

var Alive = true

signal on_died(exp_value: int)


func _physics_process(_delta: float) -> void:
	if Alive == true:
		var player_direction = (player.global_position - global_position).normalized()
		velocity =  player_direction * SPEED
		move_and_slide()
		if player_direction.x < 0:
			$EnemyAnimation.flip_h = true
			$AttackRange/AttackCollision.position = -abs($AttackRange/AttackCollision.position)
		else:
			$EnemyAnimation.flip_h = false
			$AttackRange/AttackCollision.position = abs($AttackRange/AttackCollision.position)
		if attacked == false and player_in_range == true:
			player.got_damaged(basic_damage)
			attacked = true
			$NormalAttackCooldown.start()
			
func fade_out_on_dying():
	var tween = get_tree().create_tween()
	tween.tween_property($EnemyAnimation, "modulate", Color.RED, 0.1)
	tween.tween_property($EnemyAnimation, "scale", Vector2(), 0.1)
	tween.tween_callback(queue_free)

func got_damaged():
	health -= 1
	if health <= 0:
		on_died.emit(exp_value)
		Alive = false
		fade_out_on_dying()
		player.inc_experience(exp_value)
			
	$EnemyAnimation.stop()
	$EnemyAnimation.play("hurt")
	await $EnemyAnimation.animation_finished
	$EnemyAnimation.play("idle")


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group(player_group):
		player_in_range = true


func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.is_in_group(player_group):
		player_in_range = false


func _on_normal_attack_cooldown_timeout() -> void:
	attacked = false
