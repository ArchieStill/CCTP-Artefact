extends Node

@onready var player_name: String = "Archie"
@onready var name_caps: String

@onready var PartyTurn: int = 0
@onready var PlayerTurn: int = 0
@onready var EnemyTurn: int = 5
@onready var EnemyOnce: bool = true
@onready var EnemyCount: int = 0
@onready var CombatOver: bool = false

@onready var Attacking: bool = false
@onready var PlayAttack: bool = false
@onready var HideActions: bool = false

@onready var InDialogue: bool = true
@onready var Battle: String
@onready var Boss: bool = false
@onready var FiveEnemy: bool = false
@onready var ShowFives: bool = false

static var TEHOM: Vector2 = Vector2(-1000,-1000)
@onready var UI: Control

func _ready() -> void:
	name_caps = player_name.to_upper()
