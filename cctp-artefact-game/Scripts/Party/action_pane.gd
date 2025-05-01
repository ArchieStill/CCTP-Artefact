extends VBoxContainer

@onready var charge: Button = $Charge
@onready var skill: Button = $Skill
@onready var panel: Panel = $Skill/SkillPanel
@onready var skill_name: Label = $Skill/SkillPanel/SkillName
@onready var skill_desc: Label = $Skill/SkillPanel/SkillDesc
@onready var tehom_timer: Timer = $TehomTimer

func _process(_delta: float) -> void:
	if Events.ACT2:
		if Events.Final:
			hide()
		else:
			if Events.FinalFight:
				if Events.FinalTalk:
					hide()
				else:
					show()

	if Stats.MP < 5:
		skill.disabled = true
		panel.hide()
	else:
		skill.disabled = false
		panel.show()
	
	if Stats.MP >= 8 or Events.FinalFight:
		charge.disabled = true
	else:
		charge.disabled = false
	
	_SkillName()
	_SkillDesc()

func _SkillName():
	if !Events.ACT2:
		match Global.PartyTurn:
			0:
				skill_name.text = "Mana Surge"
			1:
				skill_name.text = "Great Cleave"
			2:
				skill_name.text = "Healing Wave"
			3:
				skill_name.text = "Cunning Strike"
	else:
		skill_name.text = "Skill"
func _SkillDesc():
	if !Events.ACT2:
		match Global.PartyTurn:
			0:
				skill_desc.text = "Attacks all enemies"
			1:
				skill_desc.text = "Deal massive damage"
			2:
				skill_desc.text = "Heals all allies"
			3:
				skill_desc.text = "1/3 chance to kill"
	else:
		skill_desc.text = "Lorem ipsum dolor sit"



func _on_attack_pressed() -> void:
	Global.Attacking = true
	Global.HideActions = true
	if Global.Boss:
		position = Global.TEHOM
		tehom_timer.start()
		if Events.FinalFight:
			Events.FinalTalk = true

func _on_charge_pressed() -> void:
	# Magic classes charge more
	if !Events.ACT2:
		if Global.PartyTurn == 0 or Global.PartyTurn == 2:
			Stats.MP += 2
		else:
			Stats.MP += 1
		Global.PartyTurn += 1
		if Global.PartyTurn == 4:
			Global.EnemyTurn = 0
	else:
		Stats.MP += 4
		Stats.HealingWave = true
		Stats.PlayerHP += 75
		Global.PlayerTurn += 1
		Global.EnemyTurn = 0
	$ChargeSFX.pitch_scale = randf_range(0.9, 0.95)
	$ChargeSFX.play()

func _on_skill_pressed() -> void:
	if !Events.ACT2:
		match Global.PartyTurn:
			0:
				Stats.MP -= 5
				Stats.ManaSurge = true
				Global.PartyTurn += 1
			1:
				Stats.MP -= 5
				Global.Attacking = true
				Stats.GreatCleave = true
				if Global.Boss:
					position = Global.TEHOM
					tehom_timer.start()
			2:
				Stats.MP -= 5
				Stats.HealingWave = true
				Stats.WarriorHP += 50
				Stats.MageHP += 50
				Stats.ClericHP += 50
				Stats.ThiefHP += 50
				Global.PartyTurn += 1
			3:
				Stats.MP -= 5
				Global.Attacking = true
				Stats.CunningStrike = true
				if Global.Boss:
					position = Global.TEHOM
					tehom_timer.start()
	else:
		match Global.PlayerTurn:
			0:
				Stats.MP -= 5
				Stats.ManaSurge = true
				Stats.GCPlayer = true
				Global.PlayerTurn += 1
				Global.EnemyTurn = 0


func _on_tehom_timer_timeout() -> void:
	position = Vector2(65,-65)
