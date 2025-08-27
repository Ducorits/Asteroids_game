extends Node

var effects = {}
var effects_path = "res://effects/particles/"

func _ready():
	var dir = DirAccess.open(effects_path)
	if dir:
		for file_name in dir.get_files():
			if file_name.ends_with(".tscn"):
				var effect_name = file_name.get_basename()
				effects[effect_name] = load(effects_path + file_name)
	print(effects)

func spawn(effect_name: String, position: Vector2, options: Dictionary = {}):
	#print("Spawning effect: ", effect_name, " at ", position)
	if not effects.has(effect_name):
		push_warning("Unknown effect: %s" % effect_name)
		return
		
	var effect = effects[effect_name].instantiate()
	effect.global_position = position
	
	if options.has("scale"):
		effect.scale = Vector2.ONE * options["scale"]
	if options.has("rotation"):
		effect.rotation = options["rotation"]
	if options.has("color") and effect.has_method("set_modulate"):
		effect.set_modulate(options["color"])
	
	add_child(effect)
