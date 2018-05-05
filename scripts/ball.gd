extends KinematicBody2D

var motion = Vector2(0,0)
var direction = 45
var speed = 0
var bricks = []
var dir = Vector2(1,-1)
var start = false
const dir_chooses = [Vector2(1,1), Vector2(1,-1), Vector2(-1,1), Vector2(-1,-1)]

func _ready():
	randomize()

func _physics_process(delta):
	if start:
		speed += 0.1
	
	motion.x = dir.x * cos(direction * (PI/180)) * speed * delta
	motion.y = dir.y * sin(direction * (PI/180)) * speed * delta
	
	var collide = move_and_collide(motion)
	
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
		

func reset_ball():
	position = get_node('../start_position').position
	get_node('../StartButton').show()
	motion = Vector2(0,0)
	randomize()
	dir = dir_chooses[randi() % 4]
	speed = 0
	start = false
	
