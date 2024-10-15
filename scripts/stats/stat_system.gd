class_name StatSystem extends Node

enum MH_STAT {ANXIETY, DEPRESSION, STRESS, SOCIAL, LEISURE, RESTED}

signal mh_changed
signal energy_changed
signal prod_changed

@export var anxiety_stat: MHStat
@export var depression_stat: MHStat
@export var stress_stat: MHStat
@export var social_support_stat: MHStat
@export var leisure_stat: MHStat
@export var rested_stat: MHStat

var mental_health_level: float = 20
var energy_level: float = 100
var productivity_level: float = 50


func _ready() -> void:
	update_levels()

func update_levels() -> void:
	GameManager.set_levels(mental_health_level, energy_level, productivity_level)


func add_anxiety_stat() -> void:
	mental_health_level += anxiety_stat.effect_on_mh * anxiety_stat.effect_on_mh_scale
	energy_level += anxiety_stat.effect_on_energy * anxiety_stat.effect_on_energy_scale
	productivity_level += anxiety_stat.effect_on_prod * anxiety_stat.effect_on_prod_scale

	update_all()

func add_depression_stat() -> void:
	mental_health_level += depression_stat.effect_on_mh * depression_stat.effect_on_mh_scale
	energy_level += depression_stat.effect_on_energy * depression_stat.effect_on_energy_scale
	productivity_level += depression_stat.effect_on_prod * depression_stat.effect_on_prod_scale
	
	update_all()

func add_stress_stat() -> void:
	mental_health_level += stress_stat.effect_on_mh * stress_stat.effect_on_mh_scale
	energy_level += stress_stat.effect_on_energy * stress_stat.effect_on_energy_scale
	productivity_level += stress_stat.effect_on_prod * stress_stat.effect_on_prod_scale
	
	update_all()

func add_social_stat() -> void:
	mental_health_level += social_support_stat.effect_on_mh * social_support_stat.effect_on_mh_scale
	energy_level += social_support_stat.effect_on_energy * social_support_stat.effect_on_energy_scale
	productivity_level += social_support_stat.effect_on_prod * social_support_stat.effect_on_prod_scale
	
	update_all()

func add_leisure_stat() -> void:
	mental_health_level += leisure_stat.effect_on_mh * leisure_stat.effect_on_mh_scale
	energy_level += leisure_stat.effect_on_energy * leisure_stat.effect_on_energy_scale
	productivity_level += leisure_stat.effect_on_prod * leisure_stat.effect_on_prod_scale
	
	update_all()

func add_rested_stat() -> void:
	mental_health_level += rested_stat.effect_on_mh * rested_stat.effect_on_mh_scale
	energy_level += rested_stat.effect_on_energy * rested_stat.effect_on_energy_scale
	productivity_level += rested_stat.effect_on_prod * rested_stat.effect_on_prod_scale
	
	update_all()

func update_all() -> void:
	mh_changed.emit(mental_health_level)
	energy_changed.emit(energy_level)
	prod_changed.emit(productivity_level)
