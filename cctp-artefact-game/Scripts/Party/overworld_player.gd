extends CharacterBody2D


@export var speed: float = 200
@onready var player: AnimatedSprite2D = $Player
var anim_temp: bool = true


func _process(delta: float) -> void:
	if Global.InDialogue:
		player.play("Idle")
	else:
		if !Events.Cutscene:
			_movement(delta)
	
	if Events.Cutscene:
		position -= Vector2(0, (speed / 2) * delta)
		Global.InDialogue = false
		if anim_temp:
			player.play("WalkUp")
			anim_temp = false

func _movement(dt: float):
	if Input.is_action_pressed('Right'):
		position += Vector2(speed * dt, 0)
		player.play("WalkRight")
	elif Input.is_action_pressed('Left'):
		position -= Vector2(speed * dt, 0)
		player.play("WalkLeft")
	elif Input.is_action_pressed('Down'):
		position += Vector2(0, speed * dt)
		player.play("WalkDown")
	elif Input.is_action_pressed('Up'):
		position -= Vector2(0, speed * dt)
		player.play("WalkUp")
	else:
		player.play("Idle")
	
	move_and_slide()
