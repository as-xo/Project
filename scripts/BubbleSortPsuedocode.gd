extends Node
@onready var bubble_sort = $BubbleSort


func _on_bubble_sort_popup_show():
	if Input.is_action_just_pressed("click"):
		bubble_sort.show()
	


func _on_bubble_sort_popup_hide():
	if Input.is_action_just_pressed("jump"):
		bubble_sort.hide()
