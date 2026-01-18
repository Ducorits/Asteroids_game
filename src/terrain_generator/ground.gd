extends TileMapLayer

@export var sound_player: AudioStreamPlayer2D
@export var hit_sound: AudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("tiles")
	sound_player.stream = hit_sound


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_hit(damage: float, tile_position: Vector2i):
	var tile = local_to_map(to_local(tile_position))
	set_cell(tile, -1, Vector2i(0, 0))
	print("tile: ", tile)
	sound_player.play()
