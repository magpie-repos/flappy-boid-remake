extends StaticBody2D

var pipe_min_spread: float = 50
var pipe_max_spread: float = 85

@onready var top_pipe: CollisionShape2D = $TopPipe
@onready var bottom_pipe: CollisionShape2D = $BottomPipe

var cleared: bool = false

func _ready() -> void:
	var pipe_gap_size: float = randf_range(pipe_min_spread, pipe_max_spread)
	
	top_pipe.position.y -= 85 + (pipe_gap_size / 2)
	bottom_pipe.position.y += 85 + (pipe_gap_size / 2)
	
	add_to_group("death_zone")
	
