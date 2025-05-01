extends Control

@onready var glitch: VideoStreamPlayer = $Glitch
@onready var music: AudioStreamPlayer = $Music



func _on_scroll_animation_finished(_anim_name: StringName) -> void:
	music.stop()
	glitch.play()
	$GlitchSFX.play()

func _on_glitch_finished() -> void:
	Global.InDialogue = true
	get_tree().change_scene_to_file("res://Scenes/Areas/room_1.tscn")


func _on_t_1_timeout() -> void:
	music.stop()
	music.play()
func _on_t_2_timeout() -> void:
	music.stop()
	music.play()
func _on_t_3_timeout() -> void:
	music.stop()
	music.play()
func _on_t_4_timeout() -> void:
	music.stop()
	music.play()
func _on_t_5_timeout() -> void:
	music.stop()
	music.play()
func _on_t_6_timeout() -> void:
	music.stop()
	music.play()
func _on_t_7_timeout() -> void:
	music.stop()
	music.play()
func _on_t_8_timeout() -> void:
	music.stop()
	music.play()
func _on_t_9_timeout() -> void:
	music.stop()
	music.play()
func _on_t_10_timeout() -> void:
	music.stop()
	music.play()
func _on_t_11_timeout() -> void:
	music.stop()
	music.play()
func _on_t_12_timeout() -> void:
	music.stop()
	music.play()
func _on_t_13_timeout() -> void:
	music.stop()
	music.play()
func _on_t_14_timeout() -> void:
	music.stop()
	music.play()
func _on_t_15_timeout() -> void:
	music.stop()
	music.play()
func _on_t_16_timeout() -> void:
	music.stop()
	music.play()
func _on_t_17_timeout() -> void:
	music.stop()
	music.play()
func _on_t_18_timeout() -> void:
	music.stop()
	music.play()
func _on_t_19_timeout() -> void:
	music.stop()
	music.play()
