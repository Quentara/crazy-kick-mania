extends Node

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _on_GoalDetection_body_entered(body, player_id):
	print("Player ", player_id, " scored a goal!")
	$ball.axis_lock_linear_x = true
	$ball.axis_lock_linear_z = true
	$Timer.start()
	
func _on_Timer_timeout():
	reset_game()
	
func reset_game():
	# TODO Refactor this block into a function inside the ball script
	$ball.axis_lock_linear_x = false
	$ball.axis_lock_linear_z = false
	$ball.translation = $SpawnPoints/BallSpawnPoint.translation
	
	# TODO Insert reset function for players