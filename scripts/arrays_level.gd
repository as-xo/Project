extends Node2D

@onready var level_manager = load("res://Global/level_manager.gd").new()

func _ready():
	add_child(level_manager) # Add the level manager to the scene tree
	level_manager.setup_level() # Call the setup function from the level manager
