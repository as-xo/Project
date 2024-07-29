extends CharacterBody2D

const speed = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite = $AnimatedSprite2D
var player_state

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
	
	
	#if Input.is_action_just_pressed("move_left"):
		#velocity.x = -speed
		#velocity.y = 0
	#elif  Input.is_action_just_pressed("move_right"):
		#velocity.x = speed
		#velocity.y = 0
	#elif Input.is_action_just_pressed("move_down"):
		#velocity.y = speed
		#velocity.x = 0		
	#elif Input.is_action_just_pressed("move_up"):
		#velocity.y = -speed
		#velocity.x = 0
	#elif Input.is_action_just_pressed("jump"):
		#velocity.y = JUMP_VELOCITY
	#else:
		#velocity.x = 0
		#velocity.y = 0	
		#
		#
	#move_and_slide()	
	

##@onready var actionable_finder = $Direction/ActionableFinder

##func _unhandled_input(_event: InputEvent) -> void:
	##if Input.is_action_just_pressed("ui_accept"):
		##var actionables = actionable_finder.get_overlapping_areas()
		##if actionables.size() > 0:
			##actionables[0].action()
			##return
#

	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
