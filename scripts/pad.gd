extends KinematicBody2D

var pad_motion = Vector2()
var mouse_position = Vector2()
var mouse_is_down = false
var start_position = Vector2()
var start = false

func _ready():
	start_position = self.position

func _physics_process(delta):
	
	mouse_position = get_viewport().get_mouse_position()	
	
	if Input.is_action_pressed("ui_right") or mouse_is_down and mouse_position.x > get_viewport().size.x/2:
		pad_motion.x = 10
	elif Input.is_action_pressed("ui_left") or mouse_is_down and mouse_position.x < get_viewport().size.x/2:
		pad_motion.x = -10
	else:
		pad_motion.x = 0
	
	if start:
		move_and_collide(pad_motion)
	
	
func _input(event):
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position, event.button_index, event.pressed)
		if event.pressed:
			mouse_is_down = true
		else:
			mouse_is_down = false

func set_start_position():
	self.position = start_position
	self.start = false