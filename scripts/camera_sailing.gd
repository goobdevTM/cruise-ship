extends Camera2D

@onready var ship_model: Node2D = $"../Ship/Model"
@onready var ship: Ship = $"../Ship"

var target_zoom : float = 2

func _ready() -> void:
	global_position = ship_model.global_position

func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, ship_model.global_position + (ship.transform.x * clamp(ship.forward_vel / ship.max_speed, 0.25, 2) * (60 / target_zoom)), delta * 8)

	if Input.is_action_just_released("zoom_in"):
		target_zoom *= 1.1
	
	if Input.is_action_just_released("zoom_out"):
		target_zoom *= 0.9
		
	target_zoom = clamp(target_zoom, 1, 4)
	zoom = lerp(zoom, Vector2(target_zoom, target_zoom), delta * 20)
