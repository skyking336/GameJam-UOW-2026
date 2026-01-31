extends Node2D

@export var player_group = "DummyPlayer"
@export var player_object_name = "Player"

@export var Enemy1 : PackedScene
@export var Enemy2 : PackedScene

@onready var player = get_tree().get_first_node_in_group(player_group)

func _ready():
	$MobSpawnCooldown.start()
	
func _process(delta):
	global_position = player.global_position

func _on_mob_spawn_cooldown_timeout() -> void:
	var enemy = Enemy1.instantiate()
	$Path2D/MobSpawnArea.progress_ratio = randf()
	$EnemySpawnLocation.position = $Path2D/MobSpawnArea.position
	enemy.position = $Path2D/MobSpawnArea.position
	get_parent().add_child(enemy)
	print(str($Path2D/MobSpawnArea.position))
