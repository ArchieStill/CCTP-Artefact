extends Node2D

@onready var anim: AnimationPlayer = $Anim

@onready var party: CharacterBody2D = $Party
@onready var player: CharacterBody2D = $Player
@onready var a2st: Timer = $ACT2Starttime


func _ready() -> void:
	_playerstart()

func _process(_delta: float) -> void:
	if Events.OneEvents == 1:
		anim.play("fade_out")
		Events.Room1Music = false
		Events.OneEvents = 0
	if Events.Room1Music:
		if !Events.ACT2:
			MusicPlayer.play_area_music()
		else:
			MusicPlayer.play_area2_music()

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/Start.dialogue"))

func _on_act_2_starttime_timeout() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/PlayerR1.dialogue"))

func _playerstart():
	if !Events.ACT2:
		party.show()
		player.queue_free()
		anim.play("fade_in")
	else:
		party.queue_free()
		player.show()
		a2st.start()
