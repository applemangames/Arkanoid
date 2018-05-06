extends Node2D


const lives_count = 3
const space = 5

var previous_position = -space
var live_texture_width = 0

func add_live():
	var live = Sprite.new()
	live.texture = load("res://images/live.png")
	live.position.x = previous_position + space + live_texture_width
	previous_position = live.position.x
	add_child(live) 
	

func remove_live():
	previous_position -= space + live_texture_width
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
	set_lives(lives_count)


