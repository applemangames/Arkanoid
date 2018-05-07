extends KinematicBody2D

const dir_chooses = [Vector2(1,1), Vector2(1,-1), Vector2(-1,1), Vector2(-1,-1)]
const START_SPEED = 250


var motion = Vector2(0,0)
var direction = 45
var speed = START_SPEED
var previous_speed = START_SPEED
var bricks = []
var dir = Vector2(1,-1)
var start = false
var collide = false
var start_position 

func _ready():
	start_position = position
	randomize()

func _physics_process(delta):
	if start:
		speed += 0.1
		
		motion.x = dir.x * cos(direction * (PI/180)) * speed * delta
		motion.y = dir.y * sin(direction * (PI/180)) * speed * delta
		
		collide = move_and_collide(motion)
	
	bricks = get_tree().get_nodes_in_group("bricks")
	if len(bricks) == 0:
		get_parent().next_level()
	
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
				var actual_score = int(get_parent().find_node("ControlPanel").find_node("ScoreText").text) 
				actual_score += instance_from_id(collide.collider_id).SCORE_VALUE
				get_parent().find_node("ControlPanel").find_node("ScoreText").text = str(actual_score)
				instance_from_id(collide.collider_id).free()
		
		
func _process(delta):
	if self.position.y > 600:
		get_parent().emit_signal("ball_out_of_room")
		

func set_start_position():
	position = start_position
	motion = Vector2(0,0)
	randomize()
	dir = dir_chooses[randi() % 4]
	previous_speed = speed
	start = false
	
