extends Node2D

@onready var glitch: VideoStreamPlayer = $CanvasLayer/Glitch
@onready var combat_tips: Control = $CanvasLayer/CombatTips

func _ready() -> void:
	Events.ACT2 = true

func _on_time_for_n_timeout() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorC1.dialogue"))

func _process(_delta: float) -> void:
	if Events.TwoEvents == 1:
		glitch.play()
		$GlitchSFX.play()
		Events.GlitchMusic = true
		Events.TwoEvents = 0

func _on_glitch_finished() -> void:
	combat_tips.queue_free()
	glitch.queue_free()
	Events.GlitchMusic = false
