extends CharacterBody3D

const SPEED := 5.0
const JUMP_VELOCITY := 7.0

var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")
var scaled_down := false
@onready var pivot: Node3D = $Pivot
@onready var camera: Camera3D = $Pivot/Camera3D
#@onready var animation_player: AnimationPlayer = $AnimationPlayer  # Adjust if path differs

var mouse_sensitivity := 0.003
var rotation_x := 0.0  # Pitch (vertical look) 
var rotation_y := 0.0  # Yaw (horizontal turn)

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_y -= event.relative.x * mouse_sensitivity
		rotation_x -= event.relative.y * mouse_sensitivity
		rotation_x = clamp(rotation_x, deg_to_rad(-80), deg_to_rad(80))
		rotation.y = rotation_y
		pivot.rotation.x = rotation_x
	if event.is_action_pressed("scale_toggle"):
		toggle_scale()
func toggle_scale():
	if scaled_down:
		scale = Vector3.ONE  # default scale (1,1,1)
	else:
		scale = Vector3.ONE * 0.1  # scale up -1.5x
	scaled_down = !scaled_down

func _physics_process(delta: float) -> void:
	var input_direction = Vector3.ZERO

	if Input.is_action_pressed("Forward"):
		input_direction.z -= 1
	if Input.is_action_pressed("Backward"):
		input_direction.z += 1
	if Input.is_action_pressed("Left"):
		input_direction.x -= 1
	if Input.is_action_pressed("Right"):
		input_direction.x += 1

	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized()
		var direction = (global_transform.basis * input_direction).normalized()
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0

	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
			#if animation_player:
				#animation_player.play("up")
		else:
			velocity.y = 0
	else:
		velocity.y -= GRAVITY * delta

	move_and_slide()
