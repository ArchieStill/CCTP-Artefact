extends CharacterBody2D


@export var speed: float = 200
@onready var mage: AnimatedSprite2D = $Mage
@onready var warrior: AnimatedSprite2D = $Warrior
@onready var cleric: AnimatedSprite2D = $Cleric
@onready var thief: AnimatedSprite2D = $Thief
var anim_temp: bool = true


func _process(delta: float) -> void:
	if Global.InDialogue:
		mage.play("Idle")
		warrior.play("Idle")
		cleric.play("Idle")
		thief.play("Idle")
	else:
		if !Events.Cutscene:
			_movement(delta)
	
	if Events.Cutscene:
		position -= Vector2((speed / 2) * delta, 0)
		if anim_temp:
			mage.play("WalkLeft")
			warrior.play("WalkLeft")
			cleric.play("WalkLeft")
			thief.play("WalkLeft")
			anim_temp = false

func _movement(dt: float):
	if Input.is_action_pressed('Right'):
		position += Vector2(speed * dt, 0)
		mage.play("WalkRight")
		warrior.play("WalkRight")
		cleric.play("WalkRight")
		thief.play("WalkRight")
	elif Input.is_action_pressed('Left'):
		position -= Vector2(speed * dt, 0)
		mage.play("WalkLeft")
		warrior.play("WalkLeft")
		cleric.play("WalkLeft")
		thief.play("WalkLeft")
	elif Input.is_action_pressed('Down'):
		position += Vector2(0, speed * dt)
		mage.play("WalkDown")
		warrior.play("WalkDown")
		cleric.play("WalkDown")
		thief.play("WalkDown")
	elif Input.is_action_pressed('Up'):
		position -= Vector2(0, speed * dt)
		mage.play("WalkUp")
		warrior.play("WalkUp")
		cleric.play("WalkUp")
		thief.play("WalkUp")
	else:
		mage.play("Idle")
		warrior.play("Idle")
		cleric.play("Idle")
		thief.play("Idle")
	
	move_and_slide()
