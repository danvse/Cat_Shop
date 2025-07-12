extends CharacterBody3D

const SPEED := 5.0

func _physics_process(delta: float) -> void:
	var input_direction = Vector3.ZERO

	# Get input
	if Input.is_action_pressed("Forward"):
		input_direction.z -= 1
	if Input.is_action_pressed("Backward"):
		input_direction.z += 1
	if Input.is_action_pressed("Left"):
		input_direction.x -= 1
	if Input.is_action_pressed("Right"):
		input_direction.x += 1

	# Only move if there's input
	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized()

		# Transform input direction from local to global space
		var direction = (global_transform.basis * input_direction).normalized()

		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()

	
@onready var pivot: Node3D = $Pivot
@onready var camera: Camera3D = $Pivot/Camera3D

var mouse_sensitivity := 0.003
var rotation_x := 0.0  # Pitch
var rotation_y := 0.0  # Yaw

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Update yaw and pitch
		rotation_y -= event.relative.x * mouse_sensitivity
		rotation_x -= event.relative.y * mouse_sensitivity

		# Clamp pitch so we don't flip
		rotation_x = clamp(rotation_x, deg_to_rad(-80), deg_to_rad(80))

		# Apply rotations
		rotation.y = rotation_y  # Horizontal turning (player body)
		pivot.rotation.x = rotation_x  # Vertical look (camera)
