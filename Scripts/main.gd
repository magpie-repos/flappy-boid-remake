extends Node2D

##Bird Vars
@onready var bird_scene: PackedScene = preload("res://Scenes/bird.tscn")
var bird: Bird
var bird_start_pos: Vector2 = Vector2( 32, 128) 

var score: int = 0
var hi_score: int = 0

#Refs
@onready var pipe_manager: Node2D = $PipeManager
@onready var score_ui: Label = $UI/MarginContainer/Score
@onready var pause_manager: PauseManage = $PauseManager
@export var pause_timer: Timer

func spawn_bird(bird_scene: PackedScene, pos: Vector2) -> Bird:
	var bird = bird_scene.instantiate()
	bird.position = pos
	bird.died.connect(_on_bird_died)
	add_child(bird)
	return bird
	
func _ready() -> void:
	bird = spawn_bird(bird_scene, bird_start_pos)
	update_score(hi_score, score, score_ui)	

func _on_pipe_cleared() -> void:
	score += 1
	$PipeClearSFX.play()
	if score > hi_score:
		hi_score = score
	update_score(hi_score, score, score_ui)

func update_score(hi_score: float, score: float, ui_label: Label) -> void:
	var score_text = str(score) + "/" + str(hi_score)
	ui_label.text = score_text

func reset_game() -> void:
	pipe_manager.clear_pipes()
	score = 0
	update_score(hi_score, score, score_ui)
	bird = spawn_bird(bird_scene, bird_start_pos)
	pause_manager.pause_game()	

func _on_bird_died():
	$LoseSFX.pitch_scale = randf_range(0.95, 1.05)
	$LoseSFX.play()
	$PipeClearSFX.stop()
	#Remove old bird
	bird.died.disconnect(_on_bird_died)
	bird.queue_free()
	reset_game()
