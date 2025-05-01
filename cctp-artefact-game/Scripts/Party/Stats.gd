extends Node


@onready var MageHP: int = 80
var MageCheck: bool = true
var ManaSurge: bool = false

@onready var WarriorHP: int = 150
var WarriorCheck: bool = true
var GreatCleave: bool = false
var GCPlayer: bool = false
var GC_Hide: bool = false

@onready var ClericHP: int = 100
var ClericCheck: bool = true
var HealingWave: bool = false

@onready var ThiefHP: int = 70
var ThiefCheck: bool = true
var CunningStrike: bool = false
var CS_Hide: bool = false

@onready var PlayerHP: int = 250
var PlayerCheck: bool = true

@onready var MP: int = 0

@onready var OneDC: bool = true
@onready var TwoDC: bool = true

func _reset():
	Global.PartyTurn = 0
	Global.PlayerTurn = 0
	Global.EnemyTurn = 5
	Global.EnemyOnce = true
	Global.EnemyCount = 0
	MageHP = 80
	MageCheck = true
	WarriorHP = 150
	WarriorCheck = true
	ClericHP = 100
	ClericCheck = true
	ThiefHP = 70
	ThiefCheck = true
	PlayerHP = 250
	PlayerCheck = true
	MP = 0


func _process(_delta: float) -> void:
	# reset current battle if a character dies
	if WarriorHP == 0 or MageHP == 0 or ClericHP == 0 or ThiefHP == 0:
		if OneDC:
			#_reset()
			Events.OneDeath = true
			OneDC = false
	if PlayerHP == 0:
		if TwoDC:
			#_reset()
			Events.TwoDeath = true
			TwoDC = false
		
	# stop overheal
	if MageHP > 80:
		MageHP = 80
	if WarriorHP > 150:
		WarriorHP = 150
	if ClericHP > 100:
		ClericHP = 100
	if ThiefHP > 70:
		ThiefHP = 70
	if PlayerHP > 250:
		PlayerHP = 250
