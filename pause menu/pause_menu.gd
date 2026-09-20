extends CanvasLayer

func _ready() -> void:
	# Hide the pause menu immediately when the game starts
	hide()

func _input(event: InputEvent) -> void:
	# "pause" maps to the Escape key by default in Godot
	if event.is_action_pressed("pause"):
		if not get_parent().gameOver:
			toggle_pause()

func toggle_pause() -> void:
	# Invert the current pause state of the engine tree
	get_tree().paused = !get_tree().paused
	
	# Show the menu if paused, hide it if unpaused
	if get_tree().paused:
		show()
		# If you are making a 3D game or mouse-captured game:
		# Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		hide()
		# Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_resume_button_pressed() -> void:
	# Unpause the game and hide this menu
	toggle_pause()

func _on_quit_button_pressed() -> void:
	# Exit the game cleanly
	get_tree().quit()

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main menu/main menu.tscn")

func _on_main_menu_2_pressed() -> void:
	get_tree().change_scene_to_file("res://main menu/main menu.tscn")
