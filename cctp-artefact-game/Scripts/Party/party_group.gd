extends Node2D

@onready var youwin: ColorRect = $YOUWIN
@onready var win_timer: Timer = $YOUWIN/WinTimer
@onready var youlose: ColorRect = $YOULOSE
@onready var lose_timer: Timer = $YOULOSE/LoseTimer
@onready var glitch: VideoStreamPlayer = $Glitch
@onready var battle_music: AudioStreamPlayer = $BattleMusic
@onready var boss_music: AudioStreamPlayer = $BossMusic

const battle_theme = preload("res://Assets/Audio/Music/LoopedBattle.mp3")
const boss_theme = preload("res://Assets/Audio/Music/FinalBattleBetterLoop.mp3")

var run_once: bool = true

func _ready() -> void:
	if !Global.Boss:
		boss_music.volume_db = -100000
	else:
		battle_music.volume_db = -1000000

func _process(_delta: float) -> void:
	if Global.CombatOver:
		# displays win screen
		if run_once:
			$BattleMusic.volume_db = -15
			youwin.show()
			$WinSFX.play()
			win_timer.start()
			run_once = false
	else:
		youwin.hide()
		if Events.GlitchMusic:
			$BattleMusic.volume_db = -100000
		else:
			if !Global.Boss:
				$BattleMusic.volume_db = 0
	
	if Events.OneDeath:
		youlose.show()
		lose_timer.start()
		Events.OneDeath = false

func _on_win_timer_timeout() -> void:
	youwin.hide()
	# move to next scene
	match Global.Battle:
		"Battle1":
			Events.OneEvents = 2
			Stats._reset()
			get_tree().change_scene_to_file("res://Scenes/Areas/room_2.tscn")
		"Battle2":
			Events.OneEvents = 3
			Stats._reset()
			get_tree().change_scene_to_file("res://Scenes/Areas/room_4.tscn")
		"Battle3":
			Events.OneEvents = 4
			Stats._reset()
			get_tree().change_scene_to_file("res://Scenes/Areas/room_6.tscn")
		"Battle4":
			Events.OneEvents = 5
			Stats._reset()
			get_tree().change_scene_to_file("res://Scenes/Areas/room_8.tscn")
		"Dragon":
			Events.OneEvents = 6
			Stats._reset()
			get_tree().change_scene_to_file("res://Scenes/Areas/room_F.tscn")
	Global.CombatOver = false
	run_once = true
	win_timer.wait_time = 2


func _on_lose_timer_timeout() -> void:
	youlose.hide()
	glitch.play()
	$GlitchSFX.play()

func _on_glitch_finished() -> void:
	Stats._reset()
	Stats.OneDC = true
	get_tree().reload_current_scene()
