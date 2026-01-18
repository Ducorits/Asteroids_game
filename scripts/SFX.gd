extends Node

var sounds = {}
var sounds_path = "res://effects/sounds/"

func _ready():
	var dir = DirAccess.open(sounds_path)
	if dir:
		for file_name in dir.get_files():
			if file_name.ends_with(".tscn"):
				var sound_name = file_name.get_basename()
				sounds[sound_name] = load(sounds_path + file_name)
	print(sounds)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
