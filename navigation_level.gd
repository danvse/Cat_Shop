extends NavigationRegion3D


# Called when the node enters the scene tree for the first time.

func _ready():
	for cat in get_tree().get_nodes_in_group("cats"):
		cat.connect("cat_collected", Callable(GameManager, "collect_cat"))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:pass
