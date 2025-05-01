extends Node2D

@onready var action_pane: VBoxContainer = $ActionPane
@onready var attack_sprite: AnimatedSprite2D = $AttackSprite
@onready var turn_delay: Timer = $TurnDelay
@onready var hp: ProgressBar = $HPBar
@onready var hp_text: Label = $HPBar/HPText

@onready var sprite: Sprite2D = $Sprite
@onready var dead: bool = false
@onready var label: Label = $Label
@onready var attack_sfx: AudioStreamPlayer = $AttackSFX

func _ready() -> void:
	Stats.PlayerHP = 250

func _process(_delta: float) -> void:
	label.text = Global.player_name
	_updateHP()

	if !Global.CombatOver:
		if !dead:
			if Global.PlayerTurn == 0:
				pass
				#action_pane.show()
			else:
				action_pane.hide()
			if !Global.Attacking and !Global.HideActions and Global.PlayerTurn == 0:
				action_pane.show()
			if Global.Attacking:
				action_pane.hide()
		if dead and Stats.MageCheck:
			turn_delay.start()
			Stats.MageCheck = false

	if Global.PlayAttack and Global.PlayerTurn == 0:
		attack_sprite.show()
		attack_sprite.play()
		attack_sfx.pitch_scale = randf_range(0.9, 1.1)
		attack_sfx.play()
		Global.PlayAttack = false

func _updateHP():
	hp.value = Stats.PlayerHP
	hp_text.text = "HP: " + str(Stats.PlayerHP) + "/250"
	if Stats.PlayerHP <= 0:
		Stats.PlayerHP = 0
		dead = true
		hide()
		position = Global.TEHOM
	else:
		dead = false
		#sprite.self_modulate = Color(1,1,1)

func _on_attack_sprite_animation_finished() -> void:
	attack_sprite.hide()
	turn_delay.start()
func _on_turn_delay_timeout() -> void:
	Global.Attacking = false
	Global.HideActions = false
	Global.PlayerTurn += 1
	Global.EnemyTurn = 0
