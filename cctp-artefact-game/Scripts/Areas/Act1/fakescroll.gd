extends Control

@onready var text: Label = $Text
@onready var anim: AnimationPlayer = $Anim
@onready var scroll: AnimationPlayer = $Scroll
@onready var wait_timer: Timer = $WaitTimer
@onready var glitch: VideoStreamPlayer = $Glitch
@onready var glitch_timer: Timer = $GlitchTimer
@onready var grey: ColorRect = $Grey


func _process(_delta: float) -> void:
	if Events.TwoEvents == 2:
		text.hide()
		grey.hide()
		Events.TwoEvents = 0
	if Events.TwoEvents == 3:
		glitch.play()
		$GlitchSFX.play()
		glitch_timer.start()
		Events.TwoEvents = 0

func _on_scroll_animation_finished(anim_name: StringName) -> void:
	if anim_name == "scroll":
		wait_timer.start()
		MusicPlayer.stop_music()
		grey.show()

func _on_wait_timer_timeout() -> void:
	Events.Narrator = true
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorIntro.dialogue"))

func _on_glitch_timer_timeout() -> void:
	Events.ACT2 = true
	Global.Boss = false
	get_tree().change_scene_to_file("res://Scenes/title.tscn")


func _on_glitch_sfx_finished() -> void:
	$GlitchSFX.play()
