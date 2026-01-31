extends CharacterBody2D

@export var SPEED: float = 200.0
@export var health: int = 100
var experience: int = 0
var invincible = false


func _physics_process(_delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	move_and_slide()


func got_damaged(damage: int) -> void:
	if invincible:
		return
	health -= damage
	print("player health left:" + str(health))


func inc_experience(ex: int) -> void:
	experience += ex
	$ExperienceSystem.check_level_up(experience)


func _on_experience_system_signal_invincible() -> void:
	invincible = true
