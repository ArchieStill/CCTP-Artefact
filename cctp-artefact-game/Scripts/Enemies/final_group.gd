extends Node2D

@onready var attack_timer: Timer = $AttackTimer
@onready var glitch: VideoStreamPlayer = $CanvasLayer/Glitch
@onready var final_glitch: VideoStreamPlayer = $CanvasLayer/FinalGlitch
@onready var glitch_sfx: AudioStreamPlayer = $GlitchSFX

func _process(_delta: float) -> void:
	if Events.FinalTalk and Events.FinalTOnce:
		attack_timer.start()
		Events.FinalTOnce = false
	if Events.FinalStopMusic:
		$BossMusic.stop()


func _on_attack_timer_timeout() -> void:
	match(Events.FinalTNum):
		1:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorFight1.dialogue"))
		2:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorFight2.dialogue"))
		3:
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorFight3.dialogue"))
		4:
			glitch.play()
			glitch_sfx.play()
			Events.FinalEvents = 1
			Events.FinalTalk = false
			Global.PlayerTurn = 0
			Events.FinalTNum = 5
			Events.FinalTOnce = true
		5:
			glitch.play()
			glitch_sfx.play()
			Events.FinalEvents = 2
			Events.FinalTalk = false
			Global.PlayerTurn = 0
			Events.FinalTNum = 6
			Events.FinalTOnce = true
		6: 
			#glitch.play()
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorFight5.dialogue"))
			
		7:
			glitch.play()
			glitch_sfx.play()
			Events.FinalEvents = 3
			Events.FinalTalk = false
			Global.PlayerTurn = 0
			Events.FinalTNum = 8
			Events.FinalTOnce = true
			#DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorFight6.dialogue"))
			
		#8:
			#DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorFight6.dialogue"))
			##final_glitch.play()

func _on_final_glitch_finished() -> void:
	get_tree().change_scene_to_file("res://Scenes/Areas/ending.tscn")
