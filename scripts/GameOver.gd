extends Node2D


func _on_RestartButton_button_up():
	get_tree().change_scene("res://scenes/game.tscn")
