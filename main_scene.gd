extends Node2D

var pause_times

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		pause_scene()
	

func pause_scene():
	get_tree().paused = not get_tree().paused
