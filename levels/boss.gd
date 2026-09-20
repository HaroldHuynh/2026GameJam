extends CharacterBody2D

@export var laser_scene: PackedScene
@export var fire_every_seconds := 5.0
@export var warning_seconds := 2.0

var is_attacking := false
var hp : int
var alive : bool

signal hit_player

func _ready() -> void:
	alive = true
	hp = 12
	
	$AnimatedSprite2D.play("default")

	var fire_timer := Timer.new()
	fire_timer.wait_time = fire_every_seconds
	fire_timer.autostart = true
	fire_timer.timeout.connect(fire_laser)
	add_child(fire_timer)

func fire_laser() -> void:
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

	$AnimatedSprite2D.play("default")
	is_attacking = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	hit_player.emit()
