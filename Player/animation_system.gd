extends Node2D

signal hurt_animation_finished

func hide_animation(current:String):
	for child in get_children():
		if child.name != current:
			child.stop()
			child.hide()

func set_walking(current : String):
	var animation = get_node(current)
	animation.play("walking")

func set_hurt(current : String):
	var animation = get_node(current)
	animation.play("hurt")
	await animation.animation_finished
	hurt_animation_finished.emit()

func set_idle(current : String):
	var animation = get_node(current)
	animation.play("idle")

func set_flip_h(value : bool , current : String):
	var animation = get_node(current)
	animation.flip_h = value
