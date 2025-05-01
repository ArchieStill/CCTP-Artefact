extends CharacterBody2D

signal start_attacking
signal stop_attacking

@onready var sprite: AnimatedSprite2D = $Sprite
#@onready var attack_posR: Node2D = $AttackPosR
#@onready var attack_posL: Node2D = $AttackPosL
@onready var attack_area: Area2D = $CollisionPivot/AttackArea
@onready var pivot: Marker2D = $CollisionPivot
@onready var attack_sfx: AudioStreamPlayer = $AttackSFX
@onready var jump_sfx: AudioStreamPlayer = $JumpSFX

const speed = 300.0
const JUMP_VELOCITY = -600.0
@onready var attacking = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite.play("Jump")

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and !attacking and !Events.FinalControls:
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()
	
	_movement(delta)

func _movement(dt: float):
	if Input.is_action_just_pressed("Attack") and !Events.FinalControls:
		if is_on_floor():
			#attack_area.position = r.position
			attack_sfx.pitch_scale = randf_range(0.9, 1.1)
			attack_sfx.play()
			attacking = true
			#attack_area.show()
			$CollisionPivot/AttackArea/CollisionShape2D.disabled = false
			#attack_area.set_deferred("monitorable", true)
			sprite.play("Attack")
			emit_signal("start_attacking")

	if Input.is_action_pressed('Right') and !attacking and !Events.FinalControls:
		position += Vector2(speed * dt, 0)
		if is_on_floor():
			sprite.play("Run")
		sprite.flip_h = false
		pivot.rotation = 0
		#attack_area.position = attack_posR.position
		#attack_area.position = r.position
	elif Input.is_action_pressed('Left') and !attacking and !Events.FinalControls:
		position -= Vector2(speed * dt, 0)
		if is_on_floor():
			sprite.play("Run")
		sprite.flip_h = true
		pivot.rotation = deg_to_rad(180)
		#attack_area.position = l.position
	else:
		if is_on_floor() and !attacking:
			sprite.play("Idle")
	
	move_and_slide()

func _attack():
	sprite.play("Attack")

func _on_sprite_animation_finished() -> void:
	attacking = false
	$CollisionPivot/AttackArea/CollisionShape2D.disabled = true
	#attack_area.position = Vector2(-100,-100)
	#attack_area.position = l.position
	#attack_area.hide()
	attack_area.set_deferred("monitoring", false)
	emit_signal("stop_attacking")
