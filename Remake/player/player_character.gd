extends CharacterBody2D

@export var input_manager : Node2D
@export var syncronised_shuffle : Node2D

var gravity : float = 85
var on_floor : bool = false

func _ready() -> void:
	input_manager.space_pressed.connect(jump)
	input_manager.left_held.connect(move_left)
	input_manager.right_held.connect(move_right)
	input_manager.h_moving.connect(am_moving)
	input_manager.not_h_moving.connect(am_not_moving)

func _physics_process(delta: float) -> void:
	velocity.y += gravity
	move_and_slide()
	if is_on_floor():
		on_floor = true
	else:
		on_floor = false

func jump():
	if on_floor:
		velocity.y = -2200

func move_left():
	syncronised_shuffle.player_modifier -= 40

func move_right():
	syncronised_shuffle.player_modifier += 40
	
func am_moving():
	syncronised_shuffle.moving = true
	
func am_not_moving():
	syncronised_shuffle.moving = false
