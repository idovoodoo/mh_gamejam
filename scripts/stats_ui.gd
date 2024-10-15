extends Control

@onready var mh_progress_bar: ProgressBar = $MentalHealthIndicator/MHProgressBar
@onready var energy_progress_bar: ProgressBar = $EnergyIndicator/EnergyProgressBar
@onready var prod_progress_bar: ProgressBar = $ProductivityIndicator/ProdProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("setting levels")
	mh_progress_bar.value = GameManager.mh_level
	energy_progress_bar.value = GameManager.energy_level
	prod_progress_bar.value = GameManager.prod_level


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func update_mh(_value) -> void:
	mh_progress_bar.value = _value
	#change colour of progress bar if < 0 or > 1

func update_energy(_value) -> void:
	energy_progress_bar.value = _value

func update_prod(_value) -> void:
	prod_progress_bar.value = _value


func _on_stat_system_mh_changed(_value) -> void:
	print("update mh here" + str(_value))
	update_mh(_value)


func _on_stat_system_energy_changed(_value) -> void:
	update_energy(_value)


func _on_stat_system_prod_changed(_value) -> void:
	update_prod(_value)
