extends Node2D


const lives_count = 3
const offset = 5

var previous_position = -offset
var image = Image.new()

func add_live():
	var live = Sprite.new() 
	live.position.x = previous_position + offset + image.get_width()
	previous_position = live.position.x
	live.texture = ImageTexture.new()
	live.texture.create_from_image(image)
	add_child(live) 
	

func remove_live():
	get_children()[-1].free()
	previous_position -= offset + image.get_width()
	
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
	image.load("res://images/live.png")
	set_lives(lives_count)


