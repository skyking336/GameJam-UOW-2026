extends Node2D
class_name Weapon

@export var projectile_scene: PackedScene
@export var projectile_speed: float = 500.0

func fire() -> void:
	pass

func _on_timer_timeout() -> void:
	fire()
