extends Node2D

var scroll_speed: float = 100 
var pipe_scene: PackedScene = preload("res://pipe.tscn")
var loaded_pipes: Array[StaticBody2D]
var bird_pos: Vector2 = Vector2.ZERO
var pipe_offset: float = 50

signal pipe_cleared

func _ready() -> void:
	$PipeSpawnTimer.timeout.emit()
	$PipeSpawnTimer.start()

func _process(delta: float) -> void:
	scroll_pipes(loaded_pipes, delta)

func spawn_pipe(pipe_scene: PackedScene, window_size: Vector2):
	var pipe = pipe_scene.instantiate()
	#Spawn pipe off right side of screen, centered along the y
	pipe.position = Vector2(window_size.x + 50, window_size.y / 2)
	pipe.position.y += randf_range(pipe_offset * -1, pipe_offset) 
	add_child(pipe)
	return pipe

func scroll_pipes(pipe_array: Array[StaticBody2D], delta: float) -> void:
	for p in pipe_array:
		if p:
			p.position += Vector2.LEFT * scroll_speed * delta
			
			##Check if player has passed the pipe
			if p.position.x - 20 < bird_pos.x && not p.cleared:
				#Set flags and emit signal for main to pickup
				p.cleared = true
				pipe_cleared.emit()
			##Delete pipe once it has scrolled off screen
			if loaded_pipes[0].position.x + 50 <= 0:
				loaded_pipes[0].queue_free()
				loaded_pipes.remove_at(0)

func clear_pipes() -> void:
	for p in loaded_pipes:
		p.queue_free()
		
	loaded_pipes = []
	$PipeSpawnTimer.timeout.emit()
	$PipeSpawnTimer.start()

func _on_pipe_spawn_timer_timeout() -> void:
	loaded_pipes.append(spawn_pipe(pipe_scene, get_viewport().size))
