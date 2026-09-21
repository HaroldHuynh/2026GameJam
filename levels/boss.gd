extends CharacterBody2D

@export var laser_scene: PackedScene
@export var bomb_scene: PackedScene
@export var laser_every_seconds := 5.0
@export var bomb_every_seconds := 7.0
@export var warning_seconds := 2.0

var is_attacking := false
var hp : int
var alive : bool

signal hit_player

func _ready() -> void:
	alive = true
	hp = 10000000
	$AnimatedSprite2D.play("asleep")

func nextStage() -> void:
	hp = 12
		
	$AnimatedSprite2D.play("awake")
	#timer for laser
	var laser_timer := Timer.new()
	laser_timer.wait_time = laser_every_seconds
	laser_timer.autostart = true
	laser_timer.timeout.connect(fire_laser)
	add_child(laser_timer)
	#timer for bombs
	var bomb_timer := Timer.new()
	bomb_timer.wait_time = bomb_every_seconds
	bomb_timer.autostart = true
	bomb_timer.timeout.connect(fire_bomb)
	add_child(bomb_timer)

func fire_laser() -> void:
	if alive:
		if is_attacking:
			return

		is_attacking = true

		# Warning: play the attack animation before the laser exists.
		$AnimatedSprite2D.play("attack")
		await get_tree().create_timer(warning_seconds).timeout

		# Fire the laser after the two-second warning.
		var laser = laser_scene.instantiate()
		get_parent().add_child(laser)
		laser.global_position = global_position

		var player = get_tree().get_first_node_in_group("player")
		if player:
			laser.aim_at(player.global_position)
		else:
			push_warning("Boss could not find a node in the player group.")

		$AnimatedSprite2D.play("awake")
		is_attacking = false

func die():
	alive = false
	$AnimatedSprite2D.play("death")
	$DeathTimer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	hit_player.emit()

func fire_bomb() -> void:
	if alive:
		if is_attacking:
			return

		is_attacking = true

		# Warning: play the attack animation before the bomb exists.
		$AnimatedSprite2D.play("attack")
		await get_tree().create_timer(warning_seconds).timeout

		# Fire the bomb after the two-second warning.
		var bomb = bomb_scene.instantiate()
		get_parent().add_child(bomb)
		bomb.global_position = global_position

		var player = get_tree().get_first_node_in_group("player")
		if player:
			bomb.aim_at(player.global_position)
		else:
			push_warning("Boss could not find a node in the player group.")

		$AnimatedSprite2D.play("awake")
		is_attacking = false


func _on_death_timer_timeout() -> void:
	queue_free()
	get_node("../EnemySpawner").killAll()
	get_parent().updateCompletion(10)
	get_parent().win()
	
