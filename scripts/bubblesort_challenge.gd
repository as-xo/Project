extends Control


@onready var vbox = $VBoxContainer
var labels = []
var correct_order = ["for i in range(n - 1):", "for j in range(n - i - 1):", "if array[j] > array[j + 1]:", "swap(array[j], array[j + 1])"]

func _ready():
	_setup_labels()

func _setup_labels():
	var child_count = vbox.get_child_count() - 1
	for i in range(child_count, -1, -1):
		var child = vbox.get_child(i)
		vbox.remove_child(child)
		child.queue_free()

	# Shuffle the correct order for the challenge
	var shuffled_order = correct_order.duplicate()
	shuffled_order.shuffle()

	# Create draggable labels
	for line in shuffled_order:
		var label = Label.new()
		label.text = line
		label.draggable = true
		label.set_mouse_filter(Control.MOUSE_FILTER_PASS)
		vbox.add_child(label)
		labels.append(label)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var label = get_label_at_position(event.position)
		if label:
			label.start_drag(label.text, label.texture)

func get_label_at_position(position: Vector2) -> Label:
	for label in labels:
		if label.get_global_rect().has_point(position):
			return label
	return null

func _on_DropData(position: Vector2, data, from_control: Control) -> void:
	var target_label = get_label_at_position(position)
	if target_label and target_label != from_control:
		var from_index = vbox.get_child_index(from_control)
		var target_index = vbox.get_child_index(target_label)
		vbox.move_child(from_control, target_index)

func _on_Sort_Pressed():
	if _check_order():
		print("Correct Order!")
		for label in labels:
			label.color = Color(0.0, 1.0, 0.0) 
	else:
		print("Incorrect Order. Try Again.")
		for label in labels:
			label.color = Color(1.0, 0.0, 0.0)

func _check_order() -> bool:
	for i in range(labels.size()):
		if labels[i].text != correct_order[i]:
			return false
	return true





#var correct_order: Array = ["for i in range(...)", "for j in range(...)", "if array[j] > array[j+1]:", "swap(array, j, j+1)"]
#var current_order: Array = []
#
#func _ready():
	## Populate current_order with the initial label texts
	#for child in get_children():
		#if child is Label:
			#current_order.append(child.text)
			#child.connect("gui_input", self, "_on_label_gui_input", [child])
#
#
#func _on_label_gui_input(label: Label, event: InputEvent):
	#if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		## Start dragging the label text
		#set_drag_preview(label.duplicate())
		#set_drag_data(label.text))
#
#
#func get_drag_data(position):
	#return get_child(get_drag_index_under_position(position)).text
#
#
#func can_drop_data(position, data):
	#return true  # Allow drop anywhere within the VBoxContainer
#
#
#func drop_data(position, data):
	#var index = get_drag_index_under_position(position)
	#if index != -1:
		#_reorder_labels(index, data)
		#_update_code_display()
#
#
#func get_drag_index_under_position(position):
	#var local_pos = position - rect_global_position
	#var index = int(local_pos.y / rect_min_size.y)
	#return clamp(index, 0, get_child_count() - 1)
#
#
#func _reorder_labels(index, data):
	#current_order.erase(data)  # Remove the dragged element from its original position
	#current_order.insert(index, data)  # Insert it at the new position
#
#
#func _update_code_display():
	## Update the UI to reflect the new order
	#for i in range(current_order.size()):
		#var label = get_child(i)
		#label.text = current_order[i]
#
#
#func check_correct_order():
	#if current_order == correct_order:
		#print("Correct order!")
	#else:
		#print("Incorrect. Try again.")


# 
