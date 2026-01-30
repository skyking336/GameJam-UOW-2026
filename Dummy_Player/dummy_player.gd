extends CharacterBody2D


@export var SPEED = 300.0

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("UP"):
		position += SPEED * Vector2.UP * delta
	
	if Input.is_action_pressed("DOWN"):
		position += SPEED * Vector2.DOWN * delta
	
	if Input.is_action_pressed("LEFT"):
		position += SPEED * Vector2.LEFT * delta
	
	if Input.is_action_pressed("RIGHT"):
		position += SPEED * Vector2.RIGHT * delta

func got_damaged():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.play("hurt")
	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("default")
	
