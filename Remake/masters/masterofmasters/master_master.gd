extends Node2D

@export var ui_master : CanvasLayer
@export var collectible_master : Node2D
@export var page_data : Resource
@export var pc_data : Resource

@onready var pc := $PlayerCharacter



func _ready() -> void:
	collectible_master.tell_master_page_collected.connect(page_collected)
	
	pc.incoming_damage.connect(player_damage_taken)


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
	
	
