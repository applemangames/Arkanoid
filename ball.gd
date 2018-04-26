extends KinematicBody2D

var direction = Vector2(0,0)
var motion = Vector2(0,0)
var speed = 1000
var enemies = []

func _ready():
	direction = Vector2(0,0)
	

func _physics_process(delta):
	motion.x = direction.x * speed * delta
	motion.y = direction.y * speed * delta
	print(direction)
	var collide = move_and_collide(motion)
	enemies = get_tree().get_nodes_in_group("enemies")
	
	if collide:
		var norm = collide.normal
		#norm.x = round(collide.normal.x)
		#norm.y = round(collide.normal.y)
		direction = direction.bounce(norm)
		
		for enemy in enemies:
			if(collide.collider_id == enemy.get_instance_id()):
				instance_from_id(collide.collider_id).free()
		
		
func _process(delta):
	if self.position.y > 600:
		position = get_node('../start_position').position
		get_node('../StartButton').show()
		direction = Vector2(0,0)
		motion = Vector2(0,0)


	
