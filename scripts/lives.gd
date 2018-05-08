extends Node2D


export (int) var START_LIVES_COUNT = 3
export (int) var MAX_LIVES_COUNT = 5
export (int) var SPACE_BETWEEN_LIVES = 5

var previous_position = -SPACE_BETWEEN_LIVES
var live_texture_width = 0

func add_live():
	if get_lives_num() == MAX_LIVES_COUNT:
		return
	var live = Sprite.new()
	live.texture = load("res://images/live.png")
	live.position.x = previous_position + SPACE_BETWEEN_LIVES + live_texture_width
	previous_position = live.position.x
	add_child(live) 
	

func remove_live():
	previous_position -= SPACE_BETWEEN_LIVES + live_texture_width
	get_children()[-1].free()
	
func get_lives_num():
	return len(get_children())
	
func set_lives(num):
	clear_lives()
	for i in num:
		add_live()
		
func clear_lives():
	for i in get_lives_num():
		remove_live()
	
func _set_live_texture_width():
	var live = Sprite.new()
	live.texture = load("res://images/live.png")
	live_texture_width = live.texture.get_width()
	live.free()

func _ready():
	_set_live_texture_width()
	set_lives(START_LIVES_COUNT)


