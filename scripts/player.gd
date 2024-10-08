class_name Player extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $"Visuals/character-male-f2/AnimationPlayer"
@onready var visuals: Node3D = $Visuals
@onready var camera_point: Node3D = $CameraPoint

enum LOCATION {WANDER, DESK, BOOKCASE}

const SPEED = 2.0
const JUMP_VELOCITY = 4.5

var is_walking: bool = false
var location: LOCATION = LOCATION.WANDER

signal at_desk
signal left_desk
signal at_bookcase
signal left_bookcase

signal action_at_desk

func _ready() -> void:
	GameManager.set_player(self)
	animation_player.set_blend_time("idle", "walk", 0.2)
	animation_player.set_blend_time("walk", "idle", 0.2)
	#pass
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
		visuals.look_at(direction + position)
		
		if not is_walking:
			is_walking = true
			animation_player.play("walk")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		if is_walking:
			is_walking = false
			animation_player.play("idle")

	move_and_slide()


func _on_detection_area_body_entered(body: Node3D) -> void:
	if body.is_in_group("desk"):
		location = LOCATION.DESK
		at_desk.emit()
	
	if body.is_in_group("bookcase"):
		location = LOCATION.BOOKCASE
		at_bookcase.emit()


func _on_detection_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("desk"):
		location = LOCATION.WANDER
		left_desk.emit()
	
	if body.is_in_group("bookcase"):
		location = LOCATION.WANDER
		left_bookcase.emit()


func _on_action_button_1_pressed() -> void:
	if location == LOCATION.DESK:
		animation_player.play("sit")
		position = GameManager.desk_chair.sit_point.global_position
		visuals.look_at(GameManager.desk_chair.look_point.global_position)
		action_at_desk.emit()
		


#avatar code:
#MTowOjAvMDowOjAvNDowOjAvNTowOjAvMDowOjAvMTowOjAvMTA6MDowLzA6MDowLzA6MDowLzA6MDowLzA6MDowLzA6MDowL3wwOi0xLzE6MTUvMjo1LzM6LTEvNDotMS81Oi0xLzY6LTEvNzotMS84Oi0xLw==
