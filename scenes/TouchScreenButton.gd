extends TouchScreenButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print("cau")

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	if is_pressed():
		print("ahoj")
