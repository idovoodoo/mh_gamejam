extends Node

var player : Player
var desk_chair : Node3D
var lounge_sofa : Node3D
var mh_level : float
var energy_level : float
var prod_level : float

func set_lounge_sofa(_sofa_node) -> void:
	lounge_sofa = _sofa_node

func set_desk_chair(_chair_node) -> void:
	desk_chair = _chair_node
	
func set_player(_player_node) -> void:
	player = _player_node

func set_levels(_mh, _nrg, _prod) -> void:
	mh_level = _mh
	energy_level = _nrg
	prod_level = _prod

func set_mh_level(_value) -> void:
	mh_level = _value

func set_energy_level(_value) -> void:
	energy_level = _value

func set_prod_level(_value) -> void:
	prod_level = _value
