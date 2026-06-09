extends CharacterBody2D

@onready var sprite := $Sprite2D

const GRAVITY = 80
var onFloor : bool = false
var acel : float = 0
var dashing : bool = false
var moveSpeedSnap := 0.0
var speedSnapped := false
var speedCalcStorage : float = 0
var moveLerpTimer : float = 0
var movementLockout : bool = false

var maxVelocity : float = 1000
var minVelocity : float = 400

@onready var hurtBox : CollisionShape2D = $HitBox/CollisionShape2D
@onready var dashHitBox : CollisionShape2D = $DashHitBox/CollisionShape2D

func _ready() -> void:
	velocity.x = 700
	dashHitBox.disabled = true

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("ui_right") && !movementLockout:
		speedSnapped = false
		velocity.x += 10
	if Input.is_action_pressed("ui_left") && !movementLockout:
		speedSnapped = false
		velocity.x -= 10
	move_and_slide()
	if onFloor == false:
		if dashing:
			velocity.y += GRAVITY * 1.8
		else:
			velocity.y += GRAVITY
		
	if Input.is_action_just_pressed("ui_down"):
		if !movementLockout:
			if dashing:
				position.y += 40
			
			else:
				endDashing()
		
	if Input.is_action_just_pressed("Space") && !movementLockout:
		velocity.y = -2000
		
	if velocity.x > maxVelocity && !dashing:
		velocity.x = maxVelocity
		
	if velocity.x < minVelocity:
		velocity.x = minVelocity
	
	if velocity.x > 700 && !Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left") && !dashing && !movementLockout:
		speedCalcStorage = velocity.x
		velocity.x = move_toward(velocity.x, 700.0, 15)
		
	if velocity.x < 700 && !Input.is_action_pressed("ui_right") && !Input.is_action_pressed("ui_left") && !dashing && !movementLockout:
		speedCalcStorage = velocity.x
		velocity.x = move_toward(velocity.x, 700.0, 5)


func _process(delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Ground"):
		onFloor = true
	if area.is_in_group("BreakableHitBox"):
		velocity.x = 200
	if area.is_in_group("CannonProjectile"):
		minVelocity -= 200
		velocity.x = minVelocity
		movementLockout = true
		velocity.y -= 1000
		sprite.modulate = Color(0.274, 0.001, 0.591, 0.5)
		await get_tree().create_timer(1).timeout
		sprite.modulate = Color(1,1,1,1)
		minVelocity += 200
		velocity.x = minVelocity
		movementLockout = false
		
	
		

func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Ground"):
		onFloor = false

func endDashing():
	dashHitBox.disabled = false
	global_scale = Vector2(1, 0.5)
	dashing = true
	velocity.x += 400
	await get_tree().create_timer(0.4).timeout
	dashing = false
	global_scale = Vector2(1, 1)
	velocity.x -= 400
	dashHitBox.disabled = true
	


func _on_dash_hit_box_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
