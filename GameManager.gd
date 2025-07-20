extends Node

var total_cats := 1
var collected_cats := 0
signal update_ui(collected: int)
signal game_won

func collect_cat():
	collected_cats += 1
	emit_signal("update_ui", collected_cats)
	if collected_cats >= total_cats:
		emit_signal("game_won")
