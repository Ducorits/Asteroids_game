extends Area2D

@export var speed: float = 600.0
var direction: Vector2 = Vector2.ZERO
var damage: float = 1.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

	# Optional: wrap around or queue_free if off-screen
	#var screen_size = get_viewport().get_visible_rect().size
	#if position.x < -screen_size.x / 2 or position.x > screen_size.x / 2 or position.y < -screen_size.y / 2 or position.y > screen_size.y / 2:

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("asteroid"):
		if body.has_method("on_hit"):
			body.on_hit(damage)
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
