extends Control

@onready var class_abilities: Label = $ClassAbilities

func _process(_delta: float) -> void:
	class_abilities.text = "Beat the game, " + Global.player_name + "."


func _on_button_pressed() -> void:
	Events.FinalControls = false
	hide()
