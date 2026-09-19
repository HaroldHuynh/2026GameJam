extends CharacterBody2D

var levelname : String

@onready var player = get_node("/root/%s/player" % [get_parent().name])

signal hit_player 

var alive : bool
var speed = 300.0
var direction : Vector2 

func _ready():
	alive = true

func _physics_process(delta: float) -> void:
	direction = player.position - position
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
	look_at(player.position)
	
func die():
	alive = false
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	hit_player.emit()
	queue_free()
