extends CharacterBody2D

@export var laser_scene: PackedScene
@export var fire_every_seconds := 7.0

var alive : bool

func _ready() -> void:
	alive = true
	var fire_timer := Timer.new()
	fire_timer.wait_time = fire_every_seconds
	fire_timer.autostart = true
	fire_timer.timeout.connect(fire_laser)
	add_child(fire_timer)

func fire_laser() -> void:
	$Michelangelo/AnimatedSprite2D.play("attack")
	var laser = laser_scene.instantiate()
	get_parent().add_child(laser)

	# The laser begins at the boss and aims at the player.
	laser.global_position = global_position
	var player = get_tree().get_first_node_in_group("player")
	if player:
		laser.direction = (player.global_position - global_position).normalized()

func die():
	pass
