extends Node2D

var hp : float
var maxHP : float
var exp : int
var level : int
var atkSpeed : float
var damage : int
var moveSpeed : int
var gameOver : bool
var completion : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	$Michelangelo/AnimatedSprite2D.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_game():
	$WinScreen.hide()
	$GameOver.hide()
	$LevelUpWindow.hide()
	$Hud.show()
	completion = 0
	maxHP = 10
	hp = 10
	exp = 0
	level = 0
	atkSpeed = 0.75
	damage = 1
	moveSpeed = 500
	$EnemySpawner.enemies_spawned = 0
	$player.speed = moveSpeed
	$player.atkSpeed = atkSpeed
	$BulletManager.damage = damage
	$player.reset()
	$Hud/CompletionLabel.text = "Malware Eliminated: " + str(completion) + "%"
	$Hud/HPLabel.text = "Memory: " + str(100 - int((hp / maxHP) * 100)) + "%"
	$Hud/EXPLabel.text = "Update Progress: " + str(exp) + "%"
	$Hud/LevelLabel.text = "Windows 1." + str(level)
	gameOver = false
	get_tree().call_group("enemies", "queue_free")
	get_tree().call_group("bullets", "queue_free")
	get_tree().paused = false
	

func _on_enemy_spawner_hit_p() -> void:
	hp -= 1
	$Hud/HPLabel.text = "Memory: " + str(100 - int((hp / maxHP) * 100)) + "%"
	if hp <= 0:
		$Hud.hide()
		get_tree().paused = true
		$GameOver.show()
		gameOver = true
		
func updateExp():
	exp += 10
	$Hud/EXPLabel.text = "Update Progress: " + str(exp) + "%"
	if exp >= 100:
		levelUp()
		
func levelUp():
	get_tree().paused = true
	$LevelUpWindow.show()
	
func updateCompletion(increase):
	completion += increase
	$Hud/CompletionLabel.text = "Malware Eliminated: " + str(completion) + "%"
	if $Michelangelo.alive and completion >= 90:
		print("balls")
		$Michelangelo.nextStage()
	
func damageUp():
	$BulletManager.damage += 1
	get_tree().paused = false
	$LevelUpWindow.hide()
	level += 1
	$Hud/LevelLabel.text = "Windows 1." + str(level)
	exp = 0
	$Hud/EXPLabel.text = "Update Progress: " + str(exp) + "%"
	
func healthUp():
	maxHP += 5
	hp += 5
	$Hud/HPLabel.text = "Memory: " + str(100 - int((hp / maxHP) * 100)) + "%"
	get_tree().paused = false
	$LevelUpWindow.hide()
	level += 1
	$Hud/LevelLabel.text = "Windows 1." + str(level)
	exp = 0
	$Hud/EXPLabel.text = "Update Progress: " + str(exp) + "%"
	
func speedUp():
	$player.speed = $player.speed * 1.1
	$player.atkSpeed = $player.atkSpeed * 0.9
	get_tree().paused = false
	$LevelUpWindow.hide()
	level += 1
	$Hud/LevelLabel.text = "Windows 1." + str(level)
	exp = 0
	$Hud/EXPLabel.text = "Update Progress: " + str(exp) + "%"
	
func win():
	get_tree().paused = true
	$WinScreen.show()
