extends Camera2D

@onready var player: Player = $"../Player"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = player.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position = lerp(global_position, player.global_position, delta * 8)
	position.x = clamp(position.x, player.global_position.x - 64, player.global_position.x + 64)
	position.y = clamp(position.y, player.global_position.y - 64, player.global_position.y + 64)
