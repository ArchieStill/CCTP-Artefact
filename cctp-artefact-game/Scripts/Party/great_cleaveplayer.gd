extends AnimatedSprite2D

func _process(_delta: float) -> void:
	if Stats.GCPlayer:
		show()
		play()

func _on_animation_finished() -> void:
	hide()
	Stats.GCPlayer = false
