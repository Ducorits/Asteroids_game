extends Node
#
#func _physics_process(_delta: float) -> void:
	#var parent = get_parent()
	#if not parent: return
	#var screen_size := get_viewport().get_visible_rect().size
	#var pos = parent.global_position
#
	#if pos.x < -screen_size.x / 2:
		#pos.x = screen_size.x / 2
	#elif pos.x > screen_size.x / 2:
		#pos.x = -screen_size.x / 2
	#if pos.y < -screen_size.y / 2:
		#pos.y = screen_size.y / 2
	#elif pos.y > screen_size.y / 2:
		#pos.y = -screen_size.y / 2
#
	#if parent.global_position != pos:
		#parent.global_position = pos
