extends Area2D

class_name  Door
@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@onready var spawn = $spawn


#func _on_body_entered(body):
	#if body is Player:
		#NavigationManager.go_to_level(destination_level_tag, destination_door_tag)


func _on_body_entered(body):
	if body is Player:
		var new_scene = "res://scenes/" + destination_level_tag + ".tscn"
		get_tree().change_scene_to_file(new_scene)
