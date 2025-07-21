extends Control

func _on_play_button_pressed():
	GameManager.start_game()
	get_tree().change_scene_to_file("res://NavigationLevel.tscn") 
