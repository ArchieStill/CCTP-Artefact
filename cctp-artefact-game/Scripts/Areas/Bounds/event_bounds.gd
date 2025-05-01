extends Area2D

@export var Dialogue: String

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if !Events.ACT2:
			Global.InDialogue = true
			Events.Narrator = false
			match Dialogue:
				"Battle1":
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Battle1.dialogue"))
				"Battle2":
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Battle2.dialogue"))
				"Battle3":
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Battle3.dialogue"))
				"Battle4":
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Battle4.dialogue"))
				"PreDragon":
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/PreDragon.dialogue"))
				"Dragon":
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Dragon.dialogue"))

				"Info":
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/Info.dialogue"))
				"PreACT2":
					DialogueManager.show_dialogue_balloon(load("res://Dialogue/PreACT2.dialogue"))
		else:
			Global.InDialogue = true
			match Dialogue:
				"Battle1":
					Events.OneEvents = 1
					Global.Battle = "Battle1"
				"Battle2":
					Events.OneEvents = 1
					Global.Battle = "Battle2"
				"Battle3":
					Events.OneEvents = 1
					Global.Battle = "Battle3"
				"Battle4":
					Events.OneEvents = 1
					Global.Battle = "Battle4"
				"Dragon":
					Events.OneEvents = 1
					Global.Battle = "Dragon"


func _on_body_exited(_body: Node2D) -> void:
	position = Global.TEHOM
