extends Node2D

@export var lvl_up : PackedScene
@export var exp_up : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		child.hide()
		
var value = 1

func _on_player_exp_up() -> void:
	var new_particle = exp_up.instantiate()
	new_particle.position = position
	add_child(new_particle)

func _on_player_lvl_up() -> void:
	var new_particle = lvl_up.instantiate()
	new_particle.position = position
	add_child(new_particle)
