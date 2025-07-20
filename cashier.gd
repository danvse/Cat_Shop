
extends Node3D

var player_in_range = false




func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		print("hello")


func _on_area_3d_body_entered(body):
	if body.name == "CharacterBody3D":
		player_in_range = true


func _on_area_3d_body_exited(body):
	if body.name == "CharacterBody3D":
		player_in_range = false
