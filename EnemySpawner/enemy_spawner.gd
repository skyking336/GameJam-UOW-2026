extends Node2D

@export var player_group = "Player"
@export var enemies : Array[PackedScene]

@onready var player = get_tree().get_first_node_in_group(player_group)

func _ready():
	$MobSpawnCooldown.start()

func _process(_delta):
	global_position = player.global_position

func _on_mob_spawn_cooldown_timeout() -> void:
	var enemy = enemies[0].instantiate()
	$Path2D/MobSpawnArea.progress_ratio = randf()
	enemy.position = $Path2D/MobSpawnArea.position
	get_parent().add_child(enemy)
	enemy.on_died.connect(player.inc_experience)
