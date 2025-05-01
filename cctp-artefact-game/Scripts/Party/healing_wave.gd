extends Sprite2D

@onready var m: AnimatedSprite2D = $M
@onready var w: AnimatedSprite2D = $W
@onready var c: AnimatedSprite2D = $C
@onready var t: AnimatedSprite2D = $T

func _process(_delta: float) -> void:
	if Stats.HealingWave:
		show()
		m.play()
		w.play()
		c.play()
		t.play()
		$HealingWaveSFX.play()
		Stats.HealingWave = false

func _on_m_animation_finished() -> void:
	hide()
