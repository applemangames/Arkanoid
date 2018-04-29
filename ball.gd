extends KinematicBody2D

var motion = Vector2(0,0)
var direction = 45
var speed = 250
var bricks = []
var dir = Vector2(1,-1)


func _physics_process(delta):
	motion.x = dir.x * cos(direction * (PI/180))  * speed * delta
	motion.y = dir.y * sin(direction * (PI/180)) * speed * delta
	
	var collide = move_and_collide(motion)
	
	bricks = get_tree().get_nodes_in_group("enemies")
	
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
		direction = Vector2(0,0)
		motion = Vector2(0,0)


	
