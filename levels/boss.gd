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
	hp = 80
		
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
	
	if hp == 80:
		$boss_hp/AnimatedSprite2D.play("20")
	elif hp >= 76:
		$boss_hp/AnimatedSprite2D.play("19")
	elif hp >= 72:
		$boss_hp/AnimatedSprite2D.play("18")
	elif hp >= 68:
		$boss_hp/AnimatedSprite2D.play("17")
	elif hp >= 64:
		$boss_hp/AnimatedSprite2D.play("16")
	elif hp >= 60:
		$boss_hp/AnimatedSprite2D.play("15")
	elif hp >= 56:
		$boss_hp/AnimatedSprite2D.play("14")
	elif hp >= 52:
		$boss_hp/AnimatedSprite2D.play("13")
	elif hp >= 48:
		$boss_hp/AnimatedSprite2D.play("12")
	elif hp >= 44:
		$boss_hp/AnimatedSprite2D.play("11")
	elif hp >= 40:
		$boss_hp/AnimatedSprite2D.play("10")
	elif hp >= 36:
		$boss_hp/AnimatedSprite2D.play("9")
	elif hp >= 32:
		$boss_hp/AnimatedSprite2D.play("8")
	elif hp >= 28:
		$boss_hp/AnimatedSprite2D.play("7")
	elif hp >= 24:
		$boss_hp/AnimatedSprite2D.play("6")
	elif hp >= 20:
		$boss_hp/AnimatedSprite2D.play("5")
	elif hp >= 16:
		$boss_hp/AnimatedSprite2D.play("4")
	elif hp >= 12:
		$boss_hp/AnimatedSprite2D.play("3")
	elif hp >= 8:
		$boss_hp/AnimatedSprite2D.play("2")
	elif hp >= 4:
		$boss_hp/AnimatedSprite2D.play("1")
	elif hp >= 0:
		$boss_hp/AnimatedSprite2D.play("0")

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
	
