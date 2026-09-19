extends Node2D

@onready var level = get_node("/root/PlayerTestLevel")

var enemy_scene = preload("res://enemy/enemy.tscn")
var spawn_points := []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in get_children():
		if i is Marker2D:
			spawn_points.append(i)


func _on_timer_timeout() -> void:
	var spawn = spawn_points[randi() % spawn_points.size()]
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn.position
	level.add_child(enemy)
