extends CharacterBody2D

const MAX_SPEED =600.0
const DECELERATION = 20.0
const ACCELERATION = 50.0
const BASE_STRENGTH = 1 

var strength = BASE_STRENGTH
var speed 
var sanity = 100
var sound = 10


func _physics_process(delta):
	
	var horizontal_direction = Input.get_axis("left", "right")
	var vertical_direction = Input.get_axis("up", "down")
	
	if horizontal_direction:
		velocity.x = move_toward(velocity.x,horizontal_direction * MAX_SPEED,ACCELERATION)
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
		
	if vertical_direction:
		velocity.y = move_toward(velocity.y,vertical_direction * MAX_SPEED,ACCELERATION)
	else:
		velocity.y = move_toward(velocity.y, 0, DECELERATION)
	
	move_and_slide()
	
