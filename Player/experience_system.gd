extends Node

var current_level = 1
var level_up_threshold = 200

signal signal_invincible

func check_level_up(exp : int):
	if exp >= level_up_threshold:
		print("levelup")
		current_level += 1
		level_up_threshold *= 1.5
		print(str(level_up_threshold))
	
	if current_level == 5:
		signal_invincible.emit()
		print("phase 1 completed")
		#here need to make the logic for converting enemy into player
		
		
	if current_level == 10:
		signal_invincible.emit()
		print("phase 2 completed")
		
	if current_level == 15:
		signal_invincible.emit()
		print("phase 3 completed")
	
		
		
