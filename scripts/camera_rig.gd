extends Node3D

@onready var background_viewport: SubViewport = $BaseCamera/BackgroundViewportContainer/BackgroundViewport
@onready var foreground_viewport: SubViewport = $BaseCamera/ForegroundViewportContainer/ForegroundViewport

@onready var background_camera: Camera3D = $BaseCamera/BackgroundViewportContainer/BackgroundViewport/BackgroundCamera
@onready var foreground_camera: Camera3D = $BaseCamera/ForegroundViewportContainer/ForegroundViewport/ForegroundCamera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	background_camera.global_transform = GameManager.player.camera_point.global_transform
	foreground_camera.global_transform = GameManager.player.camera_point.global_transform

func resize() -> void:
	background_viewport.size = DisplayServer.window_get_size()
	foreground_viewport.size = DisplayServer.window_get_size()
