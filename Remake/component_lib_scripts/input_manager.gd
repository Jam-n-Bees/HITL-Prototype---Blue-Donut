extends Node2D

signal down_pressed
signal down_held
signal left_pressed
signal left_held
signal up_pressed
signal up_held
signal right_pressed
signal right_held
signal space_pressed
signal space_held

signal down_released

signal h_moving
signal not_h_moving

var moving : bool = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Down"):
		emit_signal("down_pressed")
	if Input.is_action_pressed("Down"):
		emit_signal("down_held")
	if Input.is_action_just_pressed("Left"):
		emit_signal("left_pressed")
	if Input.is_action_pressed("Left"):
		emit_signal("left_held")
	if Input.is_action_just_pressed("Up"):
		emit_signal("up_pressed")
	if Input.is_action_pressed("Up"):
		emit_signal("up_held")
	if Input.is_action_just_pressed("Right"):
		emit_signal("right_pressed")
	if Input.is_action_pressed("Right"):
		emit_signal("right_held")
	if Input.is_action_just_pressed("Space"):
		emit_signal("space_pressed")
	if Input.is_action_pressed("Space"):
		emit_signal("space_held")
		
	if Input.is_action_just_released("Down"):
		emit_signal("down_released")
	## NOTE Do the rest of this later I can't be assed right now and it's not neccesary. 
	## If I need to come back here more than once I'll do the whole thing but like
	## right now who can be assed-
		
		
	
		
	if (Input.is_action_pressed("Left") or Input.is_action_pressed("Right")) && !moving:
		emit_signal("h_moving")
		moving = true
	elif !(Input.is_action_pressed("Left") or Input.is_action_pressed("Right")) && moving:
		emit_signal("not_h_moving")
		moving = false
		
		
	
	
