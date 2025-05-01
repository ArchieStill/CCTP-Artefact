extends Control

@export var base_bg: Color
@export var transparent: Color
@onready var color_rect: ColorRect = $ColorRect
@onready var anim: AnimationPlayer = $Anim
@onready var mouse_drag: Control = $MouseDrag
@onready var start_button: Button = $StartButton
@onready var credits_button: Button = $CreditsButton


func _process(_delta: float) -> void:
	if Events.ACT2:
		Global.Boss = false
		Events.GlitchMusic = false
		start_button.grab_focus()
		var mousepos = mouse_drag.position
		Input.warp_mouse(mousepos)
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			anim.play("fade_out")

func _on_start_button_pressed() -> void:
	anim.play("fade_out")

func _on_anim_animation_finished(anim_name: StringName) -> void:
	Events.Room1Music = false
	if anim_name == "fade_out":
		if !Events.ACT2:
			get_tree().change_scene_to_file("res://Scenes/Areas/story_intro.tscn")
		else:
			Events.Narrator = false
			get_tree().change_scene_to_file("res://Scenes/Areas/story_intro2.tscn")


func _on_credits_button_pressed() -> void:
	if !Events.ACT2:
		get_tree().change_scene_to_file("res://Scenes/asset_credits.tscn")
	else:
		pass
