extends Window

@onready var visualizer: Window = $"."
@onready var container = $HBoxContainer  
@onready var start_button: OptionButton = $OptionButton
@onready var line_edit: LineEdit = $LineEdit
@onready var binary_search_input: LineEdit = $Binary_search_input
@onready var warning_label: Label = $warning_label

var array = [5, 3, 8, 4, 2]
var array_labels = []

func _ready():
	# Initialize the visual representation of the array
	_create_visual_array()
	start_button.add_item("Choose option")
	start_button.add_item("Bubble Sort")
	start_button.add_item("Binary Search")
	
	start_button.connect("item_selected", Callable(self, "_on_option_selected"))
	line_edit.connect("text_entered", Callable(self, "_on_text_entered"))
	binary_search_input.connect("text_entered", Callable(self, "_on_target_entered"))
	

func _create_visual_array():
	# Remove all previous labels if any
	for child in container.get_children():
		container.remove_child(child)
		child.queue_free()

	array_labels.clear()  # Clear the array_labels list

	# Create a label for each array element
	for value in array:
		var label = Label.new()
		label.text = str(value)
		label.modulate = Color(1, 1, 1)  # Set default color to white
		container.add_child(label)
		array_labels.append(label)

func _on_option_selected(index):
	# Disable the button during the visualization
	start_button.disabled = true
	
	# perform selected option
	match index:
		1:
			_bubble_sort()
		2: 
			_binary_search_visualize(4)	

func _on_target_entered(target):
	if target.is_valid_integer():  # Check if the input is a valid integer.
		var target_int = int(target)  # Convert the input to an integer.
		_binary_search_visualize(target_int)  # Call the binary search function with the target.
	else:
		warning_label.text = "Invalid target input. Please enter a valid integer."

func _on_enter_pressed() -> void:
	# Parse the entered text into an array of integers
	var new_text = line_edit.text
	var new_array = _parse_input(new_text)
	if new_array.size() > 0:
		array = new_array
		_create_visual_array()  # Recreate visual representation with the new array
	else:
		warning_label.text = "Invalid input. Please enter a comma-separated list of numbers."


func _parse_input(text):
	var new_array = []
	var elements = text.split(",")  # Split input by commas

	for elem in elements:
		elem = elem.strip_edges()  # Remove any extra spaces
		if elem.is_valid_int():
			new_array.append(int(elem))
		else:
			warning_label.text = "Invalid input: " + elem
	
	return new_array
	start_button.disabled = false

func _is_index_in_bounds(index):
	return index >= 0 and index < array_labels.size()


func _bubble_sort():
	var n = array.size()
	for i in range(n - 1):
		for j in range(n - i - 1):
			# Highlight the elements being compared
			_highlight_elements(j, j + 1)
			await get_tree().create_timer(1.5).timeout  # Wait for a bit to visualize the comparison

			if array[j] > array[j + 1]:
				# Swap in the array
				var temp = array[j]
				array[j] = array[j + 1]
				array[j + 1] = temp
				
				# Swap the labels visually
				_swap_visual_elements(j, j + 1)
				await get_tree().create_timer(1.5).timeout  # Wait for a bit to visualize the swap

			# Reset the colors
			_reset_element_colors(j, j + 1)

	# Re-enable the button after the sorting is done
	start_button.disabled = false

func _highlight_elements(index1, index2):
	array_labels[index1].modulate = Color(0.39, 0.58, 0.93)  # Cornflower Blue
	array_labels[index2].modulate = Color(0.39, 0.58, 0.93)  # Cornflower Blue

func _reset_element_colors(index1, index2):
	array_labels[index1].modulate = Color(1, 1, 1)  # White
	array_labels[index2].modulate = Color(1, 1, 1)  # White

func _swap_visual_elements(index1, index2):
	var temp_label = array_labels[index1]
	array_labels[index1] = array_labels[index2]
	array_labels[index2] = temp_label

	# Update the visual container
	container.move_child(array_labels[index1], index1)
	container.move_child(array_labels[index2], index2)
	
	start_button.disabled = false
	
func _binary_search_visualize(target):
	var low = 0
	var high = array.size() - 1

	while low <= high:
		var mid = (low + high) / 2  # Use integer division for index

		# Ensure indices are within bounds
		if _is_index_in_bounds(low) and _is_index_in_bounds(mid) and _is_index_in_bounds(high):
			# Highlight low, mid, and high
			_highlight_binary_search_elements(low, mid, high)
			await get_tree().create_timer(1.0).timeout  # Add a delay to visualize this step

			if array[mid] == target:
				warning_label.text = "Element found at index: " + str(mid)
				return mid
			elif array[mid] < target:
				low = mid + 1
			else:
				high = mid - 1

			# Reset colors after each step
			_reset_binary_search_colors(low, mid, high)
			await get_tree().create_timer(1.0).timeout  # Add another delay for resetting colors
		else:
			warning_label.text = "Error: Index out of bounds."
			break
		
	warning_label.text = "Element not found"
	start_button.disabled = false
	return -1


func _highlight_binary_search_elements(low, mid, high):
	array_labels[low].modulate = Color(0, 1, 0)  # Green for low
	array_labels[mid].modulate = Color(0.7, 0.8, 1)  # Yellow for mid
	array_labels[high].modulate = Color(0, 0, 1)  # Blue for high

func _reset_binary_search_colors(low, mid, high):
	array_labels[low].modulate = Color(1, 1, 1)  # White
	array_labels[mid].modulate = Color(1, 1, 1)  # White
	array_labels[high].modulate = Color(1, 1, 1)  # White    


func _on_close_requested() -> void:
	visualizer.hide()
	
	
