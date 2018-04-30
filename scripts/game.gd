extends Node2D

signal ball_out_of_room

func _ready():
    connect("ball_out_of_room", self, "ball_out_of_room")

func _process(delta):
	if Input.is_action_just_released("enter"):
		$StartButton.emit_signal("pressed")


func _on_StartButton_pressed():
	#emit_signal("start_game")
	$StartButton.hide()
	print("start Game")
	$ball.direction = 45
	$ball.speed = 250
	$ball.start = true
	
func load_new_bricks():
	var bricks = get_tree().get_nodes_in_group("bricks")
	for brick in bricks:
		brick.free()
	
	var scene = load("res://scenes/level1.tscn")
	var node = scene.instance()
	node.position = $bricks.position
	node.z_index = -1
	add_child(node)

func ball_out_of_room():
	load_new_bricks()
	$ball.reset_ball()
	$pad.set_start_position()
	$lives.remove_live()
