extends CharacterBody2D


@export var player_group = "DummyPlayer"
@export var player_object_name = "Player"
@onready var player = get_tree().get_first_node_in_group(player_group)

@export var SPEED = 50.0
@export var health = 5
@export var damage = 5

var attacked = false
var player_in_range = false

func _ready() -> void:
	
	if player != null:
		print("there is player")
		print(player)
	else:
		print("theres nothingggggg")
		print(get_tree())
	
func _physics_process(delta: float) -> void:
	var player_direction = (player.position - position).normalized()
	velocity =  player_direction * SPEED 
	move_and_slide()
	if player_direction.x < 0:
		$SlimeAnimation.flip_h = true
		$AttackRange/AttackCollision.position = -abs($AttackRange/AttackCollision.position)
	else:
		$SlimeAnimation.flip_h = false
		$AttackRange/AttackCollision.position = abs($AttackRange/AttackCollision.position)
	if attacked == false and player_in_range == true:
		#player.got_damaged()
		attacked = true
		$NormalAttackCooldown.start()

func got_damaged():
	health -= 1
	if health <= 0:
		queue_free()
	$SlimeAnimation.stop()
	$SlimeAnimation.play("hurt")
	await $SlimeAnimation.animation_finished
	$SlimeAnimation.play("idle")
		
func _on_attack_range_body_entered(body: Node2D) -> void:
	if body.is_in_group(player_group):
		player_in_range = true

func _on_normal_attack_cooldown_timeout() -> void:
	attacked = false
