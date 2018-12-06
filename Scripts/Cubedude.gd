extends KinematicBody

var movement = Vector3()
export var speed = 8
export var player_id = 1
const UP = Vector3(0, 1, 0)
const GRAVITY = -5
const EPSILON = 0.000001

func _physics_process(delta):
	if Input.is_action_pressed("p%s_left" %player_id) and not Input.is_action_pressed("p%s_right" %player_id):
		movement.x = -1
	elif Input.is_action_pressed("p%s_right" %player_id) and not Input.is_action_pressed("p%s_left" %player_id):
		movement.x = 1
	else:
		movement.x = 0	
		
	if Input.is_action_pressed("p%s_up" %player_id) and not Input.is_action_pressed("p%s_down" %player_id):
		movement.z = -1
	elif Input.is_action_pressed("p%s_down" %player_id) and not Input.is_action_pressed("p%s_up" %player_id):
		movement.z = 1
	else:
		movement.z = 0 
		
	fall()
	
	move_and_slide(movement.normalized() * speed, UP)
	
func _process(delta):
	play_animation()
	look_forward()
	
func fall():
	if is_on_floor():
		movement.y = 0;
	else:
		movement.y = GRAVITY
		
func play_animation():
	if movement.length() > EPSILON:
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("Arms Cross Walk")
	else:
		$AnimationPlayer.stop()
		
func look_forward():
	if not movement.x == 0 or not movement.z == 0:
		look_at((Vector3(-movement.x, 0, -movement.z) * speed), UP)