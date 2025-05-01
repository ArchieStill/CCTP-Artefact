extends Node2D

@onready var anim: AnimationPlayer = $Anim
@onready var party: CharacterBody2D = $Party
@onready var player: CharacterBody2D = $Player
@onready var pre_dragon: Area2D = $PreDragon

func _ready() -> void:
	Global.InDialogue = false
	anim.play("fade_in")
	_playerstart()
	MusicPlayer.stop_music()
	MusicPlayer.play_lava()

func _playerstart():
	if !Events.ACT2:
		party.show()
		player.queue_free()
	else:
		party.queue_free()
		player.show()
		Events.Narrator = true
		pre_dragon.queue_free()


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in" and Events.ACT2:
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorR9.dialogue"))
