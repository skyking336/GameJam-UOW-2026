extends CharacterBody2D

@export var SPEED: float = 200.0
@export var health: int = 100


func _physics_process(_delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	move_and_slide()


func got_damaged(damage: int) -> void:
	health -= damage
