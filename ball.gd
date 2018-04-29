extends KinematicBody2D

var motion = Vector2(0,0)
var direction = 45
var speed = 0
var bricks = []
var dir = Vector2(1,-1)
var start = false


func _physics_process(delta):
	if start:
		speed += 0.1
	
	motion.x = dir.x * cos(direction * (PI/180)) * speed * delta
	motion.y = dir.y * sin(direction * (PI/180)) * speed * delta
	
	var collide = move_and_collide(motion)
	
	bricks = get_tree().get_nodes_in_group("bricks")
	
	if collide:
		match Vector2(round(collide.normal.x), round(collide.normal.y)):
			Vector2(0, 1):
				dir.y = 1
			Vector2(1, 0):
				dir.x = 1
			Vector2(0, -1):
				dir.y = -1
			Vector2(-1, 0):
				dir.x = -1
			
		for brick in bricks:
			if(collide.collider_id == brick.get_instance_id()):
				instance_from_id(collide.collider_id).free()
		
		
func _process(delta):
	if self.position.y > 600:
		position = get_node('../start_position').position
		get_node('../StartButton').show()
		motion = Vector2(0,0)
		speed = 0
		start = false
		
		#get_parent().restart()
		get_parent().find_node("pad").set_start_position()
		
		get_parent().restart()
		
		


	
