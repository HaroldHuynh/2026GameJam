extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

const MAIN_MENU = "res://main menu//main menu.tscn"

# Connect from your invisible StartButton node's pressed() signal
func _on_main_menu_pressed() -> void:
	print("Menu button was clicked!")
	get_tree().change_scene_to_file(MAIN_MENU)
