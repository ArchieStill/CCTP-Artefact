extends Node2D

@onready var anim: AnimationPlayer = $Anim
@onready var party: CharacterBody2D = $Party
@onready var player: CharacterBody2D = $Player
#@onready var w1col: CollisionShape2D = $WaterBattle/Collision

func _ready() -> void:
	Global.InDialogue = false
	anim.play("fade_in")
	if Events.OneEvents == 5:
		#w1col.disabled = true
		Global.InDialogue = false
	_playerstart()

func _process(_delta: float) -> void:
	if Events.OneEvents == 1:
		anim.play("fade_out")
		Events.OneEvents = 0

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		if Events.ACT2:
			Events.Narrator = true
			DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorR5.dialogue"))
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://Scenes/Combat/Battles/Water/WaterBattle.tscn")

func _playerstart():
	if !Events.ACT2:
		party.show()
		player.queue_free()
	else:
		party.queue_free()
		player.show()
		Events.Narrator = true
