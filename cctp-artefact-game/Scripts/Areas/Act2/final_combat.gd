extends Node2D

@onready var glitch: VideoStreamPlayer = $Glitch
@onready var dragon: Node2D = $FinalGroup/Group/Dragon
@onready var time_for_n: Timer = $Timers/TimeForN
@onready var time_for_p: Timer = $Timers/TimeForP

@onready var crack_1: Sprite2D = $Cracks/Crack1
@onready var crack_2: Sprite2D = $Cracks/Crack2
@onready var crack_3: Sprite2D = $Cracks/Crack3
@onready var crack_4: Sprite2D = $Cracks/Crack4

@onready var switch_timer: Timer = $Timers/SwitchTimer
@onready var player_final: CharacterBody2D = $PlayerFinal
@onready var old_player: AnimatedSprite2D = $PlayerGroup/Player/AnimatedSprite2D
@onready var attack_button: Button = $PlayerGroup/Player/ActionPane/Attack
@onready var controls_timer: Timer = $Timers/ControlsTimer
@onready var control_glitch: VideoStreamPlayer = $ControlGlitch
@onready var final_tips: Control = $CanvasLayer/FinalTips
@onready var exit: Node2D = $Exit
@onready var hp_bar_coll: CollisionShape2D = $HPBarColl/CollisionShape2D
@onready var text_coll: CollisionShape2D = $TextColl/CollisionShape2D
@onready var exit_timer: Timer = $Timers/ExitTimer
@onready var glitch_sfx: AudioStreamPlayer = $GlitchSFX

@onready var PlayerAttacking: bool = false


func _ready() -> void:
	exit.connect("attack_area_triggered", _exit_attacked)
	Events.ACT2 = 2
	Global.Boss = true
	Events.Narrator = true
	Events.Final = true

func _on_dragon_despawn_timeout() -> void:
	glitch.play()
	glitch_sfx.play()
	Events.FinalStopMusic = true
func _on_glitch_finished() -> void:
	glitch.queue_free()
	dragon.hide()
	time_for_n.start()
func _on_time_for_n_timeout() -> void:
	DialogueManager.show_dialogue_balloon(load("res://Dialogue/Narrator/NarratorDragon.dialogue"))


func _process(_delta: float) -> void:
	#print(PlayerAttacking)
	if Events.TwoEvents == 50:
		time_for_p.start()
		Events.TwoEvents = 0
	
	if Events.FinalEvents == 1:
		crack_1.show()
		Events.FinalEvents = 0
	if Events.FinalEvents == 2:
		crack_2.show()
		crack_3.show()
		Events.FinalEvents = 0
	if Events.FinalEvents == 3:
		crack_4.show()
		switch_timer.start()
		attack_button.disabled = true
		Events.FinalEvents = 0

func _on_time_for_p_timeout() -> void:
	Events.Final = false
	Events.FinalFight = true

func _on_switch_timer_timeout() -> void:
	_changegame()

func _changegame():
	player_final.position = Vector2(165, 329)
	player_final.show()
	old_player.hide()
	controls_timer.start()

func _on_controls_timer_timeout() -> void:
	control_glitch.play()
	glitch_sfx.play()
func _on_control_glitch_finished() -> void:
	final_tips.show()
	MusicPlayer.play_finale()
	exit.show()

func _on_entity_bounds_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		hp_bar_coll.set_deferred("disabled", false)
		text_coll.set_deferred("disabled", false)

func _exit_attacked():
	$CritSFX.play()
	exit_timer.start()
func _on_exit_timer_timeout() -> void:
	Events.FinalDialoguePersist = true
	get_tree().change_scene_to_file("res://Scenes/Areas/final_glitch.tscn")

#func _on_player_final_start_attacking() -> void:
	#PlayerAttacking = true
	#print("Start")
#func _on_player_final_stop_attacking() -> void:
	#PlayerAttacking = false
	#print("Stop")
