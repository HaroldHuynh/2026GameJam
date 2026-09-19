extends CharacterBody2D

signal shoot

var screen_size : Vector2
var speed : int
var can_shoot : bool

func _ready():
	screen_size = get_viewport_rect().size
	process_mode = Node.PROCESS_MODE_ALWAYS
	reset()

func reset():
	position = screen_size / 2
	speed = 300.0
	can_shoot = true

func _physics_process(delta: float) -> void:
	process_movement()
	move_and_slide()
	look_at(get_global_mouse_position())
	
func _process(delta: float) -> void:
	if get_parent().gameOver == true:
		if Input.is_key_pressed(KEY_ENTER):
			print("ENTERED")
			get_parent().new_game()

func process_movement() -> void:
		# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * speed
	
	#limit movement to window size
	position = position.clamp(Vector2.ZERO, screen_size)
	
	#shooting
	if Input.is_key_pressed(KEY_SPACE) and can_shoot:
		var dir = get_global_mouse_position() - position
		shoot.emit(position, dir)
		can_shoot = false
		$ShotTimer.start()
		
		

func _on_shot_timer_timeout() -> void:
	can_shoot = true
