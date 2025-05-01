extends Control

@onready var mp_bar: ProgressBar = $MPBar
@onready var mp_num: Label = $MPBar/MPNum


func _process(_delta: float) -> void:
	mp_bar.value = Stats.MP
	mp_num.text = str(Stats.MP) + "/8"
	if Stats.MP > 8:
		Stats.MP = 8
