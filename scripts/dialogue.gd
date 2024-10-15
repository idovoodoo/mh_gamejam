extends Control

@export_file("*.json") var self_thoughts_file
@export_file("*.json") var news_articles_file
@export_file("*.json") var text_messages_file
@export_file("*.json") var phone_calls_file

@onready var message: RichTextLabel = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/Message

var self_thoughts = []
var text_messages = []

func _ready() -> void:
	load_json()
	update_dialogue()

func update_dialogue() -> void:
	message.text = ""
	pass
	
func load_json() -> void:
	var file = FileAccess.open(self_thoughts_file, FileAccess.READ)
	self_thoughts = JSON.parse_string(file.get_as_text())
	
	file = FileAccess.open(text_messages_file, FileAccess.READ)
	text_messages = JSON.parse_string(file.get_as_text())
