extends CharacterBody2D
class_name Enemy


@export var SPEED = 400.0
@export var player_group = "Player"
@export var basic_damage: int = 10
@export var health: int = 3
@export var exp_value: int = 20

@onready var player = get_tree().get_first_node_in_group(player_group)

@export var  character_name = "Enemy"
signal broadcast_character_name(name : String)
signal name_broadcast_cancel

signal broadcast_self_name(name : String)
signal broadcast_self_name_cancel


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
	tween.tween_property($EnemyAnimation, "modulate", Color.RED, 0.2)
	tween.tween_property($EnemyAnimation, "modulate:a", 0.0 , 0.5)
	tween.tween_callback(queue_free)

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


func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group(player_group):
		player_in_range = true

func _on_attack_range_body_exited(body: Node2D) -> void:
	if body.is_in_group(player_group):
		player_in_range = false

func _on_normal_attack_cooldown_timeout() -> void:
	attacked = false

func _on_hit_boxes_mouse_entered() -> void:
	print(self.name)
	broadcast_self_name.emit(str(self.name))
	broadcast_character_name.emit(character_name)
	
func _on_hit_boxes_mouse_exited() -> void:
	broadcast_self_name_cancel.emit()
	name_broadcast_cancel.emit()
