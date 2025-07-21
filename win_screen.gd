extends Control

func _ready():
	$win_Text.text = "Yippee you collect all the cats!!! \nTime: %s seconds" % GameManager.final_time

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://main_menu.tscn") 
