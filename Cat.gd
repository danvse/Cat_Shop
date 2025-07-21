extends Area3D

signal cat_collected

@onready var cat_meow = $AudioStreamPlayer3D


func _on_body_entered(body):
	if body.name == "Player":
		cat_meow.play()
		emit_signal("cat_collected")
		await cat_meow.finished
		get_parent().queue_free()
