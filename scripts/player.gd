class_name Player extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $"Visuals/character-male-f2/AnimationPlayer"
@onready var visuals: Node3D = $Visuals
@onready var camera_point: Node3D = $CameraPoint
@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var stat_system: StatSystem = $"../StatManager/StatSystem"

@onready var stat_label: RichTextLabel = $Visuals/StatLabel
@onready var anim_player: AnimationPlayer = $AnimationPlayer

enum LOCATION {WANDER, DESK, BOOKCASE, LOUNGE}

const SPEED = 2.0
const JUMP_VELOCITY = 4.5

var stat_text_queue: Array
var message_finished: bool = true
var STAT: StatSystem.MH_STAT

var is_walking: bool = false
var location: LOCATION = LOCATION.WANDER

signal at_desk
signal left_desk
signal at_bookcase
signal left_bookcase
signal at_lounge
signal left_lounge

signal action_at_desk
signal action_at_lounge

func _ready() -> void:
	GameManager.set_player(self)
	animation_player.set_blend_time("idle", "walk", 0.2)
	animation_player.set_blend_time("walk", "idle", 0.2)
	stat_label.visible = false
	#pass

func _process(delta: float) -> void:
	if stat_text_queue.size() > 0:
		if message_finished:
			message_finished = false
			var stat_text = stat_text_queue.pop_front()
			if stat_text == "anxiety" or stat_text == "depression" or stat_text == "stress":
				stat_label.text = "[color=red]" + stat_text
			elif stat_text == "social" or stat_text == "leisure" or stat_text == "rested":
				stat_label.text = "[color=green]" + stat_text
			anim_player.play("stat_text")
	pass


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
			collision_shape_3d.disabled = false
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
	
	if body.is_in_group("lounge"):
		location = LOCATION.LOUNGE
		at_lounge.emit()


func _on_detection_area_body_exited(body: Node3D) -> void:
	if body.is_in_group("desk"):
		location = LOCATION.WANDER
		left_desk.emit()
	
	if body.is_in_group("bookcase"):
		location = LOCATION.WANDER
		left_bookcase.emit()

	if body.is_in_group("lounge"):
		location = LOCATION.WANDER
		left_lounge.emit()

func _on_action_button_1_pressed() -> void:
	if location == LOCATION.DESK:
		animation_player.play("sit")
		position = GameManager.desk_chair.sit_point.global_position
		visuals.look_at(GameManager.desk_chair.look_point.global_position)
		
		#stat_system.add_anxiety_stat()
		#STAT = StatSystem.MH_STAT.ANXIETY
		#add_stat_text(STAT)
		stat_system.add_social_stat()
		STAT = StatSystem.MH_STAT.SOCIAL
		add_stat_text(STAT)
		stat_system.add_depression_stat()
		STAT = StatSystem.MH_STAT.DEPRESSION
		add_stat_text(STAT)
		
		action_at_desk.emit()
	elif location == LOCATION.LOUNGE:
		animation_player.play("sit")
		position = GameManager.lounge_sofa.sit_point.global_position
		visuals.look_at(GameManager.lounge_sofa.look_point.global_position)
		action_at_lounge.emit()


func add_stat_text(_value: int) -> void:
	var label_text: String = ""

	match _value:
		0: label_text = "anxiety"
		1: label_text = "depression"
		2: label_text = "stress"
		3: label_text = "social"
		4: label_text = "leisure"
		5: label_text = "rested"
		
	stat_text_queue.append(label_text)
	
#avatar code:
#MTowOjAvMDowOjAvNDowOjAvNTowOjAvMDowOjAvMTowOjAvMTA6MDowLzA6MDowLzA6MDowLzA6MDowLzA6MDowLzA6MDowL3wwOi0xLzE6MTUvMjo1LzM6LTEvNDotMS81Oi0xLzY6LTEvNzotMS84Oi0xLw==


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	message_finished = true
