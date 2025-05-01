extends Area2D

@export var AreaToFade: String
@onready var collision: CollisionShape2D = $Collision
@onready var fade: AnimationPlayer = $Fade

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		#collision.disabled = true
		Global.InDialogue = true
		fade.play("fade_out")


func _on_fade_animation_finished(_anim_name: StringName) -> void:
	match AreaToFade:
		"Room2":
			get_tree().change_scene_to_file("res://Scenes/Areas/room_2.tscn")
		"Room3":
			get_tree().change_scene_to_file("res://Scenes/Areas/room_3.tscn")
		"Room4":
			get_tree().change_scene_to_file("res://Scenes/Areas/room_4.tscn")
		"Room5":
			get_tree().change_scene_to_file("res://Scenes/Areas/room_5.tscn")
		"Room6":
			get_tree().change_scene_to_file("res://Scenes/Areas/room_6.tscn")
		"Room7":
			get_tree().change_scene_to_file("res://Scenes/Areas/room_7.tscn")
		"Room8":
			get_tree().change_scene_to_file("res://Scenes/Areas/room_8.tscn")
		"Room9":
			get_tree().change_scene_to_file("res://Scenes/Areas/room_9.tscn")
		"RoomF":
			get_tree().change_scene_to_file("res://Scenes/Areas/room_F.tscn")
