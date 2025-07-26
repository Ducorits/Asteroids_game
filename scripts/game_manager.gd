extends Node

@export var asteroid_scene: PackedScene
@export var initial_asteroid_count: int = 20

@onready var player: RigidBody2D = %Player

func spawn_asteroid(position: Vector2, size: String):
	var asteroid = asteroid_scene.instantiate() as RigidBody2D
	asteroid.size = size
	asteroid.global_position = position
	asteroid.initialize()
	asteroid.request_split.connect(_on_asteroid_request_split)
	add_child(asteroid)

func _ready():
	for i in initial_asteroid_count:
		spawn_asteroid(Vector2(
			randf_range(-1000, 1000),  # Adjust to your screen
			randf_range(-1000, 1000)
		), "large")

func _on_asteroid_request_split(global_position: Vector2, size: String):
	var next_size = {
		"large": "medium",
		"medium": "small" 
	}.get(size, null)
	if next_size:
		for i in 2:
			spawn_asteroid(global_position, next_size)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
