extends Node2D

signal ball_out_of_room

var level = 1
const MAX_LEVELS = 3
const TIMER_WAIT_TIME = 15

var admob = null
var isReal = false
var isTop = false
#var adBannerId = "ca-app-pub-8376690330172162/3506453875" # [Replace with your Ad Unit ID and delete this message.]
var adBannerId = "ca-app-pub-3940256099942544/6300978111"
var adRewardVideoId = "ca-app-pub-3940256099942544/5224354917"
var timer = Timer.new()

func _ready():
	connect("ball_out_of_room", self, "ball_out_of_room")
	$Buttons/AddLiveButton.hide()
	
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		admob.init(isReal, get_instance_id())
		admob.loadBanner(adBannerId, isTop)
		admob.loadRewardedVideo(adRewardVideoId)
		admob.showBanner()


func _process(delta):
	if Input.is_action_just_released("enter"):
		$Buttons/StartButton.emit_signal("pressed")

func setup_timer():
	self.timer.wait_time = TIMER_WAIT_TIME
	self.timer.one_shot = true 
	add_child(self.timer)
	self.timer.start()
	

func _on_StartButton_pressed():
	$Buttons.hide()
	print("start Game")
	$ball.direction = 45
	$ball.speed = $ball.previous_speed
	$ball.start = true
	$pad.start = true
	setup_timer()
	
func load_new_bricks():
	var resource = "res://scenes/level%d.tscn" % level
	var scene = load(resource)
	var bricks = scene.instance()
	bricks.position = Vector2(0,0)
	bricks.z_index = -1
	add_child(bricks)
	
	
func next_level():
	level += 1
	if level > MAX_LEVELS:
		level = 1
	$pad.speed = $pad.START_SPEED
	$ball.speed = $ball.START_SPEED
	$ball.set_start_position()
	$pad.set_start_position()
	$ControlPanel/lives.add_live()
	load_new_bricks()
	$Buttons.show()
	$Buttons/AddLiveButton.hide()
	
	
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
		$ball.set_start_position()
		$pad.set_start_position()
		$Buttons.show()
		
		if admob != null and self.timer.get_time_left() != 0:
			admob.loadRewardedVideo(adRewardVideoId)
			$Buttons/AddLiveButton.show()
		


func _on_AddLiveButton_pressed():
	if admob != null:
		admob.showRewardedVideo()

func _on_rewarded_video_ad_closed():
	$Buttons/AddLiveButton.hide()
	$ControlPanel/lives.add_live()