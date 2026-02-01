extends CharacterBody2D
class_name Player

enum Ability {
	FIRE,
	ICE,
	POISON
}

@export var SPEED: float = 200.0
@export var max_health: int = 100
var health: int = max_health
var experience: int = 0
var invincible = false
var is_moving = false

var current_level: int = 1
var level_up_threshold: int = 200
var abilities: Array[Ability] = [Ability.FIRE, Ability.ICE]

signal hp_update(health: int)
signal max_hp_update(max_health: int)
signal exp_update(experience: int)
signal exp_threshold_updated(new_threshold: int)
signal ability_updated(abilities: Array[Ability])


func _ready() -> void:
	max_hp_update.emit(max_health)
	hp_update.emit(health)
	exp_update.emit(experience)
	exp_threshold_updated.emit(level_up_threshold)
	ability_updated.emit(abilities)


func _physics_process(_delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction != Vector2.ZERO:
		$AnimatedSprite2D.play("walking")
		if input_direction == Vector2.RIGHT:
			$AnimatedSprite2D.flip_h = false
		if input_direction == Vector2.LEFT:
			$AnimatedSprite2D.flip_h = true
		velocity = input_direction * SPEED
		move_and_slide()
	else:
		$AnimatedSprite2D.play("idle")

func got_damaged(damage: int) -> void:
	if invincible:
		return
	health -= damage
	hp_update.emit(health)
	if health <= 0:
		die()


func die() -> void:
	print("Player has died")


func inc_experience(ex: int) -> void:
	experience += ex
	if experience >= level_up_threshold:
		current_level += 1
		level_up_threshold *= 1.5
		experience = 0
		exp_threshold_updated.emit(level_up_threshold)

	if current_level == 5:
		invincible = true
		print("phase 1 completed")
		#here need to make the logic for converting enemy into player

	if current_level == 10:
		invincible = true
		print("phase 2 completed")

	if current_level == 15:
		invincible = true
		print("phase 3 completed")

	exp_update.emit(experience)


func _on_experience_system_exp_threshold_updated(new_threshold: int) -> void:
	exp_threshold_updated.emit(new_threshold)
