extends Node

@onready var OneEvents: int = 0
@onready var TwoEvents: int = 0
@onready var OneDeath: bool = false
@onready var TwoDeath: bool = false

@onready var ACT2: bool = true
@onready var Cutscene: bool = false
@onready var Narrator: bool = false

@onready var Room1Music: bool = false
@onready var GlitchMusic: bool = false
@onready var FinalStopMusic: bool = false

@onready var Final: bool = false
@onready var FinalFight: bool = false
@onready var FinalTalk: bool = false
@onready var FinalTNum: int = 1
@onready var FinalTOnce: bool = true

@onready var FinalEvents: int = 0
@onready var FinalControls: bool = true
@onready var FinalDialoguePersist: bool = true


func _process(_delta: float) -> void:
	if ACT2:
		Global.PartyTurn = 7
