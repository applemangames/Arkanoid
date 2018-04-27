extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Input.is_action_just_released("enter"):
		$StartButton.emit_signal("pressed")


func _on_StartButton_pressed():
	#emit_signal("start_game")
	$StartButton.hide()
	print("start Game")
	#$ball.direction.x = rand_range(-0.25, 0.25)  
	#$ball.direction.y = rand_range(-0.30, -0.20)
