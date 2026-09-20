extends TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
const GAME_SCENE = "res://levels//level_1.tscn"
const CREDITS_SCENE = "res://main menu//credits.tscn"

# Connect from your invisible StartButton node's pressed() signal
func _on_start_button_pressed() -> void:
	print("Start button was clicked!")
	get_tree().change_scene_to_file(GAME_SCENE)

# Connect from your invisible SettingsButton node's pressed() signal
func _on_credits_button_pressed() -> void:
	print("Credits button was pressed!")
	get_tree().change_scene_to_file(CREDITS_SCENE)


func _on_quit_pressed() -> void:
	get_tree().quit()
