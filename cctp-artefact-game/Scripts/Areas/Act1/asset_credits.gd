extends Control

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/title.tscn")



func _on_cc_link_pressed() -> void:
	OS.shell_open("https://www.reddit.com/r/fireemblem/comments/7l6wuk/i_love_gba_fire_emblem_spritesportraits_so_i_made/")


func _on_spoiler_link_pressed() -> void:
	OS.shell_open("https://rvros.itch.io/animated-pixel-hero")


func _on_cave_link_pressed() -> void:
	OS.shell_open("https://opengameart.org/content/cave-tileset-0")


func _on_skeleton_link_pressed() -> void:
	OS.shell_open("https://opengameart.org/content/js-monster-pack-4-ascent")


func _on_effects_link_pressed() -> void:
	OS.shell_open("https://opengameart.org/content/magic-effects")


func _on_effects_link_2_pressed() -> void:
	OS.shell_open("https://opengameart.org/content/arcane-magic-effect")


func _on_font_link_pressed() -> void:
	OS.shell_open("https://caffinate.itch.io/abaddon")
