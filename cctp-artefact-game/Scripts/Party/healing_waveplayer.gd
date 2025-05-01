extends Sprite2D

@onready var p: AnimatedSprite2D = $P

func _process(_delta: float) -> void:
	if Stats.HealingWave:
		show()
		p.play()
		$HealingWaveSFX.play()
		Stats.HealingWave = false


func _on_p_animation_finished() -> void:
	hide()
