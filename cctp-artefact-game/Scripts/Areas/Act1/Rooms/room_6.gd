extends Node2D

@onready var anim: AnimationPlayer = $Anim
@onready var party: CharacterBody2D = $Party
@onready var player: CharacterBody2D = $Player
@onready var pbs: Node2D = $PostBattlePos
@onready var pbs2: Node2D = $PostBattlePos2
@onready var battlecol: CollisionShape2D = $Battle3/Collision


func _ready() -> void:
	Global.InDialogue = false
	anim.play("fade_in")
	if Events.OneEvents == 4:
		party.position = Vector2(pbs.position.x, pbs.position.y)
		player.position = Vector2(pbs2.position.x, pbs2.position.y)
		battlecol.disabled = true
		Global.InDialogue = false
		if !Events.ACT2:
			MusicPlayer.play_area_music()
		else:
			MusicPlayer.play_area2_music()
	_playerstart()
 
func _process(_delta: float) -> void:
	if Events.OneEvents == 1:
		anim.play("fade_out")
		Events.OneEvents = 0

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		if Events.ACT2:
			Events.Narrator = true
			if Events.OneEvents != 4:
				DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorR6.dialogue"))
	if anim_name == "fade_out":
		if !Events.ACT2:
			get_tree().change_scene_to_file("res://Scenes/Combat/Battles/Act1/Battle3.tscn")
			MusicPlayer.stop_music()
		else:
			get_tree().change_scene_to_file("res://Scenes/Combat/Battles/Act2/Combat3.tscn")
			MusicPlayer.stop_music()

func _playerstart():
	if !Events.ACT2:
		party.show()
		player.queue_free()
	else:
		party.queue_free()
		player.show()
		Events.Narrator = true
