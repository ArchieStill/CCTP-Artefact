extends Node2D

@onready var hp_bar: ProgressBar = $HPBar
@onready var focus: AnimatedSprite2D = $Focus
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var attack_sprite: AnimatedSprite2D = $AttackSprite
@onready var turn_delay: Timer = $TurnDelay

@onready var gc_sprite: AnimatedSprite2D = $GreatCleaveSprite
@onready var cs_sprite: AnimatedSprite2D = $CunningStrikeSprite
@onready var attack_sfx: AudioStreamPlayer = $AttackSFX
@onready var great_cleave_sfx: AudioStreamPlayer = $GreatCleaveSFX
@onready var cunning_strike_sfx: AudioStreamPlayer = $CunningStrikeSFX


@export var EnemyType: String
@export var focusing: bool = false

@onready var turn: bool = false
@onready var HP: int
@onready var ATK: int
@onready var dead: bool = false
var check_dead: bool = true

@onready var rng = RandomNumberGenerator.new()
@onready var choose_targ = rng.randf_range(0, 100)
@onready var Target: String
@onready var EnemyAttack: bool = false


func _ready() -> void:
	match EnemyType:
		"Skeleton":
			HP = 10
			hp_bar.max_value = 10
			hp_bar.value = 10
			ATK = 10
		"Eyeball":
			HP = 15
			hp_bar.max_value = 15
			hp_bar.value = 15
			ATK = 20
		"Gargoyle":
			HP = 20
			hp_bar.max_value = 20
			hp_bar.value = 20
			ATK = 25
		"Dragon":
			HP = 70
			hp_bar.max_value = 45
			hp_bar.value = 45
			ATK = 35
			Global.Boss = true
	hp_bar.max_value = HP
	hp_bar.value = HP

func _process(_delta: float) -> void:
	_updateHP()

func _updateHP():
	hp_bar.value = HP
	if Global.Attacking and EnemyType == "Dragon":
		_TakeDamage()
	if HP <= 0 and check_dead:
		hide()
		if Stats.CunningStrike:
			show()
		dead = true
		Global.EnemyCount += 1
		check_dead = false

# Calls functions enemy takes on their turn
func _enemyTurn():
	if !dead:
		_chooseTarget()
		EnemyAttack = true
		_attack()
	else:
		turn_delay.start()


# Select random target
func _chooseTarget():
	if !Events.ACT2:
		choose_targ = rng.randf_range(0, 100)
		if choose_targ <= 50:
			if Stats.WarriorHP > 0:
				Target = "Warrior"
			else:
				Target = "Mage"
		elif choose_targ > 50 and choose_targ <= 65:
			if Stats.MageHP > 0:
				Target = "Mage"
			else:
				Target = "Cleric"
		elif choose_targ > 65 and choose_targ <= 90:
			if Stats.ClericHP > 0:
				Target = "Cleric"
			else:
				Target = "Thief"
		elif choose_targ > 90 and choose_targ <= 100:
			if Stats.ThiefHP > 0:
				Target = "Thief"
			else:
				Target = "Warrior"
	else:
		Target = "Player"

func _attack():
	if EnemyAttack:
			match Target:
				"Warrior":
					Stats.WarriorHP -= ATK
					attack_sprite.show()
					attack_sprite.play()
					attack_sfx.pitch_scale = randf_range(0.7, 0.8)
					attack_sfx.play()
					EnemyAttack = false
				"Mage":
					Stats.MageHP -= ATK
					attack_sprite.show()
					attack_sprite.play()
					attack_sfx.pitch_scale = randf_range(0.7, 0.8)
					attack_sfx.play()
					EnemyAttack = false
				"Cleric":
					Stats.ClericHP -= ATK
					attack_sprite.show()
					attack_sprite.play()
					attack_sfx.pitch_scale = randf_range(0.7, 0.8)
					attack_sfx.play()
					EnemyAttack = false
				"Thief":
					Stats.ThiefHP -= ATK
					attack_sprite.show()
					attack_sprite.play()
					attack_sfx.pitch_scale = randf_range(0.7, 0.8)
					attack_sfx.play()
					EnemyAttack = false
				"Player":
					Stats.PlayerHP -= ATK
					attack_sprite.show()
					attack_sprite.play()
					attack_sfx.pitch_scale = randf_range(0.7, 0.8)
					attack_sfx.play()
					EnemyAttack = false

# Player targeting
func _on_button_mouse_entered() -> void:
	if Global.Attacking and !Global.PlayAttack:
		focusing = true
		focus.show()
func _on_button_mouse_exited() -> void:
	if Global.Attacking and !Global.PlayAttack:
		focusing = false
		focus.hide()

# Taking damage
func _on_button_pressed() -> void:
	if focusing:
		_TakeDamage()
		focusing = false
		focus.hide()

# Play attack animation
func _on_attack_sprite_animation_finished() -> void:
	attack_sprite.hide()
	turn_delay.start()
func _on_turn_delay_timeout() -> void:
	Global.EnemyTurn += 1
	Global.EnemyOnce = true


func _TakeDamage():
	Global.Attacking = false
	# Great Cleave
	if Stats.GreatCleave:
		Stats.GC_Hide = true
		Global.PlayAttack = true
		HP -= 8
		animation_player.play("TakeDamage")
		gc_sprite.show()
		gc_sprite.play()
		great_cleave_sfx.play()
	else:
		# Cunning Strike
		if Stats.CunningStrike:
			Stats.CS_Hide = true
			Global.PlayAttack = true
			var strike = rng.randf_range(0, 100)
			if strike < 60:
				HP -= 3
				Stats.CunningStrike = false
			else:
				# INSTAKILL
				HP = 0
				cs_sprite.show()
				cs_sprite.play()
				cunning_strike_sfx.play()
			animation_player.play("TakeDamage")
		else:
			# Regular attack
			Global.PlayAttack = true
			# Variable damage depending on class
			if !Events.ACT2:
				if Global.PartyTurn == 1:
					HP -= 4
				elif Global.PartyTurn == 3:
					HP -= 3
				else:
					HP -= 2
			else:
				HP -= 6
			animation_player.play("TakeDamage")


func _on_gc_sprite_animation_finished() -> void:
	gc_sprite.hide()
	Stats.GreatCleave = false
func _on_cs_sprite_animation_finished() -> void:
	cs_sprite.hide()
	Stats.CunningStrike = false
	hide()
