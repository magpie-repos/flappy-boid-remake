extends Node2D

@export var hill_l: Sprite2D
@export var hill_m: Sprite2D
@export var hill_s: Sprite2D

var scroll_speed: float = 50
@onready var window_size: Vector2 = get_viewport().size

func _process(delta: float) -> void:
	hill_l.position += (scroll_speed / 3) * Vector2.LEFT * delta
	hill_m.position += (scroll_speed / 2) * Vector2.LEFT * delta
	hill_s.position += (scroll_speed / 1.2) * Vector2.LEFT * delta

	if hill_l.position.x + 50 <= 0:
		hill_l.position.x = window_size.x + 50
	if hill_m.position.x + 30 <= 0:
		hill_m.position.x = window_size.x + 30
	if hill_s.position.x + 20 <= 0:
		hill_s.position.x = window_size.x + 20
