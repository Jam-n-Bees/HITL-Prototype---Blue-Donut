extends Node2D

@export var ui_master : CanvasLayer
@export var collectible_master : Node2D
@export var page_data : Resource
@export var pc_data : Resource

@export var level_tiles : Array[PackedScene]

@onready var pc := $PlayerCharacter
@onready var camantle := $CameraMantle

var danger_zone := false
var danger_harmed := false
var danger_zone_counter : float = 0
var danger_tp_counter : float = 0
var dng_zn_recovery_timer : float = 0
var dng_zn_recovery := 2



func _ready() -> void:
	collectible_master.tell_master_page_collected.connect(page_collected)
	
	pc.incoming_damage.connect(player_damage_taken)
	
func _process(delta: float) -> void:
	if camantle.global_position.x - pc.global_position.x > 700:
		danger_zone_counter += delta
		print(danger_zone_counter)
		if danger_zone_counter > 1.5:
			danger_harmed = true
			danger_tp_counter = 0
			danger_zone_counter = 0
			player_damage_taken(5)
	else:
		danger_zone_counter = 0
	if camantle.global_position.x - pc.global_position.x > 800:
		pc.global_position.x = camantle.global_position.x -800


	if danger_harmed == true:
		danger_tp_counter += (delta / 6)
		dng_zn_recovery_timer += delta
		if dng_zn_recovery_timer > dng_zn_recovery:
			danger_harmed = false
			danger_tp_counter = 0
			dng_zn_recovery_timer = 0
		pc.global_position.x = lerpf(pc.global_position.x, camantle.global_position.x, danger_tp_counter)
		print(dng_zn_recovery_timer)

		

func page_collected():
	page_data.current_page_amount += 7
	if page_data.current_page_amount > page_data.max_page_amount:
		page_data.grade += 1
		page_data.current_page_amount -= page_data.max_page_amount
		
	print(page_data.current_page_amount)
	
func player_damage_taken(bonk):
	pc_data.current_hp -= bonk
	ui_master.initialise_hp_bar()
	print(bonk, " damage taken!")
	
	
