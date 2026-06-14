extends CharacterBody2D

@export var input_manager : Node2D
@export var syncronised_shuffle : Node2D

@onready var default_pose : Array = [$SpriteDefault, $PCCollisionDefault]
@onready var sliding_pose : Array = [$SpriteSliding, $PCCollisionSliding]

signal incoming_damage (inc_dmg)
var test_dmg := 5

var gravity : float = 85
var on_floor : bool = false
var lockout : bool = false

func _ready() -> void:
	unsquish()
	input_manager.space_pressed.connect(jump)
	input_manager.left_held.connect(move_left)
	input_manager.right_held.connect(move_right)
	input_manager.down_pressed.connect(squish)
	input_manager.down_released.connect(unsquish)
	input_manager.h_moving.connect(am_moving)
	input_manager.not_h_moving.connect(am_not_moving)
	
	

func _physics_process(delta: float) -> void:
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
	syncronised_shuffle.player_modifier -= 40

func move_right():
	syncronised_shuffle.player_modifier += 40
	
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
