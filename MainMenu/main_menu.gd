extends CanvasLayer

@export var main_scene: PackedScene

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(main_scene)


func _on_exit_button_pressed() -> void:
	get_tree().quit()
