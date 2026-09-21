extends CharacterBody2D

var levelname : String

@onready var player = get_node("/root/%s/player" % [get_parent().name])

signal hit_player 

var hp : int
var alive : bool
var speed = 300.0
var direction : Vector2 

func _ready():
	alive = true
	hp = 2

func _process(delta: float):
	if not get_node("../Michelangelo").alive:
		die()

func _physics_process(delta: float) -> void:
	direction = player.position - position
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	look_at(player.position)
	
func die():
	alive = false
	get_parent().updateExp()
	queue_free()
	if get_parent().completion < 90:
		get_parent().updateCompletion(3)
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	hit_player.emit()
	get_node("../EnemySpawner").enemies_spawned -= 1
	queue_free()
