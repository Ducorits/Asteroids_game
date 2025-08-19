extends Node2D

func _ready():
	var width = 2920
	var height = 2080
	var img = Image.create(width, height, false, Image.FORMAT_RGB8)
	img.fill(Color.BLACK)

	var rng = RandomNumberGenerator.new()
	rng.randomize()

	for i in range(500): # number of stars
		var x = rng.randi_range(0, width - 1)
		var y = rng.randi_range(0, height - 1)
		var brightness = rng.randf_range(0.6, 1.0)
		img.set_pixel(x, y, Color(brightness, brightness, brightness))

	var tex = ImageTexture.create_from_image(img)
	var sprite = Sprite2D.new()
	sprite.texture = tex
	add_child(sprite)
