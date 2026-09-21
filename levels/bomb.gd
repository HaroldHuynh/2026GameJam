extends CharacterBody2D

var direction := Vector2.DOWN
@export var speed := 1000.0

func _ready() -> void:
	$AnimatedSprite2D.play("explode")
	var timer1 := Timer.new()
	timer1.wait_time = 1.0
	timer1.one_shot = false
	timer1.autostart = true
	timer1.timeout.connect(on_timer1_finished)
	add_child(timer1)
	
	var timer2 := Timer.new()
	timer2.wait_time = 2.0
	timer2.one_shot = false
	timer2.autostart = true
	timer2.timeout.connect(on_timer2_finished)
	add_child(timer2)

func on_timer1_finished() -> void:
	$AnimatedSprite2D.play("default")
	stop_bomb()
	$AnimatedSprite2D.scale = Vector2(0.7, 0.7)
	
func on_timer2_finished() -> void:
	queue_free()
	

func aim_at(target_position: Vector2) -> void:
	direction = global_position.direction_to(target_position)

	# Your laser art points downward by default.
	rotation = direction.angle() - PI / 2

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	


func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "player":
		get_parent()._on_enemy_spawner_hit_p()
		queue_free()
		
func stop_bomb() -> void:
	direction = Vector2.ZERO
	velocity = Vector2.ZERO
