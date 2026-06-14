extends CanvasLayer

@export var page_bar : ProgressBar
@export var page_data : Resource
@export var colour_grade : ColorRect
@export var hp_bar : ProgressBar

func _process(delta: float) -> void:
	page_bar.value = page_data.current_page_amount
	match page_data.grade:
		1:
			colour_grade.color = Color(0.777, 0.0, 0.129, 1.0)
		2:
			colour_grade.color = Color(0.725, 0.0, 0.505, 1.0)
		3:
			colour_grade.color = Color(0.0, 0.425, 0.713, 1.0)
		4:
			colour_grade.color = Color(0.0, 0.465, 0.532, 1.0)
			
	
func _ready() -> void:
	page_bar.max_value = page_data.max_page_amount
	colour_grade.color = Color(0.777, 0.0, 0.129, 1.0)
