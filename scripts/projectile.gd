extends Area2D

@export var speed: float = 100.0
var direction: Vector2 = Vector2.ZERO
var damage: float = 3.0
signal spawn_particle(global_position: Vector2, name: String)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

	# Optional: wrap around or queue_free if off-screen
	#var screen_size = get_viewport().get_visible_rect().size
	#if position.x < -screen_size.x / 2 or position.x > screen_size.x / 2 or position.y < -screen_size.y / 2 or position.y > screen_size.y / 2:

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("asteroid"):
		if body.has_method("on_hit"):
			body.on_hit(damage)
			Vfx.spawn("projectile_hit", position, { "rotation": rotation})
		queue_free()


func _on_timer_timeout() -> void:
	Vfx.spawn("projectile_hit", position, { "rotation": rotation + PI})
	queue_free()
