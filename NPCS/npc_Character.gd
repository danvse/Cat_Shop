extends Sprite3D

@onready var npc_sprite = $AnimatedSprite3D
@onready var camera = get_viewport().get_camera_3d()

func _ready():
	npc_sprite.play("front_Idle")

func _process(delta):
	if camera == null:
		return

	var to_camera = (camera.global_transform.origin - global_transform.origin).normalized()

	# Determine which axis the camera is mostly aligned with
	var abs_x = abs(to_camera.x)
	var abs_z = abs(to_camera.z)

	if abs_x > abs_z:
		if to_camera.x > 0:
			npc_sprite.play("right_Idle")
		else:
			npc_sprite.play("left_Idle")
	else:
		if to_camera.z > 0:
			npc_sprite.play("back_Idle")
		else:
			npc_sprite.play("front_Idle")
