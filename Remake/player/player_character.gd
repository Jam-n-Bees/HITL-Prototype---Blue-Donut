extends CharacterBody2D

@export var input_manager : Node2D
@export var syncronised_shuffle : Node2D

@onready var default_pose : Array = [$SpriteDefault, $PCCollisionDefault]
@onready var sliding_pose : Array = [$SpriteSliding, $PCCollisionSliding]
@onready var slide_tackle_area := $SlideTackle/CollisionShape2D
@onready var slide_timer := $"== Timers ==/SlideTimer"

signal incoming_damage (inc_dmg)
var test_dmg := 5

var gravity : float = 85
var on_floor : bool = false
var lockout : bool = false
var dashing : bool = false
var acceleration_multiplier : float = 1

func _ready() -> void:
	unsquish()
	slide_tackle_area.disabled = true
	input_manager.space_pressed.connect(jump)
	input_manager.left_held.connect(move_left)
	input_manager.right_held.connect(move_right)
	input_manager.down_pressed.connect(slide_tackle)
	#input_manager.down_released.connect(unsquish)
	input_manager.h_moving.connect(am_moving)
	input_manager.not_h_moving.connect(am_not_moving)
	
	

func _physics_process(delta: float) -> void:
	print("Acceleration : ",acceleration_multiplier, " Velocity.x : ", velocity.x)
	if acceleration_multiplier != 1:
		if acceleration_multiplier < 0:
			acceleration_multiplier = 0
		acceleration_multiplier = move_toward(acceleration_multiplier, 1, 0.5 * delta)
		
	
	velocity.y += gravity
	move_and_slide()
	if is_on_floor():
		on_floor = true
		lockout = false
	else:
		on_floor = false

func jump():
	if on_floor:
		velocity.y = -2200

func move_left():
	syncronised_shuffle.player_modifier -= (40 * acceleration_multiplier)

func move_right():
	syncronised_shuffle.player_modifier += (40 * acceleration_multiplier)
	
func am_moving():
	syncronised_shuffle.moving = true
	
func am_not_moving():
	syncronised_shuffle.moving = false


func _on_player_area_hit_something(area: Area2D) -> void:
	if area.is_in_group("CannonProjectile"):
		lockout = true
		incoming_damage.emit(test_dmg)
		velocity.y = -1400
		velocity.x = 200
	
	if area.is_in_group("BreakableHitBox"):
		velocity.x -= 1000
		syncronised_shuffle.player_modifier -= 300
		acceleration_multiplier -= 0.5
		

func unsquish():
	for i in default_pose:
		if i.get_class() == "Sprite2D":
			i.visible = true
		if i.get_class() == "CollisionShape2D":
			i.disabled = false
	
	for i in sliding_pose:
		if i.get_class() == "Sprite2D":
			i.visible = false
		if i.get_class() == "CollisionShape2D":
			i.disabled = true
			
func squish():
	for i in default_pose:
		if i.get_class() == "Sprite2D":
			i.visible = false
		if i.get_class() == "CollisionShape2D":
			i.disabled = true
	
	for i in sliding_pose:
		if i.get_class() == "Sprite2D":
			i.visible = true
		if i.get_class() == "CollisionShape2D":
			i.disabled = false

func slide_tackle():
	if !dashing:
		slide_timer.start()
		lockout = true
		dashing = true
		syncronised_shuffle.dashing = true
		syncronised_shuffle.max_speed_modifier += 100
		syncronised_shuffle.player_modifier += 200
		squish()
		slide_tackle_area.disabled = false
	else:
		self.global_position.y += 5



func _on_slide_timer_timeout() -> void:
	lockout = false
	syncronised_shuffle.dashing = false
	dashing = false
	syncronised_shuffle.max_speed_modifier -= 100
	#syncronised_shuffle.player_modifier -= 100
	unsquish()
	slide_tackle_area.disabled = true
