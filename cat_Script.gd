extends Sprite3D

@export var speed := 2.0

@onready var cat_sprite = $AnimatedSprite3D
func _ready():
	cat_sprite.play("idle")
