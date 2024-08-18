extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var button = $Button
@onready var popup_scene = load("res://scenes/help.tscn")
@onready var help = $Help

var is_talking = false

func _ready():
	help.hide()

func _physics_process(_delta):	
	if is_talking:
		animated_sprite.play("talk")
	else:
		animated_sprite.play("idle")

func show_help_popup():
	var popup_instance = popup_scene.instantiate()
	add_child(popup_instance)
	# Position popup above the NPC
	popup_instance.position = global_position + Vector2(0, -popup_instance.rect_size.y)


func _on_button_toggled(toggled_on):
	if toggled_on:
		help.show()
	else:
		help.hide()	
		


func _on_help_close_requested():
	help.hide()
