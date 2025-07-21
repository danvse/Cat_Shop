extends CanvasLayer

@onready var cat_label: Label = $CatCountLabel
@onready var win_label: Label = $Win_label
@onready var time_label: Label = $Timer_Label


func _ready():
	GameManager.connect("update_ui", Callable(self, "_on_cat_update"))
	GameManager.connect("game_won", Callable(self, "_on_game_won"))
	GameManager.connect("update_timer", Callable(self, "_on_timer"))
	_on_cat_update(0)  # Start from 0


func _on_timer(second: int):
	time_label.text = "Time: %d" % second
	

func _on_cat_update(count: int):
	cat_label.text = "Cats Found: %d / %d" % [count, GameManager.total_cats]

func _on_game_won():
	time_label.text = ""
	cat_label.text = ""
