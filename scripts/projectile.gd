extends Area2D

@export var speed: float = 800.0
var direction: Vector2 = Vector2.ZERO
var damage: float = 3.0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

# func _on_body_entered(body: Node) -> void:
# 	if body.is_in_group("asteroid"):
# 		if body.has_method("on_hit"):
# 			body.on_hit(damage)
# 			Vfx.spawn("projectile_hit", position, { "rotation": rotation})
# 		queue_free()

# 	if body.is_in_group("tiles"):
# 		if body.has_method("on_hit"):
# 			body.on_hit(damage, position + (direction * 9))
# 			Vfx.spawn("projectile_hit", position, { "rotation": rotation})
# 		queue_free()

func _on_timer_timeout() -> void:
	Vfx.spawn("projectile_hit", position, { "rotation": rotation + PI})
	queue_free()

var _radius: float = 8.0

func _ready() -> void:
		var cs = $CollisionShape2D
		if cs and cs.shape and cs.shape is CircleShape2D:
				_radius = cs.shape.radius

# func _physics_process(delta: float) -> void:
# 		var motion = direction * speed * delta
# 		# Query the physics space by sweeping this circle along motion
# 		var space = get_world_2d().direct_space_state
# 		var shape = CircleShape2D.new()
# 		shape.radius = _radius
# 		var params = PhysicsShapeQueryParameters2D.new()
# 		params.shape = shape
# 		params.transform = Transform2D(0, position)
# 		params.motion = motion
# 		# optional: params.collision_mask = ...
# 		var hits = space.intersect_shape(params, 8) # up to 8 hits

# 		for hit in hits:
# 				var collider = hit.collider
# 				var point: Vector2 = hit.position
# 				if collider.is_in_group("tiles"):
# 						var tile_position = _point_to_tile_position(collider, point)
# 						if collider.has_method("on_hit"):
# 								collider.on_hit(damage, tile_position)
# 						Vfx.spawn("projectile_hit", position, { "rotation": rotation })
# 						queue_free()
# 						return
# 				elif collider.is_in_group("asteroid"):
# 						if collider.has_method("on_hit"):
# 								collider.on_hit(damage)
# 						Vfx.spawn("projectile_hit", position, { "rotation": rotation })
# 						queue_free()
# 						return

		# no collision: move normally
		# position += motion

func _point_to_tile_position(tile_layer: Node, world_point: Vector2) -> Vector2:
		var tc = tile_layer.to_local(world_point)
		return tc

func _on_body_shape_entered(
		body_rid: RID,
		body: Node,
		body_shape_index: int,
		local_shape_index: int
		) -> void:
		if body is TileMapLayer:
				var tilemap := body as TileMapLayer

				var cell: Vector2i = tilemap.get_coords_for_body_rid(body_rid)
				print(cell)

				if cell != Vector2i(-1, -1):
						tilemap.erase_cell(cell)
						queue_free() # destroy projectile
