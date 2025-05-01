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
	Stats.WarriorHP = 150

func _process(_delta: float) -> void:
	_updateHP()

	if !Global.CombatOver:
		if !dead:
			if Global.PartyTurn == 1:
				pass
				#action_pane.show()
			else:
				action_pane.hide()
			
			if !Global.Attacking and !Global.HideActions and Global.PartyTurn == 1:
				action_pane.show()
			if Global.Attacking:
				action_pane.hide()
			if Stats.GC_Hide:
				action_pane.hide()
		if dead and Stats.WarriorCheck:
			turn_delay.start()
			Stats.WarriorCheck = false
	
	if Global.PlayAttack and Global.PartyTurn == 1:
		attack_sprite.show()
		attack_sprite.play()
		attack_sfx.pitch_scale = randf_range(0.9, 1.1)
		attack_sfx.play()
		Global.PlayAttack = false

func _updateHP():
	hp.value = Stats.WarriorHP
	hp_text.text = "HP: " + str(Stats.WarriorHP) + "/150"
	if Stats.WarriorHP <= 0:
		Stats.WarriorHP = 0
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
	Stats.GC_Hide = false
	Global.PartyTurn += 1
