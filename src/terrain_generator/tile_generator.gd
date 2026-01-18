class_name TileGenerator extends Node2D

@export var noise_texture : Sprite2D
@export var ground_tile_layer : TileMapLayer

@export var width : int
@export var height : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var x_offset = (noise_texture.texture.get_width() / width)
	var y_offset = (noise_texture.texture.get_height() / height)

	for x in range(width):
		for y in range(height):
			var i : int = x_offset * x
			var j : int = y_offset * y

			var noise_value : float = noise_texture.texture.noise.get_noise_2d(i, j)

			if (noise_value >= 0.2):
				ground_tile_layer.set_cell(Vector2(x, y), 0 , Vector2(0, 0))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
