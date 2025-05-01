extends Node2D

@onready var TT5: Timer = $TimeToFive
@onready var glitch: VideoStreamPlayer = $CanvasLayer/Glitch

func _ready() -> void:
	Global.FiveEnemy = true

func _process(_delta: float) -> void:
	if Events.TwoEvents == 6:
		glitch.play()
		$GlitchSFX.play()
		Events.GlitchMusic = true
		Events.TwoEvents = 0

func _on_time_to_five_timeout() -> void:
	Events.Narrator = true
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorC3.dialogue"))

func _on_glitch_finished() -> void:
	Global.ShowFives = true
	Events.GlitchMusic = false
	glitch.queue_free()
