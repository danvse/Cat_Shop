extends Area3D

signal cat_collected

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":  # adjust to your player node name
		emit_signal("cat_collected")
		queue_free()  # remove cat after collection
