extends CharacterBody2D


const MAX_SPEED =600.0
const DECELERATION = 20.0
const ACCELERATION = 50.0
@onready var shape = $CollisionShape2D.shape
@onready var character = $"../enemy"
var tile_map

#func get_clicked_tile_power():

#	var clicked_cell = tile_map.local_to_map(tile_map.get_local_mouse_position())
#	var data = tile_map.get_cell_tile_data(0, clicked_cell)
#	if data:
#		return data.get_custom_data("power")
#	else:
#		return 0


#func _input(event):
#	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
#		var icon = get_parent().get_node("Icon").texture.get_image()
#		var local_mpos = icon.to_local(position)
#		if icon.get_rect().has_point(local_mpos):
#			print(icon.get_pixel(local_mpos.x,local_mpos.y))

var isOnSprite: bool = false
var current_area


func get_color(area: Area2D):
	if area:
		var local_pos = area.get_node("surface").to_local(position)
		var image = area.get_node("surface").texture.get_image()
		#$Sprite2D.texture.get_image().fill(image.get_pixelv(local_pos))
		
		return image.get_pixelv(local_pos)
	else:
		return null


func area_entered(area: Area2D):
	current_area = area
	

func _ready():
	$Area2D.connect("area_entered",area_entered)
	
	

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			if current_area:
				$Sprite2D.material.set_shader_parameter("color",get_color(current_area))
				#print(material.get_shader_parameter("color"))
		#if event.keycode == KEY_P:
		#	character = 
			
		

func _physics_process(delta):
	queue_redraw()
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
	if get_slide_collision_count():
		if get_slide_collision(0).get_collider().get_name() == "Enemy":
			pass
	


func _on_sensefield_body_exited(body):
	pass # Replace with function body.
