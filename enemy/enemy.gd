extends CharacterBody2D

var levelname : String

@onready var player = get_node("/root/%s/player" % [get_parent().name])

var speed = 300.0
var direction : Vector2 

func _physics_process(delta: float) -> void:
	direction = player.position - position
	direction = direction.normalized()
	velocity = direction * speed
	move_and_slide()
