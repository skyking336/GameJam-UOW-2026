extends Node2D

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

func set_idle(current : String):
	var animation = get_node(current)
	animation.play("idle")

func set_flip_h(value : bool , current : String):
	var animation = get_node(current)
	animation.flip_h = value
