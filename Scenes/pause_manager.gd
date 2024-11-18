extends Node2D

var paused: bool = true
@export var score_label: Label
@export var press_space_label: Label

func _ready() -> void:
	pause_game()
	
func _process(delta: float) -> void:
	if paused:
		if Input.is_action_just_pressed("flap"):
			unpause_game()

func pause_game() -> void:
	paused = true
	get_tree().paused = true
	score_label.hide()
	press_space_label.show()
	
func unpause_game() -> void:
	paused = false
	get_tree().paused = false
	score_label.show()
	press_space_label.hide()
