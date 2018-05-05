extends Node2D

signal ball_out_of_room

var level = 1
const MAX_LEVELS = 3

func _ready():
	connect("ball_out_of_room", self, "ball_out_of_room")

func _process(delta):
	if Input.is_action_just_released("enter"):
		$StartButton.emit_signal("pressed")


func _on_StartButton_pressed():
	$StartButton.hide()
	print("start Game")
	$ball.direction = 45
	$ball.speed = 250
	$ball.start = true
	$pad.start = true
	
func load_new_bricks():
	var bricks = get_tree().get_nodes_in_group("bricks")
	for brick in bricks:
		brick.free()
	
	var resource = "res://scenes/level%d.tscn" % level
	var scene = load(resource)
	var node = scene.instance()
	node.position = $bricks.position
	node.z_index = -1
	add_child(node)
	
	
func next_level():
	level += 1
	if level > MAX_LEVELS:
		level = 1
	$ball.reset_ball()
	$pad.set_start_position()
	$ControlPanel/lives.add_live()
	load_new_bricks()
	
	
func show_game_over():
	$pad.start = false
	$GameOver.visible = true
	
func restart():
	get_tree().change_scene("res://scenes/game.tscn")

func ball_out_of_room():
	$ControlPanel/lives.remove_live()
	if $ControlPanel/lives.get_lives_num() <= 0:
		show_game_over()
		$ball.free()
	else:
		$ball.reset_ball()
		$pad.set_start_position()
		load_new_bricks()
