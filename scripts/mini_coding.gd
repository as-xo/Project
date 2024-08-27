extends Node2D

@onready var level_manager = load("res://Global/level_manager.gd").new()

func _ready():
	add_child(level_manager) 
	level_manager.setup_level() 
