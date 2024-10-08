extends Node3D

@onready var action_ui: Control = $UI/ActionUI
@onready var action_button_1: TextureButton = $UI/ActionUI/ActionButton1
@onready var action_button_2: TextureButton = $UI/ActionUI/ActionButton2
@onready var action_button_3: TextureButton = $UI/ActionUI/ActionButton3
@onready var lbl_message_ab_1: RichTextLabel = $UI/ActionUI/ActionButton1/LblMessageAB1
@onready var lbl_message_ab_2: RichTextLabel = $UI/ActionUI/ActionButton2/LblMessageAB2
@onready var lbl_message_ab_3: RichTextLabel = $UI/ActionUI/ActionButton3/LblMessageAB3

var player: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = GameManager.player
	
	player.at_desk.connect(_on_player_at_desk)
	player.left_desk.connect(_on_player_left_desk)

	player.at_bookcase.connect(_on_player_at_bookcase)
	player.left_bookcase.connect(_on_player_left_bookcase)
	
	player.action_at_desk.connect(_on_player_action_at_desk)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_at_desk() -> void:
	lbl_message_ab_1.text = "[center][color=black]sit[/color][/center]"
	lbl_message_ab_2.text = "[center][color=black]water\nplant[/color][/center]"
	action_button_1.visible = true
	action_button_2.visible = true
	action_button_3.visible = false
	action_ui.visible = true

func _on_player_left_desk() -> void:
	lbl_message_ab_1.text = ""
	action_ui.visible = false

func _on_player_at_bookcase() -> void:
	lbl_message_ab_1.text = "[center][color=black]read[/color][/center]"
	lbl_message_ab_2.text = "[center][color=black]tidy[/color][/center]"
	action_button_1.visible = true
	action_button_2.visible = true
	action_button_3.visible = false
	action_ui.visible = true

func _on_player_left_bookcase() -> void:
	lbl_message_ab_1.text = ""
	action_ui.visible = false

func _on_player_action_at_desk() -> void:
	lbl_message_ab_1.text = "[center][color=black]work[/color][/center]"
	lbl_message_ab_2.text = "[center][color=black]social\nmedia[/color][/center]"
	lbl_message_ab_3.text = "[center][color=black]play[/color][/center]"
	action_button_1.visible = true
	action_button_2.visible = true
	action_button_3.visible = true
	action_ui.visible = true
