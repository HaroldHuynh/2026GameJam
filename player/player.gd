extends CharacterBody2D

var screen_size : Vector2
var speed : int

func _ready():
	screen_size = get_viewport_rect().size
	position = screen_size / 2
	speed = 300.0

func _physics_process(delta: float) -> void:
	process_movement()
	move_and_slide()
	look_at(get_global_mouse_position())
	

func process_movement() -> void:
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * speed
	
	#limit movement to window size
	position = position.clamp(Vector2.ZERO, screen_size)
