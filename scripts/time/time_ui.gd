extends Control

@onready var lbl_day: Label = $DayControl/LblDay
@onready var lbl_time_hour: Label = $ClockControl/LblTimeHour
@onready var lbl_time_minute: Label = $ClockControl/LblTimeMinute
@onready var lbl_rate: Label = $LblRate
@onready var sfxui: AudioStreamPlayer2D = $SFXUI

signal speed_up
signal slow_down

func _on_time_system_updated(_date_time: DateTime, _rate: int) -> void:
	_update_label(lbl_day, _date_time.days, false)
	_update_label(lbl_time_hour, _date_time.hours)
	_update_label(lbl_time_minute, _date_time.minutes)
	lbl_time_hour.text = lbl_time_hour.text + ":"
	lbl_rate.text = "x" + str(_rate)
	
	if _rate == 1:
		lbl_rate.visible = false
	else:
		lbl_rate.visible = true

func _add_leading_zero(_label: Label, _value: int) -> void:
	if _value < 10:
		_label.text += "0"
		

func _update_label(_label: Label, _value: int, _should_have_zero: bool = true) -> void:
	_label.text = ""
	
	if _should_have_zero:
		_add_leading_zero(_label, _value)
		
	_label.text += str(_value)


func _on_button_speed_up_pressed() -> void:
	sfxui.play()
	speed_up.emit()


func _on_button_slow_down_pressed() -> void:
	sfxui.play()
	slow_down.emit()
