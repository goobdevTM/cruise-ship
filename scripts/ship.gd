extends CharacterBody2D
class_name Ship

@onready var ship_shadow: Sprite2D = $"../ShipShadow"
@onready var sprite: Sprite2D = $Model/Sprite
@onready var model: Node2D = $Model
@onready var minimap_icon: TextureRect = $"../GUI/Minimap/Icon"

var forward_vel : float = 0
var max_speed : float = 35
var accel_speed : float = 0.5
var decel_speed : float = 0.4
var turn_vel : float = 0
var max_turn_speed : float = 1
var turn_sharpness : float = 2

func _physics_process(delta: float) -> void:
	if Input.get_axis("back", "forward") != 0:
		forward_vel = lerp(forward_vel, max_speed * Input.get_axis("back", "forward"), delta * accel_speed)
	else:
		forward_vel = lerp(forward_vel, 0.0, delta * decel_speed)
	forward_vel = clamp(forward_vel, -max_speed / 2, max_speed)
	turn_vel = lerp(turn_vel, Input.get_axis("left", "right") * 0.2, delta * turn_sharpness)
	rotation += turn_vel * delta
	velocity = transform.x * forward_vel
	

	move_and_slide()
	ship_shadow.global_position = sprite.global_position
	ship_shadow.global_rotation = sprite.global_rotation
	ship_shadow.position.y += 2
	position.x = clamp(position.x, 12, 8180)
	position.y = clamp(position.y, 12, 8180)
	
	minimap_icon.position = round((global_position / (8192)) * 64) + Vector2(-10,6)
