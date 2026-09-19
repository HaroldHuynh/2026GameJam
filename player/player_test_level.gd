extends Node2D

var hp : int
var gameOver : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_game():
	hp = 0
	$player.reset()
	$Hud/HPLabel.text = "Memory: " + str(hp)
	$GameOver.hide()
	gameOver = false
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	get_tree().paused = false
	

func _on_enemy_spawner_hit_p() -> void:
	hp += 10
	$Hud/HPLabel.text = "Memory: " + str(hp)
	if hp >= 100:
		get_tree().paused = true
		$GameOver.show()
		gameOver = true
