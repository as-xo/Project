extends Node

@onready var code_edit = $"../ColorRect2/CodeEdit"
@onready var dialogue_label = $OutputLabel/DialogueLabel


func check_code(player_code: String) -> bool:
	var has_sort = player_code.find("sort") != -1
	var has_binary_search = player_code.find("binary_search") != -1
	
	return has_sort and has_binary_search

func execute_player_code(player_code: String) -> bool:
	var script := GDScript.new()
	script.source_code = player_code		
	
	var error = script.reload()
	if error != OK:
		print("Error loading script:", error)
		return false
		
	var instance = script.new()	
	
	if instance.has_method("sort") and instance.has_method("binary_search"):
		var sorted_array = instance.sort([3, 1, 2])
		var search_result = instance.binary_search(sorted_array, 1)

		if sorted_array == [1, 2, 3] and search_result == 0:
			dialogue_label.text = "Well done, code is correct!"
			return true
		else:
			dialogue_label.text = "Code is incorrect or produced an unexpected result."
			return false
		
	return false

func _on_button_pressed():
	var player_code = code_edit.text
	var result = execute_player_code(player_code)
	
	if result:
		print("Code is correct!")
	else:
		print("Code is incorrect or produced an unexpected result.")
		

