extends Node


const BASE_HEALTH = 10
const BASE_SPEED = 200
const BASE_SENSE_RADIUS = 100

enum {UNAWARE,VIGILANT,AWARE}

var health = BASE_HEALTH
var sense_radius = BASE_SENSE_RADIUS
var weapon = null
var awareness_level = UNAWARE
var player_last_seen_position: Vector2
var patrol_route: Path2D
var path = []
var path_to_last_seen = []



func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func create_path(posA,posB):
	pass

func follow_path(path):
	pass
	
func pursue_player():
	pass

func investigate():
	pass

func patrol():
	pass

func lose_sight():
	pass

func attack():
	#gonna differ based on enemy types and weapons
	pass

func die():
	pass
	
	
