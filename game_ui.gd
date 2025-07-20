extends CanvasLayer

@onready var cat_label: Label = $CatCountLabel
@onready var win_label: Label = $Win_label
func _ready():
	GameManager.connect("update_ui", Callable(self, "_on_cat_update"))
	GameManager.connect("game_won", Callable(self, "_on_game_won"))
	_on_cat_update(0)  # Start from 0

func _on_cat_update(count: int):
	cat_label.text = "Cats Found: %d / %d" % [count, GameManager.total_cats]

func _on_game_won():
	win_label.text += "\n🎉 You found all the cats!Yippee!!!!!!!"
