extends Control

func _on_Play_pressed():
	assert(get_tree().change_scene("res://scenes/game.tscn") == OK)
	pass

func _on_Settings_pressed():
	assert(get_tree().change_scene("res://scenes/settings.tscn") == OK)
	pass

func _on_Exit_pressed():
	get_tree().quit()
	pass
