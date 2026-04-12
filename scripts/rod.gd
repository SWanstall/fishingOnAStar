extends Sprite2D

var mouse_position = null

@onready var rigid_body_2d = $RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)
	
	if Input.is_action_just_pressed("rmb"):
		print($RigidBody2D.linear_velocity)
