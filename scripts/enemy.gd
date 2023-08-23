extends CharacterBody2D

@export var SENSE_AREA: Vector2 = Vector2(2,2)
enum {INVESTIGATING,IDLE,FOUND,LOSTSIGHT,FOLLOWING}

const MASS = 10.0
const ARRIVE_DISTANCE = 10.0
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var _path = PackedVector2Array()
var _next_point = Vector2()

var _velocity = Vector2()
var last_known_location
var _click_position

var status = IDLE
var ray
@onready var _tile_map = $"../TileMap"

func _ready():
	ray = $RayCast2D
	ray.enabled = false
	

func _physics_process(delta):
	
	if status == INVESTIGATING:
		pass
	
	if status == FOLLOWING:
		
		ray.target_position = to_local(get_parent().get_node("player").position)
		velocity = (to_global(ray.target_position)- position).normalized()*SPEED
		last_known_location = ray.target_position
		move_and_slide()
		if ray.is_colliding() and ray.get_collider().get_name() !="player":
			status = LOSTSIGHT
	
	if status==LOSTSIGHT:
		
		if ray.is_colliding() and ray.get_collider().get_name() =="player":
			status = FOLLOWING
		var arrived_to_next_point = _move_to(_click_position)
		if arrived_to_next_point:
			_path.remove_at(0)
			if _path.is_empty():
				_change_state(IDLE)
				return
			_next_point = _path[0]
		
		
		
		#velocity = (to_global(ray.target_position)- position).normalized()*SPEED
		#move_and_slide()
		
	
	if IDLE:
		pass


func _move_to(local_position):
	
	var desired_velocity = (local_position - position).normalized() * SPEED
	var steering = desired_velocity - _velocity
	velocity += steering / MASS
	move_and_slide()
	rotation = _velocity.angle()
	return position.distance_to(local_position) < ARRIVE_DISTANCE



func _change_state(new_state):
	if new_state == IDLE:
		_tile_map.clear_path()
	elif new_state == LOSTSIGHT:
		
		_path = _tile_map.find_path(position, _click_position)
		if _path.size() < 2:
			_change_state(IDLE)
			return
		# The index 0 is the starting cell.
		# We don't want the character to move back to it in this example.
		_next_point = _path[1]
	status = new_state

func _on_fieldofsense_body_entered(body):
	$SearchTimeout.stop()
	if body.get_name() == "player":
		status = FOLLOWING
		ray.enabled = true

func _on_fieldofsense_body_exited(body):
	
	if body.get_name() == "player":
		$SearchTimeout.start()
		
		
func _on_search_timeout_timeout():
	print("timeout")

	ray.enabled = false
	status = IDLE
