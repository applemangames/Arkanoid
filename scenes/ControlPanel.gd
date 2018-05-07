extends Node2D


func _on_MobilePauseButton_released():
	if get_tree().paused == false:
		get_tree().paused = true
		$PauseButton/MobilePauseButton.normal = load("res://images/play.png")
	else:
		get_tree().paused = false
		$PauseButton/MobilePauseButton.normal = load("res://images/pause.png")


func _on_ComputerPauseButton_button_down():
	if get_tree().paused == false:
		get_tree().paused = true
		$PauseButton/ComputerPauseButton.texture_normal = load("res://images/play.png")
	else:
		get_tree().paused = false
		$PauseButton/ComputerPauseButton.texture_normal = load("res://images/pause.png")
