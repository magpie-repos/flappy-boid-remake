extends RigidBody2D
class_name Bird

var jump_height: float = 20

signal died

@onready var window_size: Vector2 = get_viewport().size
@onready var bird_size: Vector2 = $Sprite2D.texture.get_size()

func _ready() -> void:
	##Enable tracking to get direct collision information
	set_contact_monitor(true)
	set_max_contacts_reported(1)
	
	add_to_group("bird")

func _physics_process(delta: float) -> void:
	##Handle player input for bird movement
	if Input.is_action_just_pressed("flap") && $FlapCooldown.is_stopped():
		apply_impulse(Vector2.UP * jump_height)##Move bird up
		$FlapCooldown.start()##Prevent jump spam

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("death_zone"):
		died.emit()
