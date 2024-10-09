extends Node

var player : Player
var desk_chair : Node3D
var lounge_sofa : Node3D

func set_lounge_sofa(sofa_node) -> void:
	lounge_sofa = sofa_node

func set_desk_chair(chair_node) -> void:
	desk_chair = chair_node
	
func set_player(player_node) -> void:
	player = player_node
