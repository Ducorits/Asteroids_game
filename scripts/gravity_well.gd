extends Area2D

var bodies_in_range: Array = []
@export var gravity_strength: float = 2
@export var radius: float = 100

func _ready():
	connect("body_entered", _on_body_entered, 0)
	connect("body_exited", _on_body_exited, 0)
	$CollisionShape2D.shape.radius = radius

func _on_body_entered(body):
	if body is RigidBody2D:
		bodies_in_range.append(body)

func _on_body_exited(body):
	bodies_in_range.erase(body)

func _physics_process(delta):
	for body in bodies_in_range:
		if not body: 
			continue
		var dir = (global_position - body.global_position)
		var dist_sq = dir.length_squared()
		if dist_sq == 0:
			continue
		# Inverse-square falloff like real gravity (optional)
		var force_mag = dir.length() * gravity_strength
		var force = dir.normalized() * force_mag
		body.apply_central_force(force)
