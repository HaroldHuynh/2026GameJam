extends Node2D

@onready var level = get_node("/root/%s" % [get_parent().name]) 

signal hit_p

var enemy_scene = preload("res://enemy/enemy.tscn")
var spawn_points := []
var max_enemies = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)


func _on_timer_timeout() -> void:
	var enemies = get_tree().get_nodes_in_group("enemies")
	if enemies.size() < max_enemies:	
		var spawn = spawn_points[randi() % spawn_points.size()]
		var enemy = enemy_scene.instantiate()
		enemy.position = spawn.position
		enemy.hit_player.connect(hit)
		level.add_child(enemy)
		enemy.add_to_group("enemies")

func hit():
	hit_p.emit()
