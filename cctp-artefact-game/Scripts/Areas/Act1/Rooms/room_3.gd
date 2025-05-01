extends Node2D

@onready var anim: AnimationPlayer = $Anim
@onready var party: CharacterBody2D = $Party
@onready var player: CharacterBody2D = $Player
@onready var glitch: VideoStreamPlayer = $Glitch

func _ready() -> void:
	Global.InDialogue = false
	anim.play("fade_in")
	#if Events.OneEvents == 4:
		#party.position = Vector2(pbs.position.x, pbs.position.y)
		#b3col.disabled = true
		#Global.InDialogue = false
	_playerstart()

func _process(_delta: float) -> void:
	#if Events.OneEvents == 1:
		#anim.play("fade_out")
		#Events.OneEvents = 0
	if Events.TwoEvents == 5:
		glitch.play()
		$GlitchSFX.play()
		MusicPlayer.stop_music()
		Events.TwoEvents = 0

#func _on_anim_animation_finished(anim_name: StringName) -> void:
	#if anim_name == "fade_out":
		#get_tree().change_scene_to_file("res://Scenes/Combat/Battles/Room/RoomBattle2.tscn")

func _playerstart():
	if !Events.ACT2:
		party.show()
		player.queue_free()
	else:
		party.queue_free()
		player.show()
		Events.Narrator = true


func _on_glitch_finished() -> void:
	Global.Battle = "Battle2"
	get_tree().change_scene_to_file("res://Scenes/Combat/Battles/Act2/Combat2.tscn")
	MusicPlayer.stop_music()
