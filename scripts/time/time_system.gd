class_name TimeSystem extends Node

signal updated

@export var date_time: DateTime
@export var ticks_per_second: int = 3000
@export var ticks_increase_rate: int = 120

var min_ticks: int = 120
var max_ticks: int = 1200
var rate: int = 1

func _process(_delta: float) -> void:
	date_time.increase_by_sec(_delta * ticks_per_second)
	updated.emit(date_time, rate)

func _increase_ticks_per_second() -> void:
	ticks_per_second += ticks_increase_rate
	rate += 1
	
	if ticks_per_second > max_ticks:
		ticks_per_second = max_ticks
		rate -= 1
	
func _decrease_ticks_per_second() -> void:
	ticks_per_second -= ticks_increase_rate
	rate -= 1
	
	if ticks_per_second < min_ticks:
		ticks_per_second = min_ticks
		rate = 1


func _on_time_ui_speed_up() -> void:
	_increase_ticks_per_second()


func _on_time_ui_slow_down() -> void:
	_decrease_ticks_per_second()
