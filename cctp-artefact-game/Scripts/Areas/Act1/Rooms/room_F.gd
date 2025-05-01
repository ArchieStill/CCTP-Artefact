extends Node2D

@onready var anim: AnimationPlayer = $Anim
@onready var party: CharacterBody2D = $Party
@onready var player: CharacterBody2D = $Player
@onready var pbs: Node2D = $PostBattlePos
@onready var battlecol: CollisionShape2D = $Dragon/Collision
@onready var pretime: Timer = $PreACT2Time
@onready var sprite: Sprite2D = $DragonSprite

@onready var glitch: VideoStreamPlayer = $Glitch
@onready var party_swap: Area2D = $PartySwap
var swap_parties: bool = false
@onready var party_base_pos: Node2D = $PartyBasePos
@onready var player_base_pos: Node2D = $PlayerBasePos
@onready var post_swap: Node2D = $PostSwap


var beat_boss: bool = false
var time_temp: bool = true

func _ready() -> void:
	Global.InDialogue = false
	anim.play("fade_in")
	_playerstart()
	
	if Events.OneEvents == 6:
		sprite.hide()
		party.position = Vector2(pbs.position.x, pbs.position.y)
		player.position = Global.TEHOM
		battlecol.disabled = true
		beat_boss = true
		DialogueManager.show_dialogue_balloon(load("res://Dialogue/PreACT2.dialogue"))
		MusicPlayer.play_fake_music()

func _process(_delta: float) -> void:
	if Events.OneEvents == 1:
		anim.play("fade_out")
		Events.OneEvents = 0
	if Events.Cutscene and time_temp:
		time_temp = false
		pretime.start()

func _on_pre_act_2_time_timeout() -> void:
	anim.play("fade_out")
	Events.OneEvents = 0

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		if !Events.ACT2:
			if !beat_boss:
				Global.Boss = true
				get_tree().change_scene_to_file("res://Scenes/Combat/Battles/Act1/DragonBattle.tscn")
				MusicPlayer.stop_music()
			else:
				Global.Boss = false
				Events.Cutscene = false
				get_tree().change_scene_to_file("res://Scenes/Areas/fakeending.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/Combat/Battles/Act2/FinalCombat.tscn")
			MusicPlayer.stop_music()
	if anim_name == "fade_in":
		if Events.ACT2:
			glitch.play()
			$GlitchSFX.play()
			Events.ACT2 = false
			_playerstart()
			swap_parties = true

func _playerstart():
	if !Events.ACT2:
		if Events.OneEvents != 6:
			party.position = party_base_pos.position
			player.position = Global.TEHOM
	else:
		party.position = Global.TEHOM
		player.position = player_base_pos.position
		if swap_parties:
			player.position = post_swap.position
		Events.Narrator = true


func _on_party_swap_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and swap_parties:
		glitch.play()
		$GlitchSFX.play()
		Events.ACT2 = true
		_playerstart()
		party_swap.queue_free()
		#party.queue_free()
