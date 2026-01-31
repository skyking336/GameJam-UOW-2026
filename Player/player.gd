extends CharacterBody2D

@export var SPEED: float = 200.0
@export var health: int = 100
var experience: int = 0
var invincible = false
var is_moving = false

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
	print("player health left:" + str(health))

func inc_experience(ex: int) -> void:
	print("Gained " + str(ex) + " experience!")
	experience += ex
	$ExperienceSystem.check_level_up(experience)

func _on_experience_system_signal_invincible() -> void:
	invincible = true
