extends Area3D

signal cat_collected

@onready var cat_meow = $AudioStreamPlayer3D
var my_thread = Thread.new()

func _on_body_entered(body):
	if body.name == "Player":
		var meow = cat_meow.duplicate()
		get_tree().root.add_child(meow)
		meow.global_transform = cat_meow.global_transform
		meow.play()
		emit_signal("cat_collected")
		get_parent().queue_free()
