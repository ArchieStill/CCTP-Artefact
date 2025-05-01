extends Node2D

#@onready var glitch: VideoStreamPlayer = $CanvasLayer/Glitch

func _ready() -> void:
	Events.ACT2 = true

#func _process(_delta: float) -> void:
	#if Events.TwoEvents == 1:
		#glitch.play()
		#Events.TwoEvents = 0
#
#func _on_glitch_finished() -> void:
	#glitch.queue_free()
