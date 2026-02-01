extends Node2D

var pause_times
var target_name


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_scene()


func pause_scene():
	get_tree().paused = not get_tree().paused


func set_target_name(enemy_name):
	target_name = enemy_name


func _on_boss_defeated(_exp_value: int) -> void:
	print("Boss defeated! You win!")
	get_tree().paused = true
