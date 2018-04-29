extends KinematicBody2D

var motion = Vector2(0,0)
var direction = 60
var speed = 100
var enemies = []

func _ready():
	direction = Vector2(0,0)
	

func _physics_process(delta):
	motion.x = cos(direction * (PI/180))  * speed * delta
	motion.y = -sin(direction * (PI/180)) * speed * delta
	print(motion)
	
	var collide = move_and_collide(motion)
	
	enemies = get_tree().get_nodes_in_group("enemies")
	
	if collide:
		motion = motion.bounce(collide.normal)
		
		for enemy in enemies:
			if(collide.collider_id == enemy.get_instance_id()):
				instance_from_id(collide.collider_id).free()
		
		
func _process(delta):
	if self.position.y > 600:
		position = get_node('../start_position').position
		get_node('../StartButton').show()
		direction = Vector2(0,0)
		motion = Vector2(0,0)


	
