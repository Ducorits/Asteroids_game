extends Node

var projectiles = {}
var projectiles_path = "res://scenes/projectiles/"

func _ready():
	var dir = DirAccess.open(projectiles_path)
	if dir:
		for file_name in dir.get_files():
			if file_name.ends_with(".tscn"):
				var projectile_name = file_name.get_basename()
				projectiles[projectile_name] = load(projectiles_path + file_name)
	print(projectiles)

func spawn(weapon: WeaponData , position: Vector2, options: Dictionary = {}):
	if not projectiles.has(weapon.projectile_name):
		push_warning("Unknown projectile: %s" % weapon.projectile_name)
		return
		
	var projectile = projectiles[weapon.projectile_name].instantiate()
	projectile.global_position = position
	
	projectile.damage = weapon.damage
	projectile.speed = weapon.speed
	
	if options.has("owner"):
		projectile.owner = options["owner"]
	if options.has("direction"):
		projectile.direction = options["direction"]
	if options.has("scale"):
		projectile.scale = Vector2.ONE * options["scale"]
	if options.has("rotation"):
		projectile.rotation = options["rotation"]
	if options.has("color") and projectile.has_method("set_modulate"):
		projectile.set_modulate(options["color"])
	
	add_child(projectile)
