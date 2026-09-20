extends CharacterBody2D

var direction := Vector2.DOWN
@export var speed := 500.0

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

	# Remove the laser once it has left the visible game area.
	var screen_size = get_viewport_rect().size
	if global_position.x < -500 or global_position.x > screen_size.x + 500 \
			or global_position.y < -500 or global_position.y > screen_size.y + 500:
		queue_free()
