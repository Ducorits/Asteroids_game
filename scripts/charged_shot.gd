extends Area2D

@export var speed: float = 1000.0
var direction: Vector2 = Vector2.ZERO
var damage: float = 6.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("asteroid"):
		if body.has_method("on_hit"):
			body.on_hit(damage)
			Vfx.spawn("projectile_hit", position, { "rotation": rotation})
		queue_free()

func _on_timer_timeout() -> void:
	Vfx.spawn("projectile_hit", position, { "rotation": rotation + PI})
	queue_free()
