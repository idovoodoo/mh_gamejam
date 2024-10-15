# Phone.gd
class_name Phone
extends Control

@onready var message_container: VBoxContainer = $Bezel/Screen/ScrollContainer/MessageContainer
@onready var scroll_container: ScrollContainer = $Bezel/Screen/ScrollContainer

var messages = []
var current_message_index = 0
var phone_message_scene = preload("res://scenes/phone_message.tscn")

func _ready():
	# Define the messages
	messages = [
		{"from": "sender", "message": "Hello! How are you?"},
		{"from": "player", "message": "I'm good, thanks! You?"},
		{"from": "sender", "message": "Doing great, thanks for asking."}
	]

	# Connect the input event
	set_process_input(true)

	# Optionally, display the first message
	display_next_message()

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		display_next_message()

func display_next_message():
	if current_message_index < messages.size():
		var message_data = messages[current_message_index]
		add_message(message_data["from"], message_data["message"])
		current_message_index += 1
	else:
		# No more messages
		#print("All messages displayed.")
		pass

func add_message(_from: String, _message: String):
	var phone_message = phone_message_scene.instantiate()
	message_container.add_child(phone_message)
	phone_message.set_message(_from, _message)
	call_deferred("scroll_to_bottom")
	#print("Total messages:", message_container.get_child_count())

func scroll_to_bottom():
	scroll_container.scroll_vertical = scroll_container.get_v_scroll_bar().max_value
