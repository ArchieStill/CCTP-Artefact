extends Node2D

@onready var youwin: ColorRect = $YOUWIN
@onready var win_timer: Timer = $YOUWIN/WinTimer
@onready var youlose: ColorRect = $YOULOSE
@onready var lose_timer: Timer = $YOULOSE/LoseTimer
@onready var glitch_timer: Timer = $YOULOSE/LoseGlitchTimer
@onready var glitch: VideoStreamPlayer = $Glitch
var run_once: bool = true

func _process(_delta: float) -> void:
	if Global.CombatOver:
		if run_once:
			$BattleMusic.volume_db = -15
			youwin.show()
			$WinSFX.play()
			win_timer.start()
			run_once = false
	else:
		if !Global.Boss:
			youwin.hide()
			if Events.GlitchMusic:
				$BattleMusic.volume_db = -100000
			else:
				$BattleMusic.volume_db = 0
		else:
			$BattleMusic.volume_db = -100000
	
	if Events.TwoDeath:
		youlose.show()
		lose_timer.start()
		Events.TwoDeath = false


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
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorGameOver.dialogue"))
	glitch_timer.start()

func _on_lose_glitch_timer_timeout() -> void:
	youlose.hide()
	glitch.play()
	$GlitchSFX.play()

func _on_glitch_finished() -> void:
	Stats._reset()
	Stats.TwoDC = true
	get_tree().reload_current_scene()
