extends Node2D

@onready var TTS: Timer = $TimeToFive
@onready var glitch: VideoStreamPlayer = $CanvasLayer/Glitch

func _ready() -> void:
	Global.FiveEnemy = false

func _process(_delta: float) -> void:
	if Events.TwoEvents == 7:
		glitch.play()
		Events.TwoEvents = 0

func _on_time_to_five_timeout() -> void:
	Events.TwoEvents = 7

func _on_glitch_finished() -> void:
	Global.ShowFives = true
	glitch.queue_free()
