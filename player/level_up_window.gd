extends CanvasLayer

func _on_button_pressed() -> void:
	get_parent().damageUp()

func _on_button_4_pressed() -> void:
	get_parent().healthUp()

func _on_button_5_pressed() -> void:
	get_parent().speedUp()
