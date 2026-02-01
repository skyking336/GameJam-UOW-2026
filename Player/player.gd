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
var is_hurt = false

var current_level: int = 1
var level_up_threshold: int = 200
var abilities: Array[Ability] = [Ability.FIRE, Ability.ICE]

signal hp_update(health: int)
signal max_hp_update(max_health: int)
signal exp_update(experience: int)
signal exp_level_updated(new_threshold: int, new_level: int)
signal ability_updated(abilities: Array[Ability])

var animation = ["Enemy", "Speedy", "Buffy", "FireMage", "IceMage"]
var current_animation = animation[0]
signal change_to_walking(current :String)
signal change_to_hurt(current :String)
signal change_to_idle(current :String)
signal flip_h(value : bool, current :String)
signal hide_no_using(current :String)

signal spawn_smoke

@onready var main_scene = get_tree().get_first_node_in_group("MainScene")

func _ready() -> void:
	hide_no_using.emit(current_animation)
	max_hp_update.emit(max_health)
	hp_update.emit(health)
	exp_update.emit(experience)
	exp_level_updated.emit(level_up_threshold, current_level)
	ability_updated.emit(abilities)
	$Mask.hide()
	
	if main_scene == null:
		print("main scene wasnt found")
		return
		
func _physics_process(_delta: float) -> void:
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction != Vector2.ZERO:
		if is_hurt == false:
			change_to_walking.emit(current_animation)
		if input_direction == Vector2.RIGHT:
			flip_h.emit(false,current_animation)
		if input_direction == Vector2.LEFT:
			flip_h.emit(true,current_animation)
		velocity = input_direction * SPEED
		move_and_slide()
	elif is_hurt == false:
		change_to_idle.emit(current_animation)



func got_damaged(damage: int) -> void:
	if invincible:
		return
	health -= damage
	is_hurt = true
	change_to_hurt.emit(current_animation)
	hp_update.emit(health)
	if health <= 0:
		die()


func die() -> void:
	print("Player has died")

var phase_1_completion = false
var phase_2_completion = false
var phase_3_completion = false

signal exp_up
signal lvl_up
func inc_experience(ex: int) -> void:
	experience += ex
	exp_up.emit()
	if experience >= level_up_threshold:
		lvl_up.emit()
		current_level += 1
		level_up_threshold *= 1.2
		experience = 0
		exp_level_updated.emit(level_up_threshold, current_level)

	if current_level == 5:
		if phase_1_completion == false:
			invincible = true
			print("phase 1 completed")
			main_scene.pause_scene()
			main_scene.evolve_player()
		phase_1_completion = true

	if current_level == 10:
		if phase_2_completion == false:
			invincible = true
			print("phase 2 completed")
			main_scene.pause_scene()
			main_scene.evolve_player()
		phase_2_completion = true

	if current_level == 15:
		if phase_3_completion == false:
			invincible = true
			print("phase 3 completed")
			main_scene.pause_scene()
			main_scene.evolve_player()
		phase_3_completion = true

	exp_update.emit(experience)

func _on_experience_system_exp_threshold_updated(new_threshold: int) -> void:
	exp_level_updated.emit(new_threshold)

func _on_animation_system_hurt_animation_finished() -> void:
	is_hurt = false
	
