extends Node2D

var pause_times
var target_name
var target_tree_name
var player_evolving = false
@onready var player = get_tree().get_first_node_in_group("Player")

signal broadcast_player_is_evolving
signal broadcast_player_not_evolving

func _ready():
	if player == null:
		print("mainscene did not found player")
		return


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_scene()
	if player_evolving == true:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if target_name == null:
				print("player didnt select")
			else:
				player_evolving = false
				player.evolve(target_name)
				pause_scene()

func pause_scene():
	get_tree().paused = not get_tree().paused

func set_target_name(enemy_name):
	target_name = enemy_name

func set_name_cancel():
	target_name = null

func set_target_tree_name(enemy_tree_name):
	target_tree_name = enemy_tree_name
	

func set_target_tree_name_cancel():
	target_tree_name = null



func evolve_player():
	player_evolving = true
	broadcast_player_is_evolving.emit()


func game_won():
	$MainUI.show_win_screen()


func game_lost():
	$MainUI.show_lose_screen()


func stop_game():
	get_tree().paused = true


func _on_boss_defeated(_exp_value: int) -> void:
	print("Boss defeated! You win!")
	game_won()


func _on_player_player_died() -> void:
	print("Player died! You lose!")
	game_lost()
