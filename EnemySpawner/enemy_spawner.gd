extends Node2D

@export var player_group = "Player"
@export var enemies : Array[PackedScene]
@export var final_boss_scene: PackedScene
#@export var enemynames : Dictionary [String,PackedScene]

@export var normal_enemy_spawn_curve : Curve
var normal_enemy_amount

@export var speedy_spawn_curve : Curve
var speedy_amount

@export var buffy_spawn_curve : Curve
var buffy_amount

@export var fire_mage_spawn_curve : Curve
var fire_mage_amount

@export var ice_mage_spawn_curve : Curve
var ice_mage_amount

@export var boss_spawn_level_treshold : int = 5

@onready var player = get_tree().get_first_node_in_group(player_group)
@onready var main_scene = get_tree().get_first_node_in_group("MainScene")

var rng = RandomNumberGenerator.new()

func _ready():
	$NormalEnemySpawnCooldown.start()
	$SpeedySpawnCooldown.start()
	$BuffySpawnCooldown.start()
	$FireMageSpawnCooldown.start()
	$IceMageSpawnCooldown.start()

#---------------------------------------------------------------------------------------------------------------------------------------------
#This part is only for normal enemy

var max_normal = 20
var min_normal = 4

func _on_normal_enemy_spawn_cooldown_timeout() -> void:
	spawn_normal_wave()

func spawn_normal_wave():
	normal_enemy_amount = random_normal_enemy_amount()
	for i in normal_enemy_amount:
		spawn_normal_enemy()

func spawn_normal_enemy():
	var enemy = enemies[0].instantiate()
	$Path2D/MobSpawnArea.progress_ratio = randf()
	enemy.global_position = $Path2D/MobSpawnArea.global_position
	#Hard Coded Part: new added child must be staright under the main scene
	if enemy == null:
		print("theres nothing in enemy")
	else:
		main_scene.add_child(enemy)
		enemy.broadcast_character_name.connect(main_scene.set_target_name)


func random_normal_enemy_amount():
	var random_spawn_amount = randf() # Pick a spot on the X axis of the curve
	var weight = normal_enemy_spawn_curve.sample(random_spawn_amount) # Get the Y value (the "rarity")
	# Map the result to your 4-20 range
	return int(lerp(min_normal, max_normal, random_spawn_amount * weight))
#------------------------------------------------------------------------------------------------------------------------

#This part is for spawning speedy

var max_speedy = 4
var min_speedy = 1

func _on_speedy_spawn_cooldown_timeout() -> void:
	spawn_speedy_wave()

func spawn_speedy_wave():
	speedy_amount = random_speedy_amount()
	for i in speedy_amount:
		spawn_speedy()

func spawn_speedy():
	var enemy = enemies[1].instantiate()
	$Path2D/MobSpawnArea.progress_ratio = randf()
	enemy.global_position = $Path2D/MobSpawnArea.global_position
	#Hard Coded Part: new added child must be staright under the main scene
	if enemy == null:
		print("theres nothing in enemy")
	else:
		main_scene.add_child(enemy)
		enemy.broadcast_character_name.connect(main_scene.set_target_name)

func random_speedy_amount():
	var random_spawn_amount = randf() # Pick a spot on the X axis of the curve
	var weight = speedy_spawn_curve.sample(random_spawn_amount) # Get the Y value (the "rarity")
	# Map the result to your 4-20 range
	return int(lerp(min_speedy, max_speedy, random_spawn_amount * weight))

#------------------------------------------------------------------------------------------------------------------------

#This part is for spawning Buffy

var max_buffy = 3
var min_buffy = 1

func _on_buffy_spawn_cooldown_timeout() -> void:
	spawn_buffy_wave()

func spawn_buffy_wave():
	buffy_amount = random_buffy_amount()
	for i in buffy_amount:
		spawn_buffy()

func spawn_buffy():
	var enemy = enemies[2].instantiate()
	$Path2D/MobSpawnArea.progress_ratio = randf()
	enemy.global_position = $Path2D/MobSpawnArea.global_position
	if enemy == null:
		print("theres nothing in enemy")
	else:
		main_scene.add_child(enemy)
		enemy.broadcast_character_name.connect(main_scene.set_target_name)

func random_buffy_amount():
	var random_spawn_amount = randf() # Pick a spot on the X axis of the curve
	var weight = buffy_spawn_curve.sample(random_spawn_amount) # Get the Y value (the "rarity")
	# Map the result to your 4-20 range
	return int(lerp(min_buffy, max_buffy, random_spawn_amount * weight))

#------------------------------------------------------------------------------------------------------------------------

#This part is for spawning fire mage

var max_fire_mage = 3
var min_fire_mage = 1

func _on_fire_mage_spawn_cooldown_timeout() -> void:
	spawn_fire_mage_wave()

func spawn_fire_mage_wave():
	fire_mage_amount = random_fire_mage_amount()
	for i in fire_mage_amount:
		spawn_fire_mage()

func spawn_fire_mage():
	var enemy = enemies[3].instantiate()
	$Path2D/MobSpawnArea.progress_ratio = randf()
	enemy.global_position = $Path2D/MobSpawnArea.global_position
	if enemy == null:
		print("theres nothing in enemy")
	else:
		main_scene.add_child(enemy)
		enemy.broadcast_character_name.connect(main_scene.set_target_name)

func random_fire_mage_amount():
	var random_spawn_amount = randf() # Pick a spot on the X axis of the curve
	var weight = fire_mage_spawn_curve.sample(random_spawn_amount) # Get the Y value (the "rarity")
	# Map the result to your 4-20 range
	return int(lerp(min_fire_mage, max_fire_mage, random_spawn_amount * weight))

#------------------------------------------------------------------------------------------------------------------------

#This part is for spawning ice mage

var max_ice_mage = 3
var min_ice_mage = 1

func _on_ice_mage_spawn_cooldown_timeout() -> void:
	spawn_ice_mage_wave()

func spawn_ice_mage_wave():
	ice_mage_amount = random_ice_mage_amount()
	for i in ice_mage_amount:
		spawn_ice_mage()

func spawn_ice_mage():
	var enemy = enemies[4].instantiate()
	$Path2D/MobSpawnArea.progress_ratio = randf()
	enemy.global_position = $Path2D/MobSpawnArea.global_position
	if enemy == null:
		print("theres nothing in enemy")
	else:
		main_scene.add_child(enemy)
		enemy.broadcast_character_name.connect(main_scene.set_target_name)

func random_ice_mage_amount():
	var random_spawn_amount = randf() # Pick a spot on the X axis of the curve
	var weight = ice_mage_spawn_curve.sample(random_spawn_amount) # Get the Y value (the "rarity")
	# Map the result to your 4-20 range
	return int(lerp(min_ice_mage, max_ice_mage, random_spawn_amount * weight))

#------------------------------------------------------------------------------------------------------------------------
# Boss spawing


func _on_player_exp_level_updated(_new_threshold: int, new_level: int) -> void:
	if new_level == boss_spawn_level_treshold:
		spawn_boss()


func spawn_boss():
	var final_boss = final_boss_scene.instantiate()
	$Path2D/MobSpawnArea.progress_ratio = randf()
	final_boss.global_position = $Path2D/MobSpawnArea.global_position
	if final_boss == null:
		print("theres nothing in final_boss")
	else:
		call_deferred("_add_boss_to_scene", final_boss)
		final_boss.broadcast_character_name.connect(main_scene.set_target_name)
		final_boss.on_died.connect(main_scene._on_boss_defeated)

func _add_boss_to_scene(final_boss):
	main_scene.add_child(final_boss)
