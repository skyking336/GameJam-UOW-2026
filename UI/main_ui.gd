extends CanvasLayer

@export var empty_ability_icon: Texture2D
@export var fire_ability_icon: Texture2D
@export var ice_ability_icon: Texture2D
@export var poison_ability_icon: Texture2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = not get_tree().paused
		%PausePanel.visible = get_tree().paused


func _on_player_hp_update(health: int) -> void:
	%HPLevel.value = health


func _on_player_exp_update(experience: int) -> void:
	%ExpLevel.value = experience


func _on_player_exp_threshold_updated(new_threshold: int) -> void:
	%ExpLevel.max_value = new_threshold


func _on_player_ability_updated(abilities: Array[Player.Ability]) -> void:
	var ability_icons = [%AbilityIcon1, %AbilityIcon2, %AbilityIcon3]
	for i in range(ability_icons.size()):
		if i < abilities.size():
			match abilities[i]:
				Player.Ability.FIRE:
					ability_icons[i].texture = fire_ability_icon
				Player.Ability.ICE:
					ability_icons[i].texture = ice_ability_icon
				Player.Ability.POISON:
					ability_icons[i].texture = poison_ability_icon
		else:
			ability_icons[i].texture = empty_ability_icon
