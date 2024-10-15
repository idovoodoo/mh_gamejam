class_name PhoneMessage
extends HBoxContainer

@onready var left_spacer: Control = $LeftSpacer
@onready var right_spacer: Control = $RightSpacer
@onready var message_bubble: MarginContainer = $MessageBubble
@onready var rich_text_label: RichTextLabel = $MessageBubble/RichTextLabel

@export var sender_colour: Color = Color.GRAY
@export var player_colour: Color = Color.DODGER_BLUE

var message: String = ""
var from: String = ""

func _ready() -> void:
	# Default spacer settings (both expand to center the message)
	left_spacer.size_flags_horizontal = Control.SIZE_EXPAND
	right_spacer.size_flags_horizontal = Control.SIZE_EXPAND

func set_message(_from: String, _message: String) -> void:
	message = _message
	from = _from
	rich_text_label.text = message
	set_alignment_and_style()

func set_alignment_and_style() -> void:
	var style_box = StyleBoxFlat.new()
	var text_color: Color
	var background_color: Color
	
	style_box.corner_radius_top_left = 15
	style_box.corner_radius_top_right = 15
		
	if from == "player":
		background_color = player_colour
		text_color = Color.WHITE
		
		# Align to the right
		left_spacer.size_flags_horizontal = Control.SIZE_EXPAND
		right_spacer.size_flags_horizontal = 0
		
		style_box.corner_radius_bottom_left = 15
		style_box.corner_radius_bottom_right = 0
		
	else:
		background_color = sender_colour
		text_color = Color.BLACK
		
		# Align to the left
		left_spacer.size_flags_horizontal = 0
		right_spacer.size_flags_horizontal = Control.SIZE_EXPAND
		
		style_box.corner_radius_bottom_left = 0
		style_box.corner_radius_bottom_right = 15

	# Create a StyleBoxFlat for the background
	style_box.bg_color = background_color
	style_box.content_margin_left = 10
	style_box.content_margin_right = 10
	style_box.content_margin_top = 5
	style_box.content_margin_bottom = 5

	# Apply the StyleBox to the 'normal' state of the RichTextLabel
	rich_text_label.add_theme_stylebox_override("normal", style_box)

	# Set text color
	rich_text_label.add_theme_color_override("default_color", text_color)
