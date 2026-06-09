extends Node2D

@export var ui_master : CanvasLayer
@export var collectible_master : Node2D
@export var page_data : Resource

func _ready() -> void:
	collectible_master.tell_master_page_collected.connect(page_collected)


func page_collected():
	page_data.current_page_amount += 7
	if page_data.current_page_amount > page_data.max_page_amount:
		page_data.grade += 1
		page_data.current_page_amount -= page_data.max_page_amount
		
	print(page_data.current_page_amount)
	
