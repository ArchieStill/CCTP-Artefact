extends Control

@onready var cont: Button = $Continue
@onready var anim: AnimationPlayer = $Anim
@onready var fot: Timer = $FadeOutTimer


func _on_scroll_animation_finished(_anim_name: StringName) -> void:
	cont.show()


func _on_continue_pressed() -> void:
	anim.play("fade_out")


func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		fot.start()


func _on_fade_out_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/Areas/room_1.tscn")
