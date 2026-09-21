extends CanvasLayer

@onready var boss = get_node("../Michelangelo")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("20")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var hp = boss.hp
	var active = boss.active
	if active == true:
		$AnimatedSprite2D.position = Vector2(1568.0, 1880.0)
	if hp == 80:
		$AnimatedSprite2D.play("20")
	elif hp >= 76:
		$AnimatedSprite2D.play("19")
	elif hp >= 72:
		$AnimatedSprite2D.play("18")
	elif hp >= 68:
		$AnimatedSprite2D.play("17")
	elif hp >= 64:
		$AnimatedSprite2D.play("16")
	elif hp >= 60:
		$AnimatedSprite2D.play("15")
	elif hp >= 56:
		$AnimatedSprite2D.play("14")
	elif hp >= 52:
		$AnimatedSprite2D.play("13")
	elif hp >= 48:
		$AnimatedSprite2D.play("12")
	elif hp >= 44:
		$AnimatedSprite2D.play("11")
	elif hp >= 40:
		$AnimatedSprite2D.play("10")
	elif hp >= 36:
		$AnimatedSprite2D.play("9")
	elif hp >= 32:
		$AnimatedSprite2D.play("8")
	elif hp >= 28:
		$AnimatedSprite2D.play("7")
	elif hp >= 24:
		$AnimatedSprite2D.play("6")
	elif hp >= 20:
		$AnimatedSprite2D.play("5")
	elif hp >= 16:
		$AnimatedSprite2D.play("4")
	elif hp >= 12:
		$AnimatedSprite2D.play("3")
	elif hp >= 8:
		$AnimatedSprite2D.play("2")
	elif hp >= 4:
		$AnimatedSprite2D.play("1")
	elif hp >= 0:
		$AnimatedSprite2D.play("0")
