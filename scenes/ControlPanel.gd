extends Node2D


func _on_PauseButton_pressed():
	if get_tree().paused == false:
		get_tree().paused = true
		$PauseButton.set_normal_texture(load("res://images/play.png"))
	else:
		get_tree().paused = false
		$PauseButton.set_normal_texture(load("res://images/pause.png"))
