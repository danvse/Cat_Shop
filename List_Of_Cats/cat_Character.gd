extends CharacterBody3D
@onready var cat_sprite = $AnimatedSprite3D
@export var speed := 2.0
@onready var nav_agent = $NavigationAgent3D
@export var hiding_spots: Array[NodePath]

@export var float_strength := 0.1
var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	cat_sprite.play("idle")
	go_hide()

func _physics_process(delta):
	# Apply gravity
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y -= GRAVITY * delta

	if not nav_agent.is_navigation_finished():
		var next_point = nav_agent.get_next_path_position()
		var direction = (next_point - global_position).normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()
	nav_agent.set_velocity(velocity)

func go_hide():
	if hiding_spots.is_empty():
		return

	var spots = hiding_spots.map(func(path): return get_node(path))
	for s in spots:
		print("Spot:", s.name, "Position:", s.global_position)

	var target_spot = spots.find(func(s): return s.name == "Hidingspot2")
	if target_spot == null:
		print("Could not find Hidingspot2")
		return
	print("Is target reachable?", nav_agent.is_target_reachable(target_spot.global_position))
