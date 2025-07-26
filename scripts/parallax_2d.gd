extends Parallax2D

@export var star_scene: PackedScene
@export var stars: int = 100

func spawn_stars():
	for i in stars:
		var star = star_scene.instantiate() as AnimatedSprite2D
		star.global_position = Vector2(randf_range(-1000, 1000), randf_range(-1000, 1000))
		add_child(star)
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_stars()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
