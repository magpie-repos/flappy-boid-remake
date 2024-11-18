extends Node2D
class_name PauseManage

var paused: bool = true
@export var score_label: Label
@export var pause_ui: Control

func _ready() -> void:
	pause_game()
	
func _process(delta: float) -> void:
	if paused:
		if Input.is_action_just_pressed("flap") || Input.is_action_just_pressed("pause"):
			unpause_game()
	else:
		if Input.is_action_just_pressed("pause"):
			pause_game()
		

func pause_game() -> void:
	paused = true
	get_tree().paused = true
	pause_ui.show()
	
func unpause_game() -> void:
	paused = false
	get_tree().paused = false
	pause_ui.hide()
