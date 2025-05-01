extends Node2D
@onready var end_timer: Timer = $EndTimer

func _ready() -> void:
	Events.Narrator = false
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
	Global.InDialogue = true

func _process(_delta: float) -> void:
	if Events.TwoEvents == 8484:
		end_timer.start()
		Events.TwoEvents = 0

func _on_pre_cutscene_timeout() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/PlayerSunrise.dialogue"))

func _on_end_timer_timeout() -> void:
	get_tree().quit()
