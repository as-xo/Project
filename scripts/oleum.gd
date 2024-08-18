extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
#@onready var actionable_finder = $Direction/ActionableFinder

var is_talking = false

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Nathan"):
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/Oleum.dialogue"), "start")
		return
	
		
func _physics_process(_delta):	
	if is_talking:
		animated_sprite.play("talk")
	else:
		animated_sprite.play("idle")


func _on_label_hidden():
	pass # Replace with function body.
