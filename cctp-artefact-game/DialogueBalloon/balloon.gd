extends CanvasLayer
## A basic dialogue balloon for use with Dialogue Manager.

## The action to use for advancing the dialogue
@export var next_action: StringName = &"ui_accept"

## The action to use to skip typing the dialogue
@export var skip_action: StringName = &"ui_cancel"

@export var Warrior_textcol: Color
@export var Mage_textcol: Color
@export var Cleric_textcol: Color
@export var Thief_textcol: Color
@export var Player_textcol: Color

@onready var balloon: Control = %Balloon
@onready var panel: Panel = $Balloon/Panel
@onready var character_label: RichTextLabel = %CharacterLabel
@onready var dialogue_label: DialogueLabel = %DialogueLabel
@onready var responses_menu: DialogueResponsesMenu = %ResponsesMenu
@onready var portrait: TextureRect = %Portrait

const defaultui = preload("res://Assets/Styles/Dialogue/defaultui.tres")
const entityui = preload("res://Assets/Styles/Dialogue/entityui.tres")


## The dialogue resource
var resource: DialogueResource

## Temporary game states
var temporary_game_states: Array = []

## See if we are waiting for the player
var is_waiting_for_input: bool = false

## See if we are running a long mutation and should hide the balloon
var will_hide_balloon: bool = false

var _locale: String = TranslationServer.get_locale()

## The current line
var dialogue_line: DialogueLine:
	set(next_dialogue_line):
		is_waiting_for_input = false
		balloon.focus_mode = Control.FOCUS_ALL
		balloon.grab_focus()

		# The dialogue has finished so close the balloon
		if not next_dialogue_line:
			queue_free()
			return

		# If the node isn't ready yet then none of the labels will be ready yet either
		if not is_node_ready():
			await ready

		dialogue_line = next_dialogue_line

		character_label.visible = not dialogue_line.character.is_empty()
		character_label.text = tr(dialogue_line.character, "dialogue")

		dialogue_label.hide()
		dialogue_label.dialogue_line = dialogue_line

		responses_menu.hide()
		responses_menu.set_responses(dialogue_line.responses)

		# Show our balloon
		_change_style()
		balloon.show()
		will_hide_balloon = false

		dialogue_label.show()
		if not dialogue_line.text.is_empty():
			dialogue_label.type_out()
			await dialogue_label.finished_typing

		# Wait for input
		if dialogue_line.responses.size() > 0:
			balloon.focus_mode = Control.FOCUS_NONE
			responses_menu.show()
		elif dialogue_line.time != "":
			var time = dialogue_line.text.length() * 0.02 if dialogue_line.time == "auto" else dialogue_line.time.to_float()
			await get_tree().create_timer(time).timeout
			next(dialogue_line.next_id)
		else:
			is_waiting_for_input = true
			balloon.focus_mode = Control.FOCUS_ALL
			balloon.grab_focus()
	get:
		return dialogue_line


func _ready() -> void:
	balloon.hide()
	Engine.get_singleton("DialogueManager").mutated.connect(_on_mutated)

	# If the responses menu doesn't have a next action set, use this one
	if responses_menu.next_action.is_empty():
		responses_menu.next_action = next_action


## MAIN STUFF
func _process(_delta: float) -> void:
	if character_label.text == "The Warrior":
		character_label.add_theme_color_override("default_color", Warrior_textcol)
		portrait.show()
		portrait.texture = load("res://Assets/Sprites/DialogueSprites/Warrior.png")
	elif character_label.text == "The Mage":
		character_label.add_theme_color_override("default_color", Mage_textcol)
		portrait.show()
		portrait.texture = load("res://Assets/Sprites/DialogueSprites/Mage.png")
	elif character_label.text == "The Cleric":
		character_label.add_theme_color_override("default_color", Cleric_textcol)
		portrait.show()
		portrait.texture = load("res://Assets/Sprites/DialogueSprites/Cleric.png")
	elif character_label.text == "The Thief":
		character_label.add_theme_color_override("default_color", Thief_textcol)
		portrait.show()
		portrait.texture = load("res://Assets/Sprites/DialogueSprites/Thief.png")
	elif character_label.text == "Player" or character_label.text == Global.player_name:
		character_label.text = Global.player_name
		character_label.add_theme_color_override("default_color",Player_textcol)
		portrait.show()
		portrait.texture = load("res://Assets/Sprites/DialogueSprites/PlayerC.png")
	else:
		character_label.remove_theme_color_override("default_color")
		portrait.texture = null
		portrait.hide()

func _change_style():
	if Events.Narrator:
		balloon.set_theme(entityui)
		panel.position = Vector2(21, 245) # 21, 235
		dialogue_label.add_theme_color_override("default_color", Color(225,0,0))
		dialogue_label.add_theme_color_override("font_outline_color", Color(155,155,155))
		dialogue_label.add_theme_constant_override("outline_size", 10)
		dialogue_label.add_theme_font_size_override("normal_font_size", 55)
		panel.self_modulate.a = 0
	else:
		balloon.set_theme(defaultui)
		panel.position = Vector2(21, 465)
		dialogue_label.remove_theme_color_override("default_color")
		dialogue_label.remove_theme_color_override("font_outline_color")
		dialogue_label.remove_theme_constant_override("outline_size")
		dialogue_label.add_theme_font_size_override("normal_font_size", 30)
		panel.self_modulate.a = 255

func _unhandled_input(_event: InputEvent) -> void:
	# Only the balloon is allowed to handle input while it's showing
	get_viewport().set_input_as_handled()


func _notification(what: int) -> void:
	## Detect a change of locale and update the current dialogue line to show the new language
	if what == NOTIFICATION_TRANSLATION_CHANGED and _locale != TranslationServer.get_locale() and is_instance_valid(dialogue_label):
		_locale = TranslationServer.get_locale()
		var visible_ratio = dialogue_label.visible_ratio
		self.dialogue_line = await resource.get_next_dialogue_line(dialogue_line.id)
		if visible_ratio < 1:
			dialogue_label.skip_typing()


## Start some dialogue
func start(dialogue_resource: DialogueResource, title: String, extra_game_states: Array = []) -> void:
	temporary_game_states =  [self] + extra_game_states
	is_waiting_for_input = false
	resource = dialogue_resource
	self.dialogue_line = await resource.get_next_dialogue_line(title, temporary_game_states)


## Go to the next line
func next(next_id: String) -> void:
	self.dialogue_line = await resource.get_next_dialogue_line(next_id, temporary_game_states)


#region Signals


func _on_mutated(_mutation: Dictionary) -> void:
	is_waiting_for_input = false
	will_hide_balloon = true
	get_tree().create_timer(0.1).timeout.connect(func():
		if will_hide_balloon:
			will_hide_balloon = false
			balloon.hide()
	)


func _on_balloon_gui_input(event: InputEvent) -> void:
	# See if we need to skip typing of the dialogue
	if !Events.Narrator:
		if dialogue_label.is_typing:
			var mouse_was_clicked: bool = event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()
			var skip_button_was_pressed: bool = event.is_action_pressed(skip_action)
			if mouse_was_clicked or skip_button_was_pressed:
				get_viewport().set_input_as_handled()
				dialogue_label.skip_typing()
				return

		if not is_waiting_for_input: return
		if dialogue_line.responses.size() > 0: return

		# When there are no response options the balloon itself is the clickable thing
		get_viewport().set_input_as_handled()

		if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			next(dialogue_line.next_id)
		elif event.is_action_pressed(next_action) and get_viewport().gui_get_focus_owner() == balloon:
			next(dialogue_line.next_id)

func _on_narrator_timer_timeout() -> void:
	if Events.FinalDialoguePersist:
		next(dialogue_line.next_id)


func _on_responses_menu_response_selected(response: DialogueResponse) -> void:
	next(response.next_id)


#endregion


func _on_dialogue_label_spoke(letter: String, _letter_index: int, _speed: float) -> void:
	if not letter in [" "]:
		if !Events.Narrator:
			if character_label.text == "The Mage":
				var mage_sfx = $MageSFX
				mage_sfx.pitch_scale = randf_range(1.1, 1.2)
				mage_sfx.play()
			elif character_label.text == "The Warrior":
				var warrior_sfx = $WarriorSFX
				warrior_sfx.pitch_scale = randf_range(0.5, 0.6)
				warrior_sfx.play()
			elif character_label.text == "The Cleric":
				var cleric_sfx = $ClericSFX
				cleric_sfx.pitch_scale = randf_range(0.6, 0.7)
				cleric_sfx.play()
			elif character_label.text == "The Thief":
				var thief_sfx = $ThiefSFX
				thief_sfx.pitch_scale = randf_range(1.3, 1.4)
				thief_sfx.play()
			elif character_label.text == "Player" or character_label.text == Global.player_name:
				var player_sfx = $PlayerSFX
				player_sfx.pitch_scale = randf_range(0.95, 1.05)
				player_sfx.play()
			else:
				var player_sfx = $PlayerSFX
				player_sfx.pitch_scale = randf_range(0.95, 1.05)
				player_sfx.play()
		else:
			var narrator_sfx = $NarratorSFX
			narrator_sfx.pitch_scale = randf_range(0.9, 1.1)
			narrator_sfx.play()
