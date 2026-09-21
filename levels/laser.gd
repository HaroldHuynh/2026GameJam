extends CharacterBody2D

var direction := Vector2.DOWN
@export var speed := 2000.0

func aim_at(target_position: Vector2) -> void:
	direction = global_position.direction_to(target_position)

	# Your laser art points downward by default.
	rotation = direction.angle() - PI / 2

func _physics_process(delta: float) -> void:
	$AnimatedSprite2D.play("default")
	global_position += direction * speed * delta
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "player":
		get_parent()._on_enemy_spawner_hit_p()
		queue_free()
		
	
