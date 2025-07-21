extends CharacterBody3D
@onready var cat_sprite = $AnimatedSprite3D
@export var player_path: NodePath
@export var run_speed: float = 5.0
var is_player_nearby: bool = false
var player: Node3D = null
var is_jumping = false

var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")
func _ready():
	cat_sprite.play("idle")
	player = get_node_or_null("/root/World/Player")

func _physics_process(delta):
	# Gravity
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y -= GRAVITY * delta
		
	if is_player_nearby and player:
		var direction_away = global_transform.origin - player.global_transform.origin
		direction_away.y = 0
		direction_away = direction_away.normalized()

		if direction_away.length() > 0.1:
			velocity.x = direction_away.x * run_speed
			velocity.z = direction_away.z * run_speed
			cat_sprite.play("jump")
			
		elif not is_jumping:
			velocity.x = move_toward(velocity.x, 0, run_speed)
			velocity.z = move_toward(velocity.z, 0, run_speed)
			cat_sprite.play("idle")

	else:
		velocity.x = move_toward(velocity.x, 0, run_speed)
		velocity.z = move_toward(velocity.z, 0, run_speed)
		
		if not is_jumping and cat_sprite.animation != "idle":
			cat_sprite.play("idle")
	
	move_and_slide()

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		is_player_nearby = true
		player = body


func _on_area_3d_body_exited(body):
	if body.name == "Player":
		is_player_nearby = false
		player = null


func _on_animated_sprite_3d_animation_finished():
	if cat_sprite.animation == "jump":
		is_jumping = false
