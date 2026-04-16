extends Sprite2D

var mouse_position = null

@onready var character_body_2d = $CharacterBody2D

@export var hook_scene: PackedScene

var prev_pos: Vector2
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_global_mouse_position()
	look_at(mouse_position)

func _physics_process(delta):
	var current_pos = character_body_2d.global_position
	velocity = (current_pos - prev_pos) / delta
	prev_pos = current_pos
	
	if Input.is_action_just_pressed("rmb"):
		print(velocity)
		var hook = hook_scene.instantiate()

		var rod_tip_position = character_body_2d.global_position

		# Spawn the mob by adding it to the Main scene.
		add_child(hook)
