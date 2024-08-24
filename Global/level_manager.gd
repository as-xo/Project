extends Node

@export var player_scene_path: String = "res://scenes/Player.tscn"

# Function to set up the level and spawn the player
func setup_level():
	# Check if a specific spawn door tag is set
	if NavigationManager.spawn_door_tag != null:
		_on_level_spawn(NavigationManager.spawn_door_tag)

	# Load and add the player to the scene
	var player_scene = preload("res://scenes/Player.tscn").instantiate()
	add_child(player_scene)

# Function to handle player spawning based on door tags
func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/door_" + destination_tag
	var door = get_node(door_path) as Door
	NavigationManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
