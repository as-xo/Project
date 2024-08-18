extends CharacterBody2D

class_name Player

const speed = 130.0
const JUMP_VELOCITY = -300.0

@onready var b_search_label = $"../BinarySearchPcode/BSearchLabel"
@onready var label = $"../BubbleSortPcode/Label"
@onready var animated_sprite = $AnimatedSprite2D
var player_state

func _ready():
	NavigationManager.on_trigger_player_spawn.connect(_on_spawn)
	if is_instance_valid(label): 
		print("Label is valid. Hiding label.")
		label.hide() # would not work without the print statements. I'm afraid to change it :'(
	else:
		print("Label is NOT valid.")
	
	if is_instance_valid(b_search_label):
		print("Binary Search Label is valid. Hiding label.")
		b_search_label.hide()
	else:
		print("Binary Search Label is NOT valid.")	

	
func _on_spawn(position: Vector2, direction: String):
	global_position = position
	animated_sprite.play(player_movement(direction))	

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	else:
		player_state = "run"
		
		
	velocity = direction * speed		
	move_and_slide()	
	player_movement(direction)
	
func player_movement(dir):
	if player_state == "idle":
		animated_sprite.play("idle")
	elif player_state == "run":
		animated_sprite.play("run")
		if dir.x < 0:
			animated_sprite.flip_h = true
		elif dir.x > 0:
			animated_sprite.flip_h = false
	
func player():
	pass
	

func _on_area_2d_body_entered(body):
	label.show()


func _on_area_2d_body_exited(body):
	label.hide()


func _on_binary_search_pcode_body_entered(body):
	b_search_label.show() 


func _on_binary_search_pcode_body_exited(body):
	b_search_label.hide()
