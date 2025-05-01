extends Node2D

@onready var end_timer: Timer = $EndTimer

func _on_pre_dialogue_timeout() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorFinalGlitch.dialogue"))
	end_timer.start()


func _on_end_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Areas/ending.tscn")
	MusicPlayer.stop_music()


func _on_glitch_sfx_finished() -> void:
	$GlitchSFX.play()
