extends Node2D

@onready var action_pane: VBoxContainer = $ActionPane
@onready var attack_sprite: AnimatedSprite2D = $AttackSprite
@onready var turn_delay: Timer = $TurnDelay
@onready var hp: ProgressBar = $HPBar
@onready var hp_text: Label = $HPBar/HPText

@onready var sprite: Sprite2D = $Sprite
@onready var dead: bool = false
@onready var attack_sfx: AudioStreamPlayer = $AttackSFX

func _ready() -> void:
	Stats.ClericHP = 100

func _process(_delta: float) -> void:
	_updateHP()
	
	if !Global.CombatOver:
		if !dead:
			if Global.PartyTurn == 2:
				pass
				#action_pane.show()
			else:
				action_pane.hide()
			
			if !Global.Attacking and !Global.HideActions and Global.PartyTurn == 2:
				action_pane.show()
			if Global.Attacking:
				action_pane.hide()
		if dead and Stats.ClericCheck:
			turn_delay.start()
			Stats.ClericCheck = false
	
	if Global.PlayAttack and Global.PartyTurn == 2:
		attack_sprite.show()
		attack_sprite.play()
		attack_sfx.pitch_scale = randf_range(0.9, 1.1)
		attack_sfx.play()
		Global.PlayAttack = false

func _updateHP():
	hp.value = Stats.ClericHP
	hp_text.text = "HP: " + str(Stats.ClericHP) + "/100"
	if Stats.ClericHP <= 0:
		Stats.ClericHP = 0
		dead = true
		hide()
		position = Global.TEHOM
	else:
		dead = false
		sprite.self_modulate = Color(1,1,1)

func _on_attack_sprite_animation_finished() -> void:
	attack_sprite.hide()
	turn_delay.start()
func _on_turn_delay_timeout() -> void:
	Global.Attacking = false
	Global.HideActions = false
	Global.PartyTurn += 1
