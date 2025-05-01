extends Node2D

signal attack_area_triggered

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Attack"):
		if !area.is_in_group("Player"):
			emit_signal("attack_area_triggered")
