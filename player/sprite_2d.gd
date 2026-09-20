extends Sprite2D

@export var sprite_pool: Array[Texture2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if sprite_pool.size() > 0:
		# Pick a random index from the array
		var random_index = randi() % sprite_pool.size()
		# Assign the chosen texture to this Sprite2D
		texture = sprite_pool[random_index]
	else:
		push_warning("Sprite pool is empty! Please assign textures in the Inspector.")
