extends Node2D

@onready var group: Node = $Group
var enemies: Array = []
var enemy_num: int = 3
var surge_once: bool = true

func _ready() -> void:
	enemies = group.get_children()

func _process(_delta: float) -> void:
	_ManaSurge()
	if !Global.Boss:
		if !Global.FiveEnemy:
			match Global.EnemyTurn:
				0:
					if Global.EnemyOnce:
						enemies[0]._enemyTurn()
						Global.EnemyOnce = false
				1:
					if Global.EnemyOnce:
						enemies[1]._enemyTurn()
						Global.EnemyOnce = false
				2:
					if Global.EnemyOnce:
						enemies[2]._enemyTurn()
						Global.EnemyOnce = false
						_CheckReset()
						if !Events.ACT2:
							Global.PartyTurn = 0
						else:
							Global.PlayerTurn = 0
						surge_once = true
		else:
			enemy_num = 5
			_five()
	else:
		enemy_num = 1
		match Global.EnemyTurn:
			0:
				if Global.EnemyOnce:
					enemies[0]._enemyTurn()
					Global.EnemyOnce = false
					_CheckReset()
					if !Events.ACT2:
						Global.PartyTurn = 0
					else:
						Global.PlayerTurn = 0
					surge_once = true
	
	if enemy_num == Global.EnemyCount:
		Global.CombatOver = true
		surge_once = true
		Global.FiveEnemy = false
		Global.ShowFives = false

func _CheckReset():
	Stats.WarriorCheck = true
	Stats.MageCheck = true
	Stats.ClericCheck = true
	Stats.ThiefCheck = true
	Stats.PlayerCheck = true

# Mana Surge
func _ManaSurge():
	if Stats.ManaSurge and surge_once:
		if !Events.ACT2:
			for i in enemies.size():
				enemies[i].HP -= 4
		else:
			for i in enemies.size():
				enemies[i].HP -= 8
		Stats.ManaSurge = false
		surge_once = false


func _on_gl_button_mouse_entered() -> void:
	var glitch: Node2D = $Glitch
	var screen_glitch: VideoStreamPlayer = $ScreenGlitch
	var glitch_sfx: AudioStreamPlayer = $GlitchSFX
	glitch.queue_free()
	screen_glitch.show()
	screen_glitch.play()
	glitch_sfx.play()
	Events.GlitchMusic = true
func _on_screen_glitch_finished() -> void:
	var glitched: Node2D = $Group/Glitched
	var screen_glitch: VideoStreamPlayer = $ScreenGlitch
	screen_glitch.queue_free()
	glitched.show()
	Events.GlitchMusic = false


func _five():
	var hidden_1: Node2D = $Group/Hidden1
	var hidden_2: Node2D = $Group/Hidden2
	
	if Global.ShowFives:
		hidden_1.set_modulate(Color(1,1,1,1))
		hidden_2.set_modulate(Color(1,1,1,1))
	
	match Global.EnemyTurn:
		0:
			if Global.EnemyOnce:
				enemies[0]._enemyTurn()
				Global.EnemyOnce = false
		1:
			if Global.EnemyOnce:
				enemies[1]._enemyTurn()
				Global.EnemyOnce = false
		2:
			if Global.EnemyOnce:
				enemies[2]._enemyTurn()
				Global.EnemyOnce = false
		3:
			if Global.EnemyOnce:
				enemies[3]._enemyTurn()
				Global.EnemyOnce = false
		4:
			if Global.EnemyOnce:
				enemies[4]._enemyTurn()
				Global.EnemyOnce = false
				_CheckReset()
				if !Events.ACT2:
					Global.PartyTurn = 0
				else:
					Global.PlayerTurn = 0
				surge_once = true
