extends Node2D

signal tell_master_page_collected

func _ready() -> void:
	for i in self.get_children():
		i.ColRange.collected_page.connect(page_collected)


func page_collected():
	emit_signal("tell_master_page_collected")
	print("Collected!")
