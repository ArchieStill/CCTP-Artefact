extends AnimatedSprite2D


func _process(_delta: float) -> void:
	if Stats.ManaSurge:
		show()
		play()
		$ManaSurgeSFX.play()

func _on_animation_finished() -> void:
	hide()
	#Stats.ManaSurge = false
