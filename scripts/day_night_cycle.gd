extends Node3D

var time: float = 0
var time_rate: float

var sun: DirectionalLight3D
var moon: DirectionalLight3D
var environment: WorldEnvironment
var time_system: TimeSystem

@export var sun_colour: Gradient
@export var sun_intensity: Curve
@export var moon_colour: Gradient
@export var moon_intensity: Curve
@export var sky_top_colour: Gradient
@export var sky_horizon_colour: Gradient

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sun = get_node("Sun")
	moon = get_node("Moon")
	environment = get_node("WorldEnvironment")
	time_system = get_node("TimeSystem")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sun.rotation_degrees.x = time_system.date_time.time_scaled * 360 + 90
	sun.light_color = sun_colour.sample(time_system.date_time.time_scaled)
	sun.light_energy = sun_intensity.sample(time_system.date_time.time_scaled)
	
	moon.rotation_degrees.x = time_system.date_time.time_scaled * 360 + 270
	moon.light_color = moon_colour.sample(time_system.date_time.time_scaled)
	moon.light_energy = moon_intensity.sample(time_system.date_time.time_scaled)
	
	sun.visible = sun.light_energy > 0
	moon.visible = moon.light_energy > 0
	
	environment.environment.sky.sky_material.set("sky_top_color", sky_top_colour.sample(time_system.date_time.time_scaled))
	environment.environment.sky.sky_material.set("sky_horizon_color", sky_horizon_colour.sample(time_system.date_time.time_scaled))
	environment.environment.sky.sky_material.set("ground_bottom_color", sky_top_colour.sample(time_system.date_time.time_scaled))
	environment.environment.sky.sky_material.set("gound_horizon_color", sky_horizon_colour.sample(time_system.date_time.time_scaled))
