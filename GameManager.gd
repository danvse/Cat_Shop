extends Node

var total_cats := 14
var collected_cats := 0
signal update_ui(collected: int)
signal game_won
signal update_timer(time_passed: int)
var seconds_passed: int = 0
var game_timer: Timer
var final_time: int = 0

func start_game():
	game_timer = Timer.new()
	collected_cats = 0
	add_child(game_timer)
	game_timer.wait_time = 1.0
	game_timer.timeout.connect(_on_timer_timeout)
	game_timer.start()
	seconds_passed = 0

func _on_timer_timeout():
	seconds_passed += 1
	emit_signal("update_timer", seconds_passed)

func collect_cat():
	collected_cats += 1
	emit_signal("update_ui", collected_cats)
	if collected_cats >= total_cats:
		game_timer.stop()
		final_time = seconds_passed
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://win_screen.tscn") 
