extends Area2D

@export var Dialogue: String
@onready var collision: CollisionShape2D = $Collision

func _ready() -> void:
	if !Events.ACT2:
		collision.disabled = true
	else:
		collision.disabled = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#Global.InDialogue = true
		Events.Narrator = true
		match Dialogue:
			"Room1":
				DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorR1.dialogue"))
			"Room3":
				DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorR3.dialogue"))
			"Room7":
				DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorR7.dialogue"))
			"FINAL":
				#Events.FinalDialoguePersist = false
				DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorFight6.dialogue"))

func _on_body_exited(_body: Node2D) -> void:
	position = Global.TEHOM
