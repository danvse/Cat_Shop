extends Sprite3D

@onready var cat_sprite = $AnimatedSprite3D

func _ready():
	cat_sprite.play("idle")
