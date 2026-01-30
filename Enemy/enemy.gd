extends CharacterBody2D


@export var SPEED = 1000.0
@export var player_group = "DummyPlayer"
@onready var player = get_tree().get_first_node_in_group(player_group)

var attacked = false
var player_in_range = false

func _ready() -> void:
	if player != null:
		print("there is player")
		print(player)
	else:
		print("theres nothingggggg")

func _physics_process(delta: float) -> void:
	var player_direction = (player.position - position).normalized()
	velocity =  player_direction * SPEED * delta
	move_and_slide()
	if player_direction.x < 0:
		$SlimeAnimation.flip_h = true
		$AttackRange/AttackCollision.position = -abs($AttackRange/AttackCollision.position)
	else:
		$SlimeAnimation.flip_h = false
		$AttackRange/AttackCollision.position = abs($AttackRange/AttackCollision.position)
	if attacked == false and player_in_range == true:
		player.got_damaged()
		attacked = true
		$NormalAttackCooldown.start()

func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group(player_group):
		player_in_range = true

func _on_normal_attack_cooldown_timeout() -> void:
	attacked = false
