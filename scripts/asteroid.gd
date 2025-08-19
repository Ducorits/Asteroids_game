extends RigidBody2D

@export var min_speed := 50.0
@export var max_speed := 350.0
@export_enum("large", "medium", "small") var size: String = "large"
@export var base_speed: float = 100.0
@export var health: int = 10
var scale_modifier: float = 1.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal request_split(global_position: Vector2, current_size: String)

@onready var hit_sound := $CollideSound as AudioStreamPlayer2D
@export var light_hit: AudioStream
@export var heavy_hit: AudioStream

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		var impulse := state.get_contact_impulse(i)
		var collider := state.get_contact_collider_object(i)

		if collider and collider.is_in_group("asteroid"):
			if impulse.length() < 0.01:
				continue
			hit_sound.pitch_scale = randf_range(0.95, 1.05)
			hit_sound.stream = light_hit if impulse.length() < 40 else heavy_hit
			hit_sound.play()

func on_hit(damage: float) -> void:
	if health > 0:
		health -= damage
		hit_sound.play()
	else:
		animation_player.play("destroy")
		Vfx.spawn("explosion", position, {"scale": scale_modifier})
		emit_signal("request_split", global_position, size)

func initialize():
	var speed := base_speed
	var collision_radius = $CollisionShape2D.shape.radius
	var sprite_scale = $Sprite2D.scale
	match size:
		"large":
			scale_modifier = 1.0
			speed *= 1.0
			mass = 3.0
		"medium":
			scale_modifier = 0.75
			speed *= 1.0
			mass = 1.5
			health *= scale_modifier
		"small":
			scale_modifier = 0.5
			speed *= 1.0
			mass = 0.75
			health *= scale_modifier
		
	$Sprite2D.scale = sprite_scale * scale_modifier
	_resize_collision(collision_radius * scale_modifier)

	angular_damp = 0.1 + (1.0 / mass)
	linear_velocity = Vector2(randf_range(-1,1), randf_range(-1,1)).normalized() * speed


func _resize_collision(new_radius: float) -> void:
	var circle = $CollisionShape2D.shape as CircleShape2D
	circle.radius = new_radius

func _ready() -> void:
	add_to_group("asteroid")
	
