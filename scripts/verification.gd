extends Node

@onready var code_edit = $"../ColorRect2/CodeEdit"
@onready var dialogue_label = $OutputLabel/DialogueLabel


func check_code(player_code: String) -> bool:
	var has_sort = player_code.find("sort") != -1
	var has_binary_search = player_code.find("binary_search") != -1
	
	return has_sort and has_binary_search

func execute_player_code(player_code: String) -> bool:
	# Check if the code contains the required functions before execution
	if not check_code(player_code):
		dialogue_label.text = "Code must contain 'sort' and 'binary_search' methods."
		return false
	
	var script := GDScript.new()
	script.source_code = player_code		
	
	var error = script.reload()
	if error != OK:
		dialogue_label.text = "Error loading script. Please check for syntax errors."
		print("Error loading script:", error)
		return false
		
	var instance = script.new()

	# Check if the instance has the required methods before execution
	if not (instance.has_method("sort") and instance.has_method("binary_search")):
		dialogue_label.text = "Code must define 'sort' and 'binary_search' methods."
		return false

	# Handle potential runtime errors with defensive programming
	var sorted_array = []
	var search_result = -1
	
	if instance.has_method("sort"):
		sorted_array = instance.call("sort", [3, 1, 2])
		if sorted_array == []:
			dialogue_label.text = "Error executing 'sort' method or it returned an unexpected result."
			return false
	else:
		dialogue_label.text = "Method 'sort' failed to execute."
		return false
	
	if instance.has_method("binary_search"):
		search_result = instance.call("binary_search", sorted_array, 1)
		if search_result == -1:
			dialogue_label.text = "Error executing 'binary_search' method or it returned an unexpected result."
			return false
	else:
		dialogue_label.text = "Method 'binary_search' not found."
		return false

	if sorted_array == [1, 2, 3] and search_result == 0:
		dialogue_label.text = "Well done, code is correct!"
		return true
	else:
		dialogue_label.text = "Code is incorrect or produced an unexpected result."
		return false

func _on_button_pressed():
	var player_code = code_edit.text
	var result = execute_player_code(player_code)
	
	if result:
		print("Code is correct!")
	else:
		print("Code is incorrect or produced an unexpected result.")
