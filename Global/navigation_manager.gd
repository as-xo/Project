extends Node

const  scene_lobby = preload("res://scenes/main.tscn")
const scene_level = preload("res://scenes/arrays_level.tscn")
const scene_code = preload("res://scenes/mini_coding.tscn")

signal on_trigger_player_spawn 

var spawn_door_tag
var current_scene: String = "main" #
var previous_scene: String = "" #

func go_to_level(level_tag, destination_tag):
	previous_scene = current_scene #
	current_scene = level_tag #
	var scene_to_load
	
	match level_tag:
		"main":
			scene_to_load = scene_lobby
		"arrays_level":
			scene_to_load = scene_level
		"mini_coding":
			scene_to_load = scene_code	
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)	
		
func trigger_player_spawn(position: Vector2, direction : String):
	on_trigger_player_spawn.emit(position, direction)
				
func go_back():
	if previous_scene != "":
		var scene_to_load
		
		match previous_scene:
			"main":
				scene_to_load = scene_lobby
			"arrays_level":
				scene_to_load = scene_level
			"mini_coding":
				scene_to_load = scene_code	
		
		if scene_to_load != null:
			current_scene = previous_scene
			get_tree().change_scene_to_packed(scene_to_load)				
				
#func go_back():
	#if previous_scene != "":
		#current_scene = previous_scene
		#get_tree().change_scene_to_packed(get_node("/root/").get_node(previous_scene))
