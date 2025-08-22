extends RigidBody2D


const SPEED = 100.0
const TURN_SPEED = 5

@export var projectile_scene: PackedScene
@export var fire_cooldown: float = 0.2
@onready var hit_sound := $HitSound as AudioStreamPlayer2D

var can_fire = true
var just_shot = false
var mouse_enabled: bool = true
var target_angle: float = 0

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in range(state.get_contact_count()):
		var impulse := state.get_contact_impulse(i)
		var collider := state.get_contact_collider_object(i)

		if collider and collider.is_in_group("asteroid"):
			if impulse.length() < 1:
				continue
			hit_sound.pitch_scale = randf_range(0.95, 1.05)
			hit_sound.play()

func _ready() -> void:
	linear_damp = 1.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and just_shot:
		%ShootSFX.pitch_scale = randf_range(1.0, 1.1)
		%ShootSFX.play()
		just_shot = false

func _physics_process(delta: float) -> void:
	var up := Vector2.UP
	var down := Vector2.DOWN
	var left := Vector2.LEFT
	var right := Vector2.RIGHT

	var move_up := Input.is_action_pressed("move_up")
	var move_down := Input.is_action_pressed("move_down")
	var move_left := Input.is_action_pressed("move_left")
	var move_right := Input.is_action_pressed("move_right")
	
	var move_dir := Vector2.ZERO
	
	if move_up:
		move_dir += up * SPEED * delta
	if move_down:
		move_dir += down * SPEED * delta
	if move_left:
		move_dir += left * SPEED * delta
	if move_right:
		move_dir += right * SPEED * delta

	move_dir = move_dir.normalized()
	if linear_velocity.length() < 1000.0:
		apply_impulse(move_dir * SPEED * delta)
		
	var mouse_pos = (get_global_mouse_position() - global_position)
	if mouse_enabled:
		target_angle = (mouse_pos).angle() + PI / 2
	if Input.is_action_pressed("rotate_left"):
		target_angle = target_angle - 5 * delta
	if Input.is_action_pressed("rotate_right"):
		target_angle = target_angle + 5 * delta
	rotation = lerp_angle(rotation, target_angle, delta * 10)  # Turn speed
		
	if Input.is_action_pressed("toggle_mouse"):
		mouse_enabled = !mouse_enabled
	
	if Input.is_action_pressed("shoot") and can_fire:
		shoot_projectile()
		just_shot = true
		can_fire = false
		await get_tree().create_timer(fire_cooldown).timeout
		can_fire = true

func shoot_projectile():
	var projectile = projectile_scene.instantiate()
	get_parent().add_child(projectile)

	# Spawn in front of the player
	var forward = Vector2.UP.rotated(rotation)
	projectile.global_position = global_position + forward * 20
	projectile.rotation = rotation
	projectile.direction = forward
