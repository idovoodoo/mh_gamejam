extends Node3D

@onready var sit_point: Node3D = $SitPoint
@onready var look_point: Node3D = $LookPoint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.set_desk_chair(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
