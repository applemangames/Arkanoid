extends Node2D


const lives_count = 3
const space = 5

var previous_position = -space
var image = Image.new()

func add_live():
	var live = Sprite.new() 
	live.texture = load("res://images/live.png")
	live.position.x = previous_position + space + live.texture.get_width()
	previous_position = live.position.x
	add_child(live) 
	

func remove_live():
	get_children()[-1].free()
	previous_position -= space + image.get_width()
	
func get_lives_num():
	return len(get_children())
	
func set_lives(num):
	clear_lives()
	for i in num:
		add_live()
		
func clear_lives():
	for i in get_lives_num():
		remove_live()
	

func _ready():
	set_lives(lives_count)


