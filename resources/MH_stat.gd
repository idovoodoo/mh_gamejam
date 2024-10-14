class_name MHStat extends Resource

@export_range(0, 99) var value
@export_range(-20, 20) var effect_on_mh: float = -5.0
@export_range(1, 5) var effect_on_mh_scale: float = 1.0
@export_range(-20, 20) var effect_on_energy: float = -5.0
@export_range(1, 5) var effect_on_energy_scale: float = 1.0
@export_range(-20, 20) var effect_on_prod: float = -5.0
@export_range(1, 5) var effect_on_prod_scale: float = 1.0
