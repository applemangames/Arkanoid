extends Control

var names_array = ["Monika", "Pavel", "Petr", "Tomas", "Honza", "Lukas"]
var score_array = [1000, 2000, 5000, 10000, 20000, 30000]


func _ready():
	var namesContainer = $VBoxContainer/HighscoreScroll/VBoxContainer/Names
	for name in names_array:
		var label = Label.new()
		label.text = name
		namesContainer.add_child(label) 
	

