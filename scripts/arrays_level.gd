extends Node2D

@export var player_scene_path: String = "res://scenes/Player.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)
	var player_scene = preload("res://scenes/Player.tscn").instantiate()
	add_child(player_scene)	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)

